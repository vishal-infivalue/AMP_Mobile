import 'dart:convert';
import 'dart:io';

import 'package:amp/utils/CommonFunctions.dart';
import 'package:amp/utils/global_values.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers_vm/generateOtp_provider.dart';
import '../../routes/route_names.dart';
import '../../utils/app_colors.dart';
import '../../utils/connectivity.dart';
import '../tables/pending_table.dart';


class TechnicalTest extends StatefulWidget {
  const TechnicalTest({Key? key}) : super(key: key);

  @override
  _TechnicalTestState createState() => _TechnicalTestState();
}

class _TechnicalTestState extends State<TechnicalTest> {
  String auditId = "";

  @override
  void initState() {
    super.initState();
    ConnectivityService().monitorConnection(context);
    setState(() {});
    final apiProvider = Provider.of<APIProvider>(context, listen: false);
    _loadAndFetchData(apiProvider);
  }

  // Fetch data from API and store it in SharedPreferences if not available
  void _loadAndFetchData(APIProvider apiProvider) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? responseJson = prefs.getString('ERBCustomerCheckListResponse');
    String content = "No response data available";

    GlobalVariables gb = GlobalVariables();

    auditId = gb.auditId_gb;

    Map<String, dynamic> data = {
      "id": "$auditId",
    };

    String jsonData = jsonEncode(data);
    await apiProvider.getAuditScreenData(jsonData, context);

    responseJson = jsonEncode(apiProvider.erbCustomerCheckListResponse);
    await prefs.setString('ERBCustomerCheckListResponse', responseJson);

    if (apiProvider.erbCustomerCheckListResponse.isEmpty &&
        !apiProvider.loading) {
      GlobalVariables gb = GlobalVariables();

      auditId = gb.auditId_gb;

      Map<String, dynamic> data = {
        "id": "$auditId",
      };

      String jsonData = jsonEncode(data);
      await apiProvider.getAuditScreenData(jsonData, context);

      responseJson = jsonEncode(apiProvider.erbCustomerCheckListResponse);
      await prefs.setString('ERBCustomerCheckListResponse', responseJson);

      content = responseJson;
      print("VALUE IS $content");
    }
  }

  // Load data from SharedPreferences
  Future<Map<String, dynamic>?> loadERBCustomerCheckList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? responseJson = prefs.getString('ERBCustomerCheckListResponse');

      if (responseJson != null) {
        return jsonDecode(responseJson);
      } else {
        return null;
      }
    } catch (e) {
      print("Error loading data: $e");
      return null;
    }
  }

  Map<String, Map<String, List<Map<String, dynamic>>>>
  _extractQuestionsByHeader(List<dynamic>? questions) {
    final Map<String, Map<String, List<Map<String, dynamic>>>> result = {};

    if (questions == null) return result;

    for (var question in questions) {
      final header = question['header']?.toString() ?? '';
      final subheader = question['subheader']?.toString() ?? '';
      final description = question['description'] ?? '';
      final points = question['points'] ?? 0;
      final question_value = question['question'] ?? 0;
      final savedscore = question['savedscore'] ?? 0;
      final savedremark = question['savedremark'] ?? '';
      final additionalnotes = question['additionalnotes'] ?? 0;

      if (!result.containsKey(header)) {
        result[header] = {};
      }

      if (!result[header]!.containsKey(subheader)) {
        result[header]![subheader] = [];
      }

      result[header]![subheader]!.add({
        'description': description,
        'points': points,
        'question': question_value,
        'savedscore': savedscore,
        'savedremark': savedremark,
        'additionalnotes': additionalnotes,
      });
    }

    return result;
  }

  Map<String, int?> dropdownValues = {};
  Map<String, int?> savedScoreInternal = {};

  Map<String, int?> _cumusummary = {};

  Map<String, int?> get cumusummary => _cumusummary;

  GlobalVariables gb = GlobalVariables();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ERB Technical Checklist',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: AppColors.meruRed,
            fontSize: 14.0,
            fontStyle: FontStyle.normal,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.meruWhite,
        /*leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_sharp,
              color: AppColors.meruRed),
          onPressed: () => Navigator.pop(context),
        ),*/
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: loadERBCustomerCheckList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading data: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No saved response found'));
          } else {
            Map<String, dynamic> response = snapshot.data!;
            final questionsByHeader =
            _extractQuestionsByHeader(response['questions'] ?? {});

            int currentPosition = 0;
            int totalSections = 10;

            final double progress =
            _calculateProgress(currentPosition, totalSections);

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[300],
                    color: AppColors.meruYellow,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: questionsByHeader.keys.length,
                    itemBuilder: (context, headerIndex) {
                      final header =
                      questionsByHeader.keys.elementAt(headerIndex);
                      final subheaders = questionsByHeader[header] ?? {};
                      final firstSubheader = subheaders.keys.isNotEmpty
                          ? subheaders.keys.first
                          : '';
                      final firstQuestion =
                          subheaders[firstSubheader]?.first ?? {};
                      final headerDescription =
                          firstQuestion['description'] ?? '';
                      final questionIndex = firstQuestion['question'] ?? '';

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          margin: EdgeInsets.zero,
                          elevation: 0,
                          color: AppColors.meruWhite,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.grey, // Border color
                              width: 0.4, // Border width
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ExpansionTile(
                            title: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.meruYellowF,
                                    border: Border.all(
                                      color: AppColors.meruYellowF,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Icon(Icons.ac_unit_sharp,
                                        color: AppColors.meruBlack),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(20, 8, 8, 8),
                                    child: Text(
                                      headerDescription,
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            children: subheaders.keys
                                .toList()
                                .asMap()
                                .entries
                                .where((entry) {
                              return
                                // entry.key == 0; // Exclude the 0th value
                                entry.key != 0; // Exclude the 0th value
                            }).map((entry) {
                              final subheader = entry.value;
                              final questions = subheaders[subheader] ?? [];
                              final firstQuestionInSubheader =
                              questions.isNotEmpty ? questions.first : {};
                              final subheaderDescription =
                                  firstQuestionInSubheader['description'] ?? '';
                              final sub_questionIndex =
                                  firstQuestion['question'] ?? '';

                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 0,
                                  color: AppColors.meruWhite,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.grey, // Border color
                                      width: 0.4, // Border width
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: ExpansionTile(
                                    title: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(12.0),
                                          decoration: BoxDecoration(
                                            color: AppColors.meruYellowF,
                                            border: Border.all(
                                              color: AppColors.meruYellowF,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                          ),
                                          child: Text(
                                            subheader,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              subheaderDescription,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    children: questions
                                        .asMap()
                                        .entries
                                        .where((entry) {
                                      return entry.key != 0;
                                      /* && entry.key != 1;*/
                                    }).map((entry) {
                                      final question = entry.value;

                                      return _buildStatutoryRow(
                                        header,
                                        subheader,
                                        question['description'] ?? '',
                                        question['points'] ?? '',
                                        question['question'] ?? '',
                                        question['savedscore'] ?? '-',
                                        question['savedremark'] ?? '',
                                        question['additionalnotes'] ?? '',
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionButton("Save", context),
            _buildActionButton("Delete", context),
            _buildActionButton("Hold", context),
            _buildActionButton("Submit to station", context),
          ],
        ),
      ),

      //Floating Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routenames.evaluationScorePage);
        },
        backgroundColor: AppColors.merubg,
        child: Text(
          'Score Card',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: AppColors.meruWhite,
            fontSize: 9.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // final TextEditingController _textController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _openCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  Widget _buildStatutoryRow(
      String header,
      String subheader,
      String? description,
      int points,
      int question,
      String? savedScore,
      String? savedRemark,
      int additionalnotes,
      ) {
    int? initialValue;
    switch (savedScore) {
      case '1':
        initialValue = 1;
        break;
      case '0':
        initialValue = 0;
        break;
      case '-1':
        initialValue = -1;
        break;
      case '-2':
        initialValue = -2;
        break;
      default:
        initialValue = null;
    }

    ValueNotifier<int?> selectedValueNotifier =
    ValueNotifier<int?>(initialValue);
    ValueNotifier<String?> remarkNotifier = ValueNotifier<String?>(savedRemark);

    TextEditingController _textController =
    TextEditingController(text: savedRemark);

    // ValueNotifiers for controlling visibility
    ValueNotifier<bool> showQuestionBNotifier = ValueNotifier<bool>(false);
    ValueNotifier<bool> showQuestionCNotifier = ValueNotifier<bool>(false);
    ValueNotifier<bool> showQuestionBANotifier = ValueNotifier<bool>(false);

    void _initializeQuestions() {
      if (header == '3' && subheader == '1') {
        showQuestionBANotifier.value = false;
      } else {
        if (description ==
            "(A) Are the Attendants on the Forecourt and are they Guiding the Customers to the Pumps ? If the Attendant is busy but gives a Sign/ Signal its acceptable.") {
          showQuestionBNotifier.value = initialValue == 0;
        }
      }

      if (header == '2' && subheader == '1' ||
          header == '3' && subheader == '1') {
        showQuestionBNotifier.value = false;
        showQuestionCNotifier.value = false;
      } else {
        if (description ==
            "(A) Do all the Dispencers have a Valid Asize Sticker Issued by Z W & M?") {
          showQuestionBNotifier.value = initialValue == 0;
        } else if (description ==
            "(B) Mark No if any of the Dispencers are not Assized.") {
          showQuestionCNotifier.value = initialValue == 0;
        }
      }
    }

    _initializeQuestions();

    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Write a Review",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: _textController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Write your Review';
                  }
                  return null;
                },
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    String remarkComment = _textController.text;
                    remarkNotifier.value = _textController.text;
                    Navigator.of(context).pop(); // Close the dialog
                    sendData(
                      context,
                      question.toString(),
                      header,
                      subheader,
                      points.toString(),
                      selectedValueNotifier.value.toString(),
                      remarkComment,
                    );
                  }
                },
              ),
            ],
          );
        },
      );
    }

    return ValueListenableBuilder<int?>(
      valueListenable: selectedValueNotifier,
      builder: (context, selectedValue, child) {
        return Column(
          children: [
            Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              color: AppColors.meruWhite,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                  width: 0.4,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: description ==
                  "(B) Mark No if any of the Dispencers are not Assized." ||
                  description ==
                      "(B) Are the Attendants Recognizing your Presence within a Reasonable Time Frame upon Entering the Forecourt Area?" ||
                  description ==
                      "(C) Mark Yes if the ones that are not Assized are Sealed."
                  ? Text(
                '',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 1.0,
                ),
                textAlign: TextAlign.start,
              )
                  : Padding(
                padding: const EdgeInsets.all(8.0),
                child: additionalnotes == 1
                    ? Text(
                  '$description',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.0,
                  ),
                  textAlign: TextAlign.start,
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$description',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.0,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 0.8,
                                  ),
                                ),
                                child: Text(
                                  "$points",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11.0,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 5),
                        DropdownButton<int?>(
                          value: selectedValue,
                          hint: Text(
                            "Select",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11.0,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          items: [
                            DropdownMenuItem<int?>(
                              value: null,
                              child: Text(
                                "--Select--",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.0,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DropdownMenuItem<int>(
                              value: 1,
                              child: Text(
                                "  Yes",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.0,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DropdownMenuItem<int>(
                              value: 0,
                              child: Text(
                                "  No",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.0,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DropdownMenuItem<int>(
                              value: -1,
                              child: Text(
                                "Partial",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.0,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DropdownMenuItem<int>(
                              value: -2,
                              child: Text(
                                "Not Applicable",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.0,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            selectedValueNotifier.value = value;
                            savedScore = value.toString();
                            sendData(
                              context,
                              question.toString(),
                              header,
                              subheader,
                              points.toString(),
                              value.toString(),
                              remarkNotifier.value ?? '',
                            );

                            // Update the visibility of questions B and C based on the selection
                            if (description ==
                                "(A) Do all the Dispencers have a Valid Asize Sticker Issued by Z W & M?") {
                              showQuestionBNotifier.value =
                                  value == 0;
                            } else if (description ==
                                "(B) Mark No if any of the Dispensers are not Assized.") {
                              showQuestionCNotifier.value =
                                  value == 0;
                            } else if (description ==
                                "(A) Are the Attendants on the Forecourt and are they Guiding the Customers to the Pumps ? If the Attendant is busy but gives a Sign/ Signal its acceptable.") {
                              showQuestionBANotifier.value =
                                  value == 1;
                            }
                          },
                        ),
                        SizedBox(width: 15),
                        Text(
                          selectedValue == -1
                              ? "P"
                              : selectedValue == -2
                              ? "NA"
                              : selectedValue?.toString() ??
                              '-',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: AppColors.meruWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            minimumSize: Size(25.0, 25.0),
                          ),
                          child: Image.asset(
                              "assets/images/fg_upload.png"),
                          onPressed: () async {
                            _openCamera();
                          },
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            AppColors.merubtnOrange,
                            foregroundColor: AppColors.meruWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            minimumSize: Size(25.0, 25.0),
                          ),
                          child: Image.asset(
                              "assets/images/fg_remark.png"),
                          onPressed: _showDialog,
                        ),
                      ],
                    ),
                    ValueListenableBuilder<String?>(
                      valueListenable: remarkNotifier,
                      builder: (context, remark, child) {
                        return Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 5),
                            Text(
                              "Remarks ",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11.0,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                remark ?? '-',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.0,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Question B
            if (additionalnotes != 1)
              ValueListenableBuilder<bool>(
                valueListenable: showQuestionBNotifier,
                builder: (context, showQuestionB, child) {
                  if (!showQuestionB) return Container();
                  return _buildStatutoryRow(
                    header,
                    subheader,
                    "(B) Mark No if any of the Dispensers is not Assized.",
                    points,
                    question + 1,
                    null,
                    // Replace with the saved score if available
                    null,
                    // Replace with the saved remark if available
                    additionalnotes,
                  );
                },
              ),

            // Question C
            if (additionalnotes != 1)
              ValueListenableBuilder<bool>(
                valueListenable: showQuestionCNotifier,
                builder: (context, showQuestionCNotifier, child) {
                  if (!showQuestionCNotifier) return Container();
                  return _buildStatutoryRow(
                    header,
                    subheader,
                    "(C)Mark Yes, if the ones that is not Assized are Sealed.",
                    points,
                    question + 2,
                    null,
                    // Replace with the saved score if available
                    null,
                    // Replace with the saved remark if available
                    additionalnotes,
                  );
                },
              ),

            if (additionalnotes != 1)
              ValueListenableBuilder<bool>(
                valueListenable: showQuestionBANotifier,
                builder: (context, showQuestionBANotifier, child) {
                  if (!showQuestionBANotifier) return Container();
                  return _buildStatutoryRow(
                    header,
                    subheader,
                    "(B) Are the Attendants, Recognizing your Presence within a Reasonable Time Frame upon Entering the Forecourt Area?",
                    points,
                    question + 1,
                    null,
                    // Replace with the saved score if available
                    null,
                    // Replace with the saved remark if available
                    additionalnotes,
                  );
                },
              ),
          ],
        );
      },
    );
  }

  void sendData(BuildContext context, String question, String header,
      String subheader, String points, String value, String savedremark) {
    final logInProvider = Provider.of<APIProvider>(context, listen: false);

    // savedremark = _textController.toString();

    print("Before creating data map");
    Map<String, dynamic> data = {
      "audit_id": gb.auditId_gb,
      "totalscore": points,
      "header": header,
      "subheader": subheader,
      "additionalnotes": "0",
      "question": question.toString(),
      "obtained_score": value.toString(),
      "remarks": savedremark,
      "comments": "",
      "pic_submitted_filename": "",
      "pic_submitted_filepath": ""
    };

    print("After creating data map");

    String jsonData = jsonEncode(data);
    print("SOMEDATASOMEDATA");
    print(jsonData);

    logInProvider.postAuditData(jsonData, context);
  }

  Widget _buildActionButton(
      String label,
      BuildContext context,
      ) {
    return IntrinsicWidth(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: AppColors.meruWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          minimumSize: Size(20, 40.0),
        ),
        label: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.normal,
            color: AppColors.meruWhite,
            fontSize: 8.0,
          ),
        ),
        onPressed: () {
          switch (label) {
            case "Delete":
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("On pressed.")));
              break;

            case "Hold":
              CommonFunctions.showConfirmationDialog(
                context: context,
                message:
                'You will not be able to continue Audit if it’s placed on Hold. Are you sure ?',
                onOkayPressed: () {
                  final logInProvider =
                  Provider.of<APIProvider>(context, listen: false);
                  GlobalVariables gb = GlobalVariables();
                  auditId = gb.auditId_gb;
                  Map<String, dynamic> data = {
                    "id": "$auditId",
                  };
                  String jsonData = jsonEncode(data);
                  // logInProvider.holdAudit(jsonData, context);

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Center(
                        child: TweenAnimationBuilder<Color?>(
                          tween:
                          ColorTween(begin: Colors.red, end: Colors.yellow),
                          duration: Duration(seconds: 1),
                          builder: (context, color, _) {
                            return CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(color!),
                            );
                          },
                          onEnd: () {
                            // No need to do anything here
                          },
                        ),
                      );
                    },
                  );

                  // Simulate a delay of 4 seconds
                  Future.delayed(Duration(seconds: 4), () {
                    Navigator.of(context).pop();

                    GlobalVariables gb = GlobalVariables();
                    String id = gb.auditId_gb;
                    // Call your API or perform any action
                    CommonFunctions.showMessageDialog(
                        context: context,
                        message:
                        "ERB Consumer Audit # $id, has been put on Hold. Please contact Administrator to re-activate Audit.",
                        onYesPressed: () {
                          print('Cancel pressed');

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PendingTable()),
                          );
                        }); // Close the CircularProgressIndicator dialog
                  });
                },
                onCancelPressed: () {
                  // Handle cancel action
                  print('Cancel pressed');
                },
              );

              break;

            case "Submit to station":
              final logInProvider =
              Provider.of<APIProvider>(context, listen: false);
              GlobalVariables gb = GlobalVariables();
              auditId = gb.auditId_gb;
              Map<String, dynamic> data = {
                "id": "$auditId",
              };
              String jsonData = jsonEncode(data);
              logInProvider.submitAudit(jsonData, context);

              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return Center(
                    child: TweenAnimationBuilder<Color?>(
                      tween: ColorTween(begin: Colors.red, end: Colors.yellow),
                      duration: Duration(seconds: 1),
                      builder: (context, color, _) {
                        return CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(color!),
                        );
                      },
                      onEnd: () {
                        // No need to do anything here
                      },
                    ),
                  );
                },
              );

              // Simulate a delay of 4 seconds
              Future.delayed(Duration(seconds: 4), () {
                Navigator.of(context).pop();

                GlobalVariables gb = GlobalVariables();
                auditId = gb.auditId_gb;

                CommonFunctions.showMessageDialog(
                    context: context,
                    message:
                    "ERB Consumer Audit # $auditId, has been successfully submitted to the Station. Please check your email and upload signed audit document to complete the process.",
                    onYesPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => PendingTable()),
                      );
                    });
              });

              break;

            case "Save":
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return Center(
                    child: TweenAnimationBuilder<Color?>(
                      tween: ColorTween(begin: Colors.red, end: Colors.yellow),
                      duration: Duration(seconds: 1),
                      builder: (context, color, _) {
                        return CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(color!),
                        );
                      },
                      onEnd: () {
                        // No need to do anything here
                      },
                    ),
                  );
                },
              );

              // Simulate a delay of 4 seconds
              Future.delayed(Duration(seconds: 4), () {
                Navigator.of(context)
                    .pop(); // Close the CircularProgressIndicator dialog

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Data saved successfully.")),
                );
              });

              break;

            default:
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Under Development")));
          }
          // Add action for buttons here
        },
      ),
    );
  }
}

double _calculateProgress(int currentPosition, int totalSections) {
  if (totalSections == 0) {
    return 0.0; // Prevent division by zero if there are no sections
  }
  return currentPosition / (totalSections - 1);
}





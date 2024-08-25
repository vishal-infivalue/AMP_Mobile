import 'dart:convert';

import 'package:amp/utils/global_values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers_vm/generateOtp_provider.dart';
import '../../routes/route_names.dart';
import '../../utils/app_colors.dart';


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
    setState(() {});
    final apiProvider = Provider.of<APIProvider>(context, listen: false);
    _loadAndFetchData(apiProvider);
  }

  // Fetch data from API and store it in SharedPreferences if not available
  void _loadAndFetchData(APIProvider apiProvider) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? responseJson = prefs.getString('ERBCustomerCheckListResponse');
    String content = "No response data available";

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
          'ERB Technical Audits',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: AppColors.meruRed,
            fontSize: 14.0,
            fontStyle: FontStyle.normal,
          ),
        ),
        backgroundColor: AppColors.meruWhite,
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_sharp,
              color: AppColors.meruRed),
          onPressed: () => Navigator.pop(context),
        ),
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

            final totalHeaders = 7;

            final progress = totalHeaders > 0 ? (2 / 7).toDouble() : 0.0;

            final progressValue = progress != null
                ? (progress > 1.0 ? 1.0 : progress)
                : (1.0 / 7.0);

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: LinearProgressIndicator(
                    value: progressValue,
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
                                  color: AppColors.meruYellow,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
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
                                            color: AppColors.meruYellow,
                                            border: Border.all(
                                              color: AppColors.meruYellow,
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
                                          // entry.key !=
                                          //     1; // Exclude the 0th and 1st values
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
            _buildActionButton("Save"),
            _buildActionButton("Delete"),
            _buildActionButton("Hold"),
            _buildActionButton("Submit to station"),
          ],
        ),
      ),
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


  Widget _buildStatutoryRow(
      String header,
      String subheader,
      String? description,
      int points,
      int question,
      String? savedScore,
      String? savedRemark,
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

    ValueNotifier<int?> selectedValueNotifier = ValueNotifier<int?>(initialValue);
    ValueNotifier<String?> remarkNotifier = ValueNotifier<String?>(savedRemark);
    TextEditingController _textController = TextEditingController(text: savedRemark);

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
                    remarkNotifier.value = _textController.text;
                    Navigator.of(context).pop(); // Close the dialog
                    sendData(
                      context,
                      question.toString(),
                      header,
                      subheader,
                      points.toString(),
                      selectedValueNotifier.value.toString(),
                      _textController.text,
                    );
                  }
                },
              ),
            ],
          );
        },
      );
    }


    return Card(
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$description',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.8,
                          ),
                        ),
                        child: Text(
                          "$points",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11.0,
                            color: Colors.grey,
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
                ValueListenableBuilder<int?>(
                  valueListenable: selectedValueNotifier,
                  builder: (context, selectedValue, child) {
                    return DropdownButton<int?>(
                      value: selectedValue,
                      hint: Text('Select'),
                      items: [
                        DropdownMenuItem<int?>(
                          value: null,
                          child: Text('Select'),
                        ),
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text('Yes'),
                        ),
                        DropdownMenuItem<int>(
                          value: 0,
                          child: Text('No'),
                        ),
                        DropdownMenuItem<int>(
                          value: -1,
                          child: Text('Partial'),
                        ),
                        DropdownMenuItem<int>(
                          value: -2,
                          child: Text('Not Applicable'),
                        ),
                      ],
                      onChanged: (value) {
                        selectedValueNotifier.value = value;
                        dropdownValues[description!] = value;
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
                      },
                    );
                  },
                ),
                SizedBox(width: 15),
                ValueListenableBuilder<int?>(
                  valueListenable: selectedValueNotifier,
                  builder: (context, selectedValue, child) {
                    String displayText;
                    if (selectedValue == -1) {
                      displayText = "P";
                    } else if (selectedValue == -2) {
                      displayText = "NA";
                    } else {
                      displayText = selectedValue?.toString() ?? '-';
                    }

                    return Text(
                      displayText,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
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
                  child: Image.asset("assets/images/fg_upload.png"),
                  onPressed: () {
                    // Handle upload button press
                  },
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.merubtnOrange,
                    foregroundColor: AppColors.meruWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    minimumSize: Size(25.0, 25.0),
                  ),
                  child: Image.asset("assets/images/fg_remark.png"),
                  onPressed: _showDialog,
                ),
              ],
            ),
            ValueListenableBuilder<String?>(
              valueListenable: remarkNotifier,
              builder: (context, remark, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Remarks : ${remark ?? ''}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.merubg,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void sendData(BuildContext context,String question, String header, String subheader,
      String points, String value, String savedremark) {
    final logInProvider = Provider.of<APIProvider>(context, listen: false);


    savedremark = _textController.toString();

    print("Before creating data map");
    Map<String, dynamic> data =
    {
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
    /*{
          "audit_id": gb.auditId_gb,
          "totalscore": points,
          "header": header,
          "subheader": subheader,
          "additionalnotes": "0",
          "question": question,
          "obtained_score": value,
          "remarks": "savedremark",
          "comments": "",
          "pic_submitted_filename": "",
          "pic_submitted_filepath": ""
        };*/
    print("After creating data map");

    String jsonData = jsonEncode(data);
    print("SOMEDATASOMEDATA");
    print(jsonData);

    logInProvider.postAuditData(jsonData, context);
  }

  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  Widget _buildActionButton(String label) {
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TechnicalTest()),
              );

              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Form cleared.")));
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
                Navigator.of(context).pop(); // Close the CircularProgressIndicator dialog

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


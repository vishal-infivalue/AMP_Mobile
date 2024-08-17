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
  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<APIProvider>(context, listen: false);
    _loadAndFetchData(apiProvider);
  }

  // Fetch data from API and store it in SharedPreferences if not available
  void _loadAndFetchData(APIProvider apiProvider) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? responseJson = prefs.getString('ERBCustomerCheckListResponse');
    String content = "No response data available";

    if (responseJson != null &&
        apiProvider.erbCustomerCheckListResponse.isEmpty &&
        !apiProvider.loading) {
      GlobalVariables gb = GlobalVariables();
      String auditId = gb.auditId_gb;
      Map<String, dynamic> data = {
        "id": "$auditId",
      };

      // Map<String, dynamic> data = {"id": "250720240001"};
      String jsonData = jsonEncode(data);
      await apiProvider.getAuditScreenData(jsonData, context);

      // Save fetched data to SharedPreferences
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

  // Extract questions organized by header and subheader
  Map<String, Map<String, List<Map<String, dynamic>>>>
  _extractQuestionsByHeader(List<dynamic>? questions) {
    final Map<String, Map<String, List<Map<String, dynamic>>>> result = {};

    if (questions == null) return result;

    for (var question in questions) {
      final header = question['header']?.toString() ?? '';
      final subheader = question['subheader']?.toString() ?? '';
      final description = question['description'] ?? '';
      final points = question['points'] ?? 0;

      if (!result.containsKey(header)) {
        result[header] = {};
      }

      if (!result[header]!.containsKey(subheader)) {
        result[header]![subheader] = [];
      }

      result[header]![subheader]!.add({
        'description': description,
        'points': points,
      });
    }

    return result;
  }

  // Dropdown values for each description
  Map<String, int?> dropdownValues = {};
  int _currentStep = 0;

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

            // Determine the progress value based on the current header index
            final progress = totalHeaders > 0 ? (3 / 7).toDouble() : 0.0;

            // Set the progress to 1/7 of total progress if null or less than zero
            final progressValue = progress != null
                ? (progress > 1.0 ? 1.0 : progress)
                : (1.0 / 7.0); // 7 distinct values

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
                              return entry.key != 0; // Exclude the 0th value
                            }).map((entry) {
                              final subheader = entry.value;
                              final questions = subheaders[subheader] ?? [];
                              final firstQuestionInSubheader =
                              questions.isNotEmpty ? questions.first : {};
                              final subheaderDescription =
                                  firstQuestionInSubheader['description'] ?? '';

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
                                      return entry.key != 0 &&
                                          entry.key !=
                                              1; // Exclude the 0th and 1st values
                                    }).map((entry) {
                                      final question = entry.value;
                                      return _buildStatutoryRow(
                                        question['description'] ?? '',
                                        question['points'] ?? '',
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

  Widget _buildStatutoryRow(String? description, int points) {
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
                            width: 1.0,
                          ),
                        ),
                        child: Text(
                          "$points",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
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
                DropdownButton<int?>(
                  value: dropdownValues[description],
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
                      value: 2,
                      child: Text('Partial'),
                    ),
                    DropdownMenuItem<int>(
                      value: 3,
                      child: Text('Not Applicable'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      dropdownValues[description!] = value;
                    });
                    // Handle dropdown value change event here
                  },
                ),
                SizedBox(width: 15),
                Text(
                  "-",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
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
                  child: Icon(
                    Icons.upload,
                    color: AppColors.meruWhite,
                    size: 16.0,
                  ),
                  onPressed: _showDialog,
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    foregroundColor: AppColors.meruWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    minimumSize: Size(25.0, 25.0),
                  ),
                  child: Icon(
                    Icons.add_comment,
                    color: AppColors.meruWhite,
                    size: 16.0,
                  ),
                  onPressed:()=>{},
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Review",
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // Do something with the input
                  print('Input: ${_textController.text}');
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
            ),
          ],
        );
      },
    );
  }

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
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Invalid Json parsing. Object{} structure needs to be render correctly.")));
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
/*
class _ERB_AuditState extends State<ERB_Audit_Tech> {
  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<APIProvider>(context, listen: false);
    _loadAndFetchData(apiProvider);
  }

  // Fetch data from API and store it in SharedPreferences if not available
  void _loadAndFetchData(APIProvider apiProvider) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? responseJson = prefs.getString('ERBCustomerCheckListResponse');
    String content = "No response data available";

    if (responseJson != null &&
        apiProvider.erbCustomerCheckListResponse.isEmpty &&
        !apiProvider.loading) {
      GlobalVariables gb = GlobalVariables();
      String auditId = gb.auditId_gb;
      Map<String, dynamic> data = {
        "id": "$auditId",
      };

      // Map<String, dynamic> data = {"id": "250720240001"};
      String jsonData = jsonEncode(data);
      await apiProvider.getAuditScreenData(jsonData, context);

      // Save fetched data to SharedPreferences
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

  // Extract questions organized by header and subheader
  Map<String, Map<String, List<Map<String, dynamic>>>>
      _extractQuestionsByHeader(List<dynamic>? questions) {
    final Map<String, Map<String, List<Map<String, dynamic>>>> result = {};

    if (questions == null) return result;

    for (var question in questions) {
      final header = question['header']?.toString() ?? '';
      final subheader = question['subheader']?.toString() ?? '';
      final description = question['description'] ?? '';
      final points = question['points'] ?? 0;

      if (!result.containsKey(header)) {
        result[header] = {};
      }

      if (!result[header]!.containsKey(subheader)) {
        result[header]![subheader] = [];
      }

      result[header]![subheader]!.add({
        'description': description,
        'points': points,
      });
    }

    return result;
  }

  // Dropdown values for each description
  Map<String, int?> dropdownValues = {};

  Widget _buildStatutoryRow(String? description, int points) {
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // Center the entire column vertically
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // Center the entire row horizontally
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // Align items in the row to the center
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // Center content within the column
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // Center align text within the column
                        children: [
                          Text(
                            '$description',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign:
                                TextAlign.start, // Center the text itself
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              // Make the background circular
                              border: Border.all(
                                color: Colors.grey, // Grey border color
                                width: 1.0, // Border width
                              ),
                            ),
                            child: Text(
                              "$points",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey, // Text color
                              ),
                              textAlign:
                                  TextAlign.center, // Center the text itself
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DropdownButton<int?>(
                  value: dropdownValues[description],
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
                      value: 2,
                      child: Text('Partial'),
                    ),
                    DropdownMenuItem<int>(
                      value: 3,
                      child: Text('Not Applicable'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      dropdownValues[description!] = value;
                    });
                    final logInProvider = Provider.of<APIProvider>(context);
                    logInProvider.getclusteravgscore(context);
                    GlobalVariables gb = GlobalVariables();
                    String auditId = gb.auditId_gb;
                    Map<String, dynamic> data = {
                      "ERB_Audit_StagingDTO": {
                        "audit_id": "$auditId",
                        "totalscore": "1",
                        "header": "1",
                        "subheader": "1",
                        "additionalnotes": "0",
                        "question": "3",
                        "obtained_score": value,
                        "remarks": "Test",
                        "comments": "",
                        "pic_submitted_filename": "",
                        "pic_submitted_filepath": "",
                      }
                    };

                    String jsonData = jsonEncode(data);
                    print(jsonData);

                    Future<void> someData =
                        logInProvider.postAuditData(jsonData, context);
                    if (someData != null) {
                      print("VISHAL888 Successfully done");
                    } else {
                      print("VISHAL888 Error");
                    }
                  },
                ),
                SizedBox(width: 15),
                Text(
                  "-",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
                  child: Icon(
                    Icons.upload,
                    color: AppColors.meruWhite,
                    size: 16.0,
                  ),
                  onPressed: () {
                    // Handle upload button press
                  },
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    foregroundColor: AppColors.meruWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    minimumSize: Size(25.0, 25.0),
                  ),
                  child: Icon(
                    Icons.add_comment,
                    color: AppColors.meruWhite,
                    size: 16.0,
                  ),
                  onPressed: () {
                    // Handle upload button press
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ERB Consumer Audits',
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
                _extractQuestionsByHeader(response['questions']);

            final totalHeaders = 7;

            // Determine the progress value based on the current header index
            final progress = totalHeaders > 0 ? (3 / 7).toDouble() : 0.0;

            // Set the progress to 1/7 of total progress if null or less than zero
            final progressValue = progress != null
                ? (progress > 1.0 ? 1.0 : progress)
                : (1.0 / 7.0); // 7 distinct values

            return ListView(
              children: questionsByHeader.keys.map((header) {
                final subheaders = questionsByHeader[header]!;
                final firstSubheader = subheaders.keys.first;
                final firstQuestion = subheaders[firstSubheader]!.first;
                final headerDescription = firstQuestion['description'];

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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            color: AppColors.meruYellow,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.ac_unit_sharp,
                                  color: AppColors.meruBlack),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                            child: Expanded(
                              child: Text(
                                '$headerDescription',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
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
                        return entry.key != 0; // Exclude the 0th value
                      }).map((entry) {
                        final subheader = entry.value;
                        final questions = subheaders[subheader]!;
                        final firstQuestionInSubheader = questions.first;
                        final subheaderDescription =
                            firstQuestionInSubheader['description'];

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
                                        color: AppColors
                                            .meruYellow, // Yellow border color
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Text(
                                      '$subheader',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '$subheaderDescription',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              children:
                                  questions.asMap().entries.where((entry) {
                                return entry.key != 0 &&
                                    entry.key != 1; // Exclude the 0th value
                              }).map((entry) {
                                final question = entry.value;
                                return _buildStatutoryRow(
                                  question['description'],
                                  question['points'],
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              }).toList(),
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
                MaterialPageRoute(builder: (context) => ERB_Audit_Tech()),
              );

              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Form cleared.")));
              break;

            case "Save":
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Invalid Json parsing. Object{} structure needs to be render correctly.")));
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
}*/



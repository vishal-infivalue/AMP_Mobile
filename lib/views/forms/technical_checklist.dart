import 'dart:convert';

import 'package:amp/utils/constant_strings.dart';
import 'package:amp/utils/global_values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers_vm/generateOtp_provider.dart';
import '../../routes/route_names.dart';
import '../../utils/app_colors.dart';

class ERBConsumer extends StatefulWidget {
  const ERBConsumer({Key? key}) : super(key: key);

  @override
  _ERBConsumerState createState() => _ERBConsumerState();
}

class _ERBConsumerState extends State<ERBConsumer> {
  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<APIProvider>(context, listen: false);
    _loadAndFetchData(apiProvider);
  }

  // Fetch data from API and store it in SharedPreferences if not available
  void _loadAndFetchData(APIProvider apiProvider) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? responseJson = prefs.getString(ConstantStrings.ERBCustomerCheckListResponse);
    String content = "No response data available";

    GlobalVariables gb = GlobalVariables();
    String audit_id = gb.auditId_gb;

    if (responseJson == null &&
        apiProvider.erbCustomerCheckListResponse.isEmpty &&
        !apiProvider.loading) {
      Map<String, dynamic> data = {"id": "250720240001"};
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

  // Extract selections organized by type
/*  Map<String, List<Map<String, dynamic>>>
  _extractSelectionsByType(List<dynamic>? selections) {
    final Map<String, List<Map<String, dynamic>>> result = {};

    if (selections == null) return result;

    for (var selection in selections) {
      final type = selection['type']?.toString() ?? '';
      final value = selection['value'] ?? '';
      final placeholder1 = selection['placeholder_1'] ?? '';
      final placeholder2 = selection['placeholder_2'] ?? '';
      final placeholder3 = selection['placeholder_3'] ?? '';

      if (!result.containsKey(type)) {
        result[type] = [];
      }

      result[type]!.add({
        'value': value,
        'placeholder_1': placeholder1,
        'placeholder_2': placeholder2,
        'placeholder_3': placeholder3,
      });
    }

    return result;
  }*/


  // Dropdown values for each description
  Map<String, int?> dropdownValues = {};




  Widget _buildStatutoryRow(String? description, int points) {
    GlobalVariables gb = GlobalVariables();
    gb.selection_audit_gb;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(2),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '$description ($points)',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.meruBlack,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                DropdownButton<int?>(
                  value: dropdownValues[description],
                  menuMaxHeight: 550,
                  hint: Text("Select"),
                  items: [
                    DropdownMenuItem<int?>(
                      value: -3,
                      child: Text(
                        'Select',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                          color: AppColors.meruBlack,
                          fontSize: 12.0,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text(
                        'Yes',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                          color: AppColors.meruBlack,
                          fontSize: 12.0,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    DropdownMenuItem<int>(
                      value: 0,
                      child: Text(
                        'No',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                          color: AppColors.meruBlack,
                          fontSize: 12.0,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    DropdownMenuItem<int>(
                      value: -1,
                      child: Text(
                        'Partial',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                          color: AppColors.meruBlack,
                          fontSize: 12.0,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    DropdownMenuItem<int>(
                      value: -2,
                      child: Text(
                        'NA',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                          color: AppColors.meruBlack,
                          fontSize: 12.0,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      dropdownValues["description"] = value;

                    });

                    final logInProvider = Provider.of<APIProvider>(context);
                    logInProvider.getclusteravgscore(context);
                    Map<String, dynamic> data = {
                      "ERB_Audit_StagingDTO": {
                        "audit_id": "10000000001",
                        "totalscore": "1",
                        "header": "1",
                        "subheader": "1",
                        "additionalnotes": "0",
                        "question": "3",
                        "obtained_score": "1",
                        "remarks": "Test",
                        "comments": "",
                        "pic_submitted_filename": "",
                        "pic_submitted_filepath": "",
                      }
                    };

                    String jsonData = jsonEncode(data);
                    print(jsonData);

                    Future<void> someData = logInProvider.postAuditData(jsonData, context);
                    if(someData != null){
                      print("VISHAL888 Successfully done");
                    }else{
                      print("VISHAL888 Error");
                    }
                  },
                ),





                /*DropdownButton<int?>(
                  value: gb.selection_audit_gb,
                  hint: Text(gb.selection_audit_gb[0].value),
                  items: [
                    DropdownMenuItem<int?>(
                      value: null,
                      child: Text(gb.selection_audit_gb[0].value),
                    ),
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text(gb.selection_audit_gb[1].value),
                    ),
                    DropdownMenuItem<int>(
                      value: 0,
                      child: Text(gb.selection_audit_gb[2].value),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Text(gb.selection_audit_gb[3].value),
                    ),
                    DropdownMenuItem<int>(
                      value: 3,
                      child: Text(gb.selection_audit_gb[4].value),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      dropdownValues[description!] = value;
                    });
                    // Handle dropdown value change event here
                  },
                ),*/
                SizedBox(width: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: AppColors.meruWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    minimumSize: Size(15.0, 10.0),
                  ),
                  child: Icon(
                    Icons.upload,
                    color: AppColors.meruWhite,
                    size: 14.0,
                  ),
                  onPressed: () {
                    // Handle upload button press
                  },
                ),
                SizedBox(width: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    foregroundColor: AppColors.meruWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    minimumSize: Size(15.0, 10.0),
                  ),
                  child: Icon(
                    Icons.add_comment,
                    color: AppColors.meruWhite,
                    size: 14.0,
                  ),
                  onPressed: () {
                    // Handle remark button press
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
          'ERB Consumer Audits ',
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

            // final selections =
            // _extractSelectionsByType(response['selection']);

            GlobalVariables gb = GlobalVariables();
            // gb.selection_audit_gb = selections;


            return ListView(
              children: questionsByHeader.keys.map((header) {
                final subheaders = questionsByHeader[header]!;
                final firstSubheader = subheaders.keys.first;
                final firstQuestion = subheaders[firstSubheader]!.first;
                final headerDescription = firstQuestion['description'];

                return ExpansionTile(
                  title: Row(
                    children: [
                      Container(
                        color: AppColors.meruYellow,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.ac_unit_sharp, color: AppColors.meruBlack),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '$headerDescription',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  children:
                  subheaders.keys.toList().asMap().entries.where((entry) {
                    return entry.key != 0; // Exclude the 0th value
                  }).map((entry) {

                    final subheader = entry.value;
                    final questions = subheaders[subheader]!;
                    final firstQuestionInSubheader = questions.first;
                    final subheaderDescription =
                    firstQuestionInSubheader['description'];

                    return ExpansionTile(
                      title: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: AppColors.meruYellow,
                              border: Border.all(
                                color: AppColors.meruYellow, // Yellow border color
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
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      children: questions.asMap().entries.where((entry) {
                        return entry.key != 0; // Exclude the 0th value
                      }).map((entry) {
                        final question = entry.value;
                        return _buildStatutoryRow(
                            question['description'],
                            question['points']
                        );
                      }).toList(),
                    );
                  }).toList(),
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

  // Build action buttons for the bottom app bar
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
          // Add action for buttons here
        },
      ),
    );
  }


}


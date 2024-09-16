import 'dart:convert';

import 'package:amp/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_to_expand/tap_to_expand.dart';

import '../../providers_vm/generateOtp_provider.dart';
import '../../routes/route_names.dart';
import '../../utils/strings.dart';

class ERBTechnicalCheckList extends StatefulWidget {
  @override
  _ERBTechnicalCheckListState createState() => _ERBTechnicalCheckListState();
}

class _ERBTechnicalCheckListState extends State<ERBTechnicalCheckList> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  bool _showLoading = false;
  bool _showLoading1 = false;
  bool _showLoading2 = false;

  final TextEditingController omcController = TextEditingController();
  final TextEditingController siteController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactsController = TextEditingController();
  final TextEditingController ocrController = TextEditingController();
  final TextEditingController gradingController = TextEditingController();

  int _currentStep = 0;

  int _calculateTotalPoints() {
    int totalPoints = 0;
    dropdownValues.forEach((key, value) {
      if (value == 1) {
        totalPoints++;
      }
    });
    return totalPoints;
  }

  Widget _buildBasicForm1() {
    return Column(
      children: [
        _buildStatutoryQuestionSubtitle(AppStrings.auditNote),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildStatutoryRow(
                "(A) The attendant's are wearing Clean Uniforms.", "1"),
            _buildStatutoryRow(
                "(B) The Uniforms are Comprising of a Trousers & a Shirt with a Clearly Visible Company Logo & Name Tag.",
                "1"),
            _buildStatutoryRow(
                "(C) The Attendants are wearing Clean & Closed Safety Shoes with a Toe Cap.",
                "1"),
            _buildStatutoryRow(
                "(D) The Uniforms are not made of Synthetic Material to avoid Static Electricity.",
                "1"),
          ],
        ),
      ],
    );
  }
  Widget _buildBasicForm2() {
    return Column(
      children: [
        _buildStatutoryQuestionSubtitle(AppStrings.auditNote),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildStatutoryRow("(A) No Cell Phones.", "1"),
            _buildStatutoryRow("(B) Switch off Engines.", "1"),
            _buildStatutoryRow("(C) No Naked Flames.", "1"),
            _buildStatutoryRow("(D) No Smoking.", "1"),
            _buildStatutoryRow("(E) No refueling in Public Service Vehicles (PSV) with passengers on Board.", "1"),
            _buildStatutoryRow("(F) No Dispensing into Portable Containers that are not approved.", "1"),
          ],
        ),
      ],
    );
  }
  Widget _buildBasicForm3() {
    return Column(
      children: [
        _buildStatutoryQuestionSubtitle(AppStrings.auditNote),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildStatutoryRow("(A) No Cell Phones.", "1"),
            _buildStatutoryRow("(B) Switch off Engines.", "1"),
            _buildStatutoryRow("(C) No Naked Flames.", "1"),
            _buildStatutoryRow("(D) No Smoking.", "1"),
          ],
        ),
      ],
    );
  }
  Widget _buildBasicForm4() {
    return Column(
      children: [
        _buildStatutoryQuestionSubtitle(AppStrings.auditNote),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildStatutoryRow("(A) Vending.", "2"),
            _buildStatutoryRow("(B) Parking of Vehicles.", "2"),
          ],
        ),
      ],
    );
  }



  Widget _buildStatutoryQuestionSubtitle(String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: AppColors.meruBlack,
                    fontSize: 11.0,
                    letterSpacing: 1,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatutoryRow(String description, String maxScore) {
    Gradient a = const LinearGradient(
      colors: [Colors.blue, Colors.blue],
    );

    Gradient b = const LinearGradient(
      colors: [Colors.white, Colors.white],
    );
    return Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.all(2),
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white,
                  Colors.white,
                  Colors.white,
                  Colors.white,
                  Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                description + " Max Score : " + maxScore,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppColors.meruBlack,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.left,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropdownButton<int?>(
                    value: dropdownValues[description],
                    menuMaxHeight: 750,
                    items: [
                      DropdownMenuItem<int?>(
                        value: null,
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
                        value: 2,
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
                        value: 3,
                        child: Text(
                          'Not Applicable',
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
                        if (value == 0) {
                          dropdownValues[description] = value;
                        } else if (value == 1) {
                          dropdownValues[description] = value;
                        } else if (value == 2) {
                          dropdownValues[description] = value;
                        } else if (value == 3) {
                          dropdownValues[description] = value;
                        } else {
                          dropdownValues[description] = value;
                        }
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '-',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.meruBlack,
                      fontSize: 11.0,
                      letterSpacing: 1,
                      fontStyle: FontStyle.normal,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: AppColors.meruWhite,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      minimumSize: Size(
                        MediaQuery.of(context).size.width * 0.1,
                        20.0,
                      ),
                    ),
                    // Replace with the desired icon
                    label: false
                        ? CircularProgressIndicator(
                            color: AppColors.meruYellow,
                            strokeWidth: 1.0,
                          )
                        : Text(
                            "Upload",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              color: AppColors.meruWhite,
                              fontSize: 11.0,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                    onPressed: () async {},
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      foregroundColor: AppColors.meruWhite,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      minimumSize: Size(
                        MediaQuery.of(context).size.width * 0.2,
                        20.0,
                      ),
                    ),

                    label: false
                        ? CircularProgressIndicator(
                            color: AppColors.meruYellow,
                            strokeWidth: 1.0,
                          )
                        : Text(
                            "Remark",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              color: AppColors.meruBlack,
                              fontSize: 11.0,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                    onPressed: _showDialog,
                  ),
                ],
              )
            ],
          )),
    ),);
  }

  Map<String, int?> dropdownValues = {};

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Implement save logic here
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Review'),
          content: Form(
            // key: _formKey,
            child: TextFormField(
              controller: _textController,
              /*validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please add your review.';
                }
                return null;
              },*/
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                _textController.text = "";
                if (_formKey.currentState?.validate() ?? false) {
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _clearForm() {
    _formKey.currentState!.reset();
    // Clear other states if necessary
  }

  @override
  Widget build(BuildContext context) {
    final logInProvider = Provider.of<APIProvider>(context);

    Map<String, dynamic> data = {
      "id": "10000000001",
    };

    String jsonData = jsonEncode(data);
    print(jsonData);

    logInProvider.getAuditScreenData(jsonData,context);



    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ERB Consumer Checklist',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
            fontSize: 14.0,
            fontStyle: FontStyle.normal,
          ),
        ),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_sharp, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(8.0,0.0,0.0,100),
        child: FloatingActionButton.extended(
          heroTag: 'uniqueTag',
          label: Row(
            children: [
              Icon(Icons.preview_outlined),
              SizedBox(width: 4), // Add some space between the icon and text
              Text('Preview'),
            ],
          ),
          onPressed: () {
            // Navigator.pushNamed(context, Routenames.evaluationScorePage);
            Navigator.pushNamed(context, Routenames.evaluationPreview);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: LinearProgressIndicator(
              value: (_currentStep + 1) / 4,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.meruYellow),
              minHeight: 15,
            ),
          ),


          
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: TapToExpand(
                backgroundcolor: AppColors.meruWhite,
                content: Column(
                  children: <Widget>[
                    /*for (var i = 0; i < 10; i++)
                      Text(
                        "data $i",
                        style: const TextStyle(color: Colors.black, fontSize: 20),
                      ),*/
                  ],
                ),
                iconColor: AppColors.meruBlack,
                title: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ' * ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Image.asset(
                    //   'assets/images/menu_logo.png', // Replace with your image asset path
                    //   width: 24,
                    //   height: 24,
                    // ),
                    const SizedBox(width: 8), // Add some space between image and text
                    const Text(
                      '  Safety ( 20 points )',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.meruBlack,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),




          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.2,
                      50.0,
                    ),
                  ),
                  label: Text(
                    "Save",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 12.0,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  onPressed: () async {
                    setState(() => _showLoading = true);
                    _saveForm();
                    await Future.delayed(const Duration(seconds: 2));
                    setState(() => _showLoading = false);
                  },
                ),
                /*ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.2,
                      50.0,
                    ),
                  ),
                  label: const Text(
                    "Preview",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 12.0,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  onPressed: () async {
                    setState(() => _showLoading1 = true);
                    await Future.delayed(const Duration(seconds: 2));
                    *//*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PreviewFormPageNew(
                          omc: omcController.text,
                          site: siteController.text,
                          address: addressController.text,
                          contacts: contactsController.text,
                          ocr: ocrController.text,
                          grading: gradingController.text,
                        ),
                      ),
                    );*//*
                    setState(() => _showLoading1 = false);
                  },
                ),*/
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.2,
                      50.0,
                    ),
                  ),
                  label: const Text(
                    "Clear",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 12.0,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  onPressed: () async {
                    setState(() => _showLoading2 = true);
                    _clearForm();
                    await Future.delayed(const Duration(seconds: 2));
                    setState(() => _showLoading2 = false);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

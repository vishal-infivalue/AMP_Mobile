import 'dart:convert';

import 'package:amp/utils/global_values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers_vm/generateOtp_provider.dart';
import '../../routes/route_names.dart';
import '../../utils/app_colors.dart';

class ERB_Audit_Tech extends StatefulWidget {
  const ERB_Audit_Tech({Key? key}) : super(key: key);

  @override
  _ERB_AuditState createState() => _ERB_AuditState();
}

class _ERB_AuditState extends State<ERB_Audit_Tech> {
  late Future<void> auditLoadData;

  @override
  Widget build(BuildContext context) {
    final logInProvider = Provider.of<APIProvider>(context);
    logInProvider.getclusteravgscore(context);
    GlobalVariables gb = GlobalVariables();
    String auditId = gb.auditId_gb;
    Map<String, dynamic> data = {
      "id": "$auditId",
    };

    String jsonData = jsonEncode(data);
    print(jsonData);

    auditLoadData = logInProvider.getAuditScreenData(jsonData, context);

    int _currentStep = 0;
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: LinearProgressIndicator(
              value: (_currentStep + 0) / 4,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.meruYellow),
              minHeight: 10,
            ),
          ),
          Card(
            margin: EdgeInsets.all(8.0),
            color: AppColors.meruWhite,
            elevation: 0, // Remove the shadow
            child: ExpansionTile(
              backgroundColor: Colors.transparent,
              tilePadding: EdgeInsets.zero,
              // Remove padding inside the tile
              childrenPadding: EdgeInsets.zero,
              // Remove padding inside the children
              leading: IconButton(
                icon: Container(
                  color: AppColors.meruYellow,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Icon(Icons.ac_unit_sharp, color: AppColors.meruBlack),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(logInProvider.questions.length.toString()),
              trailing: Icon(Icons.expand_more),
              children: [Center(child: Text('No data available'))],
            ),
          ),
          Card(
            margin: EdgeInsets.all(8.0),
            color: AppColors.meruWhite,
            elevation: 0, // Remove the shadow
            child: ExpansionTile(
              backgroundColor: Colors.transparent,
              tilePadding: EdgeInsets.zero,
              // Remove padding inside the tile
              childrenPadding: EdgeInsets.zero,
              // Remove padding inside the children
              leading: IconButton(
                icon: Container(
                    color: AppColors.meruYellow,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Icon(Icons.ac_unit_sharp, color: AppColors.meruBlack),
                    )),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                'Safety(20 Points)',
                style: TextStyle(
                  color: AppColors.meruBlack,
                  fontFamily: 'Poppins',
                  fontSize: 14.0,
                ),
              ),
              trailing: Icon(Icons.expand_more),
              children: [
                Card(
                  margin: EdgeInsets.all(8.0),
                  color: AppColors.meruWhite,
                  elevation: 0, // Remove the shadow
                  child: ExpansionTile(
                    backgroundColor: Colors.transparent,
                    tilePadding: EdgeInsets.zero,
                    // Remove padding inside the tile
                    childrenPadding: EdgeInsets.zero,
                    // Remove padding inside the children
                    leading: IconButton(
                      icon: Container(
                          color: AppColors.meruYellow,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('1'))),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: Text(
                      'Correct Safety Attire(04)',
                      style: TextStyle(
                        color: AppColors.meruBlack,
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                      ),
                    ),
                    children: [
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        color: AppColors.meruWhite, // Remove the shadow
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'The Attendents are wearing clean uniform'),
                                  Text('1'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton<int?>(
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
                                      setState(() {});
                                      // Handle dropdown value change event here
                                    },
                                  ),
                                  Text('-'),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        color: AppColors.meruWhite, // Remove the shadow
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'The Attendents are wearing clean uniform'),
                                  Text('1'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton<int?>(
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
                                      setState(() {});
                                      // Handle dropdown value change event here
                                    },
                                  ),
                                  Text('-'),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(8.0),
                  color: AppColors.meruWhite,
                  elevation: 0, // Remove the shadow
                  child: ExpansionTile(
                    backgroundColor: Colors.transparent,
                    tilePadding: EdgeInsets.zero,
                    // Remove padding inside the tile
                    childrenPadding: EdgeInsets.zero,
                    // Remove padding inside the children
                    leading: IconButton(
                      icon: Container(
                          color: AppColors.meruYellow,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('2'))),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: Text(
                      'Safety Awareness(06)',
                      style: TextStyle(
                        color: AppColors.meruBlack,
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                      ),
                    ),
                    children: [
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        color: AppColors.meruWhite, // Remove the shadow
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'The Attendents are wearing clean uniform'),
                                  Text('1'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton<int?>(
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
                                      setState(() {});
                                      // Handle dropdown value change event here
                                    },
                                  ),
                                  Text('-'),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        color: AppColors.meruWhite, // Remove the shadow
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'The Attendents are wearing clean uniform'),
                                  Text('1'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton<int?>(
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
                                      setState(() {});
                                      // Handle dropdown value change event here
                                    },
                                  ),
                                  Text('-'),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.all(8.0),
            color: AppColors.meruWhite,
            elevation: 0, // Remove the shadow
            child: ExpansionTile(
              backgroundColor: Colors.transparent,
              tilePadding: EdgeInsets.zero,
              // Remove padding inside the tile
              childrenPadding: EdgeInsets.zero,
              // Remove padding inside the children
              leading: IconButton(
                icon: Container(
                    color: AppColors.meruYellow,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Icon(Icons.ac_unit_sharp, color: AppColors.meruBlack),
                    )),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                'Consumer Service (32 Points)',
                style: TextStyle(
                  color: AppColors.meruBlack,
                  fontFamily: 'Poppins',
                  fontSize: 14.0,
                ),
              ),
              trailing: Icon(Icons.expand_more),
              children: [
                Card(
                  margin: EdgeInsets.all(8.0),
                  color: AppColors.meruWhite,
                  elevation: 0, // Remove the shadow
                  child: ExpansionTile(
                    backgroundColor: Colors.transparent,
                    tilePadding: EdgeInsets.zero,
                    // Remove padding inside the tile
                    childrenPadding: EdgeInsets.zero,
                    // Remove padding inside the children
                    leading: IconButton(
                      icon: Container(
                          color: AppColors.meruYellow,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('1'))),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: Text(
                      'Correct Safety Attire(04)',
                      style: TextStyle(
                        color: AppColors.meruBlack,
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                      ),
                    ),
                    children: [
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        color: AppColors.meruWhite, // Remove the shadow
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'The Attendents are wearing clean uniform'),
                                  Text('1'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton<int?>(
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
                                      setState(() {});
                                      // Handle dropdown value change event here
                                    },
                                  ),
                                  Text('-'),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        color: AppColors.meruWhite, // Remove the shadow
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'The Attendents are wearing clean uniform'),
                                  Text('1'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton<int?>(
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
                                      setState(() {});
                                      // Handle dropdown value change event here
                                    },
                                  ),
                                  Text('-'),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(8.0),
                  color: AppColors.meruWhite,
                  elevation: 0, // Remove the shadow
                  child: ExpansionTile(
                    backgroundColor: Colors.transparent,
                    tilePadding: EdgeInsets.zero,
                    // Remove padding inside the tile
                    childrenPadding: EdgeInsets.zero,
                    // Remove padding inside the children
                    leading: IconButton(
                      icon: Container(
                          color: AppColors.meruYellow,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('2'))),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: Text(
                      'Safety Awareness(06)',
                      style: TextStyle(
                        color: AppColors.meruBlack,
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                      ),
                    ),
                    children: [
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        color: AppColors.meruWhite, // Remove the shadow
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'The Attendents are wearing clean uniform'),
                                  Text('1'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton<int?>(
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
                                      setState(() {});
                                      // Handle dropdown value change event here
                                    },
                                  ),
                                  Text('-'),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        color: AppColors.meruWhite, // Remove the shadow
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'The Attendents are wearing clean uniform'),
                                  Text('1'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton<int?>(
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
                                      setState(() {});
                                      // Handle dropdown value change event here
                                    },
                                  ),
                                  Text('-'),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.all(8.0),
            color: AppColors.meruWhite,
            elevation: 0, // Remove the shadow
            child: ExpansionTile(
              backgroundColor: Colors.transparent,
              tilePadding: EdgeInsets.zero,
              // Remove padding inside the tile
              childrenPadding: EdgeInsets.zero,
              // Remove padding inside the children
              leading: IconButton(
                icon: Container(
                    color: AppColors.meruYellow,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Icon(Icons.ac_unit_sharp, color: AppColors.meruBlack),
                    )),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                'Courtesy (20 Points)',
                style: TextStyle(
                  color: AppColors.meruBlack,
                  fontFamily: 'Poppins',
                  fontSize: 14.0,
                ),
              ),
              trailing: Icon(Icons.expand_more),
              children: [
                Card(
                  margin: EdgeInsets.all(8.0),
                  color: AppColors.meruWhite,
                  elevation: 0, // Remove the shadow
                  child: ExpansionTile(
                    backgroundColor: Colors.transparent,
                    tilePadding: EdgeInsets.zero,
                    // Remove padding inside the tile
                    childrenPadding: EdgeInsets.zero,
                    // Remove padding inside the children
                    leading: IconButton(
                      icon: Container(
                          color: AppColors.meruYellow,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('1'))),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: Text(
                      'Correct Safety Attire(04)',
                      style: TextStyle(
                        color: AppColors.meruBlack,
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                      ),
                    ),
                    children: [
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        color: AppColors.meruWhite, // Remove the shadow
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'The Attendents are wearing clean uniform'),
                                  Text('1'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton<int?>(
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
                                      setState(() {});
                                      // Handle dropdown value change event here
                                    },
                                  ),
                                  Text('-'),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        color: AppColors.meruWhite, // Remove the shadow
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'The Attendents are wearing clean uniform'),
                                  Text('1'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton<int?>(
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
                                      setState(() {});
                                      // Handle dropdown value change event here
                                    },
                                  ),
                                  Text('-'),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(8.0),
                  color: AppColors.meruWhite,
                  elevation: 0, // Remove the shadow
                  child: ExpansionTile(
                    backgroundColor: Colors.transparent,
                    tilePadding: EdgeInsets.zero,
                    // Remove padding inside the tile
                    childrenPadding: EdgeInsets.zero,
                    // Remove padding inside the children
                    leading: IconButton(
                      icon: Container(
                          color: AppColors.meruYellow,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('2'))),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: Text(
                      'Safety Awareness(06)',
                      style: TextStyle(
                        color: AppColors.meruBlack,
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                      ),
                    ),
                    children: [
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        color: AppColors.meruWhite, // Remove the shadow
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'The Attendents are wearing clean uniform'),
                                  Text('1'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton<int?>(
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
                                      setState(() {});
                                      // Handle dropdown value change event here
                                    },
                                  ),
                                  Text('-'),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        color: AppColors.meruWhite, // Remove the shadow
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'The Attendents are wearing clean uniform'),
                                  Text('1'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton<int?>(
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
                                      setState(() {});
                                      // Handle dropdown value change event here
                                    },
                                  ),
                                  Text('-'),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.all(8.0),
            color: AppColors.meruWhite,
            elevation: 0, // Remove the shadow
            child: ExpansionTile(
              backgroundColor: Colors.transparent,
              tilePadding: EdgeInsets.zero,
              // Remove padding inside the tile
              childrenPadding: EdgeInsets.zero,
              // Remove padding inside the children
              leading: IconButton(
                icon: Container(
                    color: AppColors.meruYellow,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Icon(Icons.ac_unit_sharp, color: AppColors.meruBlack),
                    )),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                'Aesthetic (20 Points)',
                style: TextStyle(
                  color: AppColors.meruBlack,
                  fontFamily: 'Poppins',
                  fontSize: 14.0,
                ),
              ),
              trailing: Icon(Icons.expand_more),
              children: [
                Card(
                  margin: EdgeInsets.all(8.0),
                  color: AppColors.meruWhite,
                  elevation: 0, // Remove the shadow
                  child: ExpansionTile(
                    backgroundColor: Colors.transparent,
                    tilePadding: EdgeInsets.zero,
                    // Remove padding inside the tile
                    childrenPadding: EdgeInsets.zero,
                    // Remove padding inside the children
                    leading: IconButton(
                      icon: Container(
                          color: AppColors.meruYellow,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('1'))),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: Text(
                      'Correct Safety Attire(04)',
                      style: TextStyle(
                        color: AppColors.meruBlack,
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                      ),
                    ),
                    children: [
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        color: AppColors.meruWhite, // Remove the shadow
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'The Attendents are wearing clean uniform'),
                                  Text('1'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton<int?>(
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
                                      setState(() {});
                                      // Handle dropdown value change event here
                                    },
                                  ),
                                  Text('-'),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        color: AppColors.meruWhite, // Remove the shadow
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'The Attendents are wearing clean uniform'),
                                  Text('1'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton<int?>(
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
                                      setState(() {});
                                      // Handle dropdown value change event here
                                    },
                                  ),
                                  Text('-'),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(8.0),
                  color: AppColors.meruWhite,
                  elevation: 0, // Remove the shadow
                  child: ExpansionTile(
                    backgroundColor: Colors.transparent,
                    tilePadding: EdgeInsets.zero,
                    // Remove padding inside the tile
                    childrenPadding: EdgeInsets.zero,
                    // Remove padding inside the children
                    leading: IconButton(
                      icon: Container(
                          color: AppColors.meruYellow,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('2'))),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: Text(
                      'Safety Awareness(06)',
                      style: TextStyle(
                        color: AppColors.meruBlack,
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                      ),
                    ),
                    children: [
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        color: AppColors.meruWhite, // Remove the shadow
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'The Attendents are wearing clean uniform'),
                                  Text('1'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton<int?>(
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
                                      setState(() {});
                                      // Handle dropdown value change event here
                                    },
                                  ),
                                  Text('-'),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        color: AppColors.meruWhite, // Remove the shadow
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'The Attendents are wearing clean uniform'),
                                  Text('1'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton<int?>(
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
                                      setState(() {});
                                      // Handle dropdown value change event here
                                    },
                                  ),
                                  Text('-'),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.all(8.0),
            color: AppColors.meruWhite,
            elevation: 0, // Remove the shadow
            child: ExpansionTile(
              backgroundColor: Colors.transparent,
              tilePadding: EdgeInsets.zero,
              // Remove padding inside the tile
              childrenPadding: EdgeInsets.zero,
              // Remove padding inside the children
              leading: IconButton(
                icon: Container(
                    color: AppColors.meruYellow,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Icon(Icons.ac_unit_sharp, color: AppColors.meruBlack),
                    )),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                'Public Health (08 Points)',
                style: TextStyle(
                  color: AppColors.meruBlack,
                  fontFamily: 'Poppins',
                  fontSize: 14.0,
                ),
              ),
              trailing: Icon(Icons.expand_more),
              children: [
                Card(
                  margin: EdgeInsets.all(8.0),
                  color: AppColors.meruWhite,
                  elevation: 0, // Remove the shadow
                  child: ExpansionTile(
                    backgroundColor: Colors.transparent,
                    tilePadding: EdgeInsets.zero,
                    // Remove padding inside the tile
                    childrenPadding: EdgeInsets.zero,
                    // Remove padding inside the children
                    leading: IconButton(
                      icon: Container(
                          color: AppColors.meruYellow,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('1'))),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: Text(
                      'Correct Safety Attire(04)',
                      style: TextStyle(
                        color: AppColors.meruBlack,
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                      ),
                    ),
                    children: [
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        color: AppColors.meruWhite, // Remove the shadow
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'The Attendents are wearing clean uniform'),
                                  Text('1'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton<int?>(
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
                                      setState(() {});
                                      // Handle dropdown value change event here
                                    },
                                  ),
                                  Text('-'),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        color: AppColors.meruWhite, // Remove the shadow
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'The Attendents are wearing clean uniform'),
                                  Text('1'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton<int?>(
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
                                      setState(() {});
                                      // Handle dropdown value change event here
                                    },
                                  ),
                                  Text('-'),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(8.0),
                  color: AppColors.meruWhite,
                  elevation: 0, // Remove the shadow
                  child: ExpansionTile(
                    backgroundColor: Colors.transparent,
                    tilePadding: EdgeInsets.zero,
                    // Remove padding inside the tile
                    childrenPadding: EdgeInsets.zero,
                    // Remove padding inside the children
                    leading: IconButton(
                      icon: Container(
                          color: AppColors.meruYellow,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('2'))),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: Text(
                      'Safety Awareness(06)',
                      style: TextStyle(
                        color: AppColors.meruBlack,
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                      ),
                    ),
                    children: [
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        color: AppColors.meruWhite, // Remove the shadow
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'The Attendents are wearing clean uniform'),
                                  Text('1'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton<int?>(
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
                                      setState(() {});
                                      // Handle dropdown value change event here
                                    },
                                  ),
                                  Text('-'),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        color: AppColors.meruWhite, // Remove the shadow
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'The Attendents are wearing clean uniform'),
                                  Text('1'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton<int?>(
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
                                      setState(() {});
                                      // Handle dropdown value change event here
                                    },
                                  ),
                                  Text('-'),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // Removes the corner radius
                                      ),
                                      minimumSize: Size(15.0,
                                          25.0), // Set both width and height to the same value
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
          minimumSize: Size(20, 40.0), // Minimum width if needed
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

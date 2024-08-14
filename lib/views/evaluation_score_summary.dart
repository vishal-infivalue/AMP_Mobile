import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:amp/providers_vm/generateOtp_provider.dart';
import 'package:amp/response/score_card_response.dart';
import 'package:amp/utils/global_values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as sf;
import '../response/averageScoreResponse.dart';
import '../routes/route_names.dart';
import '../utils/app_colors.dart';

class EvaluationScorePage extends StatefulWidget {
  final String omc;
  final String site;
  final String address;
  final String contacts;
  final String ocr;
  final String grading;

  const EvaluationScorePage({
    Key? key,
    required this.omc,
    required this.site,
    required this.address,
    required this.contacts,
    required this.ocr,
    required this.grading,
  }) : super(key: key);

  @override
  _EvaluationScorePageState createState() => _EvaluationScorePageState();
}

class _EvaluationScorePageState extends State<EvaluationScorePage> {
  bool _showLoadingSubmit = false;
  late Future<void> _scoreCardFuture;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final logInProvider = Provider.of<APIProvider>(context);
    logInProvider.getclusteravgscore(context);
    GlobalVariables gb = GlobalVariables();
    String auditId = gb.completed_auditId_gb;
    Map<String, dynamic> data = {
      "id": "$auditId",
    };

    String jsonData = jsonEncode(data);
    print(jsonData);

    _scoreCardFuture = logInProvider.getScoreCard(jsonData, context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Evaluation Score Summary',
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: AppColors.meruRed,
              fontSize: 14.0,
              fontStyle: FontStyle.normal,
            )),
        backgroundColor: AppColors.meruWhite,
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_sharp, color: AppColors.meruRed),
          // Blue icon
          onPressed: () => Navigator.pop(context), // Handle back button press
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // First row with a single text
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    logInProvider.heading,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 6.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Total Score',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          // Light green background color
                          border: Border.all(
                            color: Colors.black, // Green border color
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          "-%",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // White text color
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Second row with two texts
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Grade',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          // Light green background color
                          border: Border.all(
                            color: Colors.green, // Green border color
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          logInProvider.overallgrade,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // White text color
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              color: AppColors.meruWhite,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // First row with a single text
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Station Name',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11.0,
                                  ),
                                ),
                                Text(
                                  logInProvider.stationname,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Station Code',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11.0,
                                  ),
                                ),
                                Text(
                                  logInProvider.stationcode,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Station Type',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11.0,
                                  ),
                                ),
                                Text(
                                  logInProvider.stationtype,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // First row with a single text
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'SM Name',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11.0,
                                  ),
                                ),
                                Text(
                                  logInProvider.staymanagername,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'RM Name',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11.0,
                                  ),
                                ),
                                Text(
                                  logInProvider.clustermanagername,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'CM Name',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11.0,
                                  ),
                                ),
                                Text(
                                  logInProvider.clustermanagername,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // First row with a single text
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Auditor Name',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11.0,
                                  ),
                                ),
                                Text(
                                  logInProvider.clustermanagername,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Start time of Audit',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11.0,
                                  ),
                                ),
                                Text(
                                  logInProvider.auditstarttime,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  '',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'End time of Audit',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11.0,
                                  ),
                                ),
                                Text(
                                  logInProvider.auditendtime,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  '',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 1,
            ),

            SizedBox(
              height: 2,
            ),
            Card(
              margin: EdgeInsets.all(8.0),
              color: AppColors.meruWhite,
              elevation: 0, // Remove the shadow
              child: ExpansionTile(
                backgroundColor: Colors.transparent,
                tilePadding: EdgeInsets.zero, // Remove padding inside the tile
                childrenPadding: EdgeInsets.zero, // Remove padding inside the children
                leading: IconButton(
                  icon: Container(
                    color: AppColors.meruYellow,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.ac_unit_sharp, color: AppColors.meruBlack),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(logInProvider.evolscoresummary),
                trailing: Icon(Icons.expand_more),
                children: logInProvider.header.isNotEmpty
                    ? logInProvider.header.map((item) {
                  return Card(
                    margin: EdgeInsets.zero,
                    elevation: 0,
                    color: AppColors.meruWhite, // Remove the shadow
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  item.sectionName ?? 'N/A',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                                'Safety - ${item.obtainedScore ?? '0%'}',
                                style: TextStyle(
                                  color: AppColors.meruBlack,
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: _getGradeColor(item.grade),
                                  border: Border.all(
                                    color: _getGradeColor(item.grade),
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  item.grade,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              /*Container(
                                padding: EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  border: Border.all(
                                    color: Colors.green,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  item.grade ?? 'N/A',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),*/
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Non Compliance Score'),
                            ],
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 2,
                            indent: 0,
                            endIndent: 0,
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('No of NCs'),
                              Text(item.ncTotal ?? '0'),
                              Text('Maximum Score'),
                              Text(item.maxScore ?? 'N/A'),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('NC %'),
                              Text(item.ncPercent ?? '0%'),
                              Text('Obtained Score'),
                              Text(item.obtainedScore ?? '0'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList()
                    : [Center(child: Text('No data available'))],
              ),
            ),
            Card(
              margin: EdgeInsets.all(8.0),
              color: AppColors.meruWhite,
              elevation: 0, // Remove the shadow
              child: ExpansionTile(
                backgroundColor: Colors.transparent,
                tilePadding: EdgeInsets.zero, // Remove padding inside the tile
                childrenPadding: EdgeInsets.zero, // Remove padding inside the children
                leading: IconButton(
                  icon: Container(
                    color: AppColors.meruYellow,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.ac_unit_sharp, color: AppColors.meruBlack),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(logInProvider.cumusummary),
                trailing: Icon(Icons.expand_more),
                children: logInProvider.subheader.isNotEmpty
                    ? logInProvider.subheader.map((item) {
                  return Card(
                    margin: EdgeInsets.zero,
                    elevation: 0,
                    color: AppColors.meruWhite, // Remove the shadow
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  item.sectionName ?? 'N/A',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                                'Score - ${item.obtainedScore ?? '0%'}',
                                style: TextStyle(
                                  color: AppColors.meruBlack,
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: _getGradeColor(item.grade),
                                  border: Border.all(
                                    color: _getGradeColor(item.grade),
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  item.grade,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              /*Container(
                                padding: EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  border: Border.all(
                                    color: Colors.green,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  item.grade ?? 'N/A',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),*/
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Non Compliance Score'),
                            ],
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 2,
                            indent: 0,
                            endIndent: 0,
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('No of NCs'),
                              Text(item.ncTotal ?? '0'),
                              Text('Maximum Score'),
                              Text(item.maxScore ?? 'N/A'),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('NC %'),
                              Text(item.ncPercent ?? '0%'),
                              Text('Obtained Score'),
                              Text(item.obtainedScore ?? '0'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList()
                    : [Center(child: Text('No data available'))],
              ),
            ),
            Card(
              margin: EdgeInsets.all(8.0),
              color: AppColors.meruWhite,
              elevation: 0, // Remove the shadow
              child: ExpansionTile(
                backgroundColor: Colors.transparent,
                tilePadding: EdgeInsets.zero, // Remove padding inside the tile
                childrenPadding: EdgeInsets.zero, // Remove padding inside the children
                leading: IconButton(
                  icon: Container(
                    color: AppColors.meruYellow,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.ac_unit_sharp, color: AppColors.meruBlack),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text('PREVIOUS PERFORMANCES'),
                trailing: Icon(Icons.expand_more),
                children: logInProvider.previousScore.isNotEmpty
                    ? logInProvider.previousScore.map((item) {
                  return Card(
                    margin: EdgeInsets.zero,
                    elevation: 0,
                    color: AppColors.meruWhite, // Remove the shadow
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  item.sectionName ?? 'N/A',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                                'Score - ${item.obtainedScore ?? '0%'}',
                                style: TextStyle(
                                  color: AppColors.meruBlack,
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: _getGradeColor(item.grade),
                                  border: Border.all(
                                    color: _getGradeColor(item.grade),
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  item.grade,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              /*Container(
                                padding: EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  border: Border.all(
                                    color: Colors.green,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  item.grade ?? 'N/A',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),*/
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Non Compliance Score'),
                            ],
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 2,
                            indent: 0,
                            endIndent: 0,
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('No of NCs'),
                              Text(item.ncTotal ?? '0'),
                              Text('Maximum Score'),
                              Text(item.maxScore ?? 'N/A'),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('NC %'),
                              Text(item.ncPercent ?? '0%'),
                              Text('Obtained Score'),
                              Text(item.obtainedScore ?? '0'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList()
                    : [Center(child: Text('No data available'))],
              ),
            ),

            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: AppColors.meruBlack,
                  fontSize: 12.0,
                  fontStyle: FontStyle.normal,
                ),
                decoration: InputDecoration(
                  labelText: 'Remark',
                  labelStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                    color: AppColors.meruBlack,
                    fontSize: 12.0,
                    fontStyle: FontStyle.normal,
                  ),
                  // Use labelText for title-like hint
                  errorBorder: OutlineInputBorder(
                    // Set red border for errors
                    borderSide: BorderSide(color: AppColors.meruBlack),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // Maintain default border on focus
                    borderSide: BorderSide(
                        color: AppColors.meruBlack), // Use theme color
                  ),
                ),
              ),
            ),
            Center(
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Name & Sign of SS/MS',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: AppColors.meruBlack,
                                fontSize: 12.0,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal)),
                      ),
                      Text(
                        'Shadreck Nyoni',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                        ),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.meruRed,
                          foregroundColor: AppColors.meruWhite,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                        label: _showLoadingSubmit
                            ? CircularProgressIndicator(
                                color: AppColors.meruYellow,
                                strokeWidth: 1.0,
                              )
                            : Text(
                                "Signature",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.meruWhite,
                                  fontSize: 12.0,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                        onPressed: () async {
                          setState(() {
                            _showLoadingSubmit = true;
                          });
                          await Future.delayed(const Duration(seconds: 2));
                          Navigator.pushNamed(
                              context, Routenames.witnessSignature);
                          setState(() {
                            _showLoadingSubmit = false;
                          });
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Table(
                        border: TableBorder.all(color: Colors.black),
                        columnWidths: const {
                          0: IntrinsicColumnWidth(),
                        },
                        children: [
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('  \n     \n  ',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: AppColors.meruBlack,
                                        fontSize: 12.0,
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Name & Sign of CM/RH',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: AppColors.meruBlack,
                                fontSize: 12.0,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal)),
                      ),
                      Text(
                        'Muchemwa Silungwe',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                        ),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.meruRed,
                          foregroundColor: AppColors.meruWhite,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                        label: _showLoadingSubmit
                            ? CircularProgressIndicator(
                                color: AppColors.meruYellow,
                                strokeWidth: 1.0,
                              )
                            : Text(
                                "Signature",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.meruWhite,
                                  fontSize: 12.0,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                        onPressed: () async {
                          setState(() {
                            _showLoadingSubmit = true;
                          });
                          await Future.delayed(const Duration(seconds: 2));
                          Navigator.pushNamed(
                              context, Routenames.signaturePadScreen);
                          setState(() {
                            _showLoadingSubmit = false;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(Section header) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: AppColors.meruWhite,
      elevation: 0,  // Remove the shadow
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: AppColors.meruYellow,
                    border: Border.all(
                      color: AppColors.meruYellow,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    header.sectionName!,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  '${header.sectionName} - ${header.obtainedPercent}%',
                  style: TextStyle(
                    color: AppColors.meruBlack,
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: _getGradeColor(header.grade),
                    border: Border.all(
                      color: _getGradeColor(header.grade),
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    header.grade,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Non Compliance              Score'),
              ],
            ),
            Divider(
              color: Colors.grey,
              thickness: 2,
              indent: 0,
              endIndent: 0,
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('No of NCs'),
                Text(header.ncTotal),
                Text('Maximum Score'),
                Text(header.maxScore),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('NC %'),
                Text(header.ncPercent),
                Text('Obtained Score'),
                Text(header.obtainedScore),
              ],
            ),
          ],
        ),
      ),
    );
  }

// Function to build expandable card
  Widget buildExpandableCard(BuildContext context, List<Section> headers) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: AppColors.meruWhite,
      elevation: 0, // Remove the shadow
      child: ExpansionTile(
        backgroundColor: Colors.transparent,
        tilePadding: EdgeInsets.zero, // Remove padding inside the tile
        childrenPadding: EdgeInsets.zero, // Remove padding inside the children
        leading: IconButton(
          icon: Container(
            color: AppColors.meruYellow,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.ac_unit_sharp, color: AppColors.meruBlack),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Evaluation Score Summary '),
        trailing: Icon(Icons.expand_more),
        children: [
          Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5, // Adjust the height as needed
            ),
            child: ListView.builder(
              itemCount: headers.length,
              itemBuilder: (context, index) {
                return buildCard(headers[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

Color _getGradeColor(String grade) {
  switch (grade) {
    case 'A':
      return Colors.green;
    case 'B':
      return Colors.blue;
    case 'C':
      return Colors.orange;
    case 'D':
      return Colors.red;
    default:
      return Colors.grey;
  }
}

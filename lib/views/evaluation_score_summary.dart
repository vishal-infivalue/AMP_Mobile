import 'dart:convert';

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
    if (logInProvider.header.isNotEmpty) {
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
            onPressed: () {
              logInProvider.header.clear();
              logInProvider.subheader.clear();
              logInProvider.previousScore.clear();



              // Clear the header
              Navigator.pop(context); // Navigate back
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          // Center content within the column
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // Center align text within the column
                          children: [
                            Text(
                              logInProvider.heading,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign:
                                  TextAlign.center, // Center the text itself
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // Center content within the column
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // Center align text within the column
                          children: [
                            Text(
                              'Total Score',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.0,
                                color: AppColors.merubg,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign:
                                  TextAlign.center, // Center the text itself
                            ),
                            SizedBox(height: 8.0),
                            // Space between text and container
                            Container(
                              padding: EdgeInsets.all(14.0),
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                border: Border.all(
                                  color: Colors.black, // Border color
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                "-%",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Text color
                                ),
                                textAlign:
                                    TextAlign.center, // Center the text itself
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // Center content within the column
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // Center align text within the column
                          children: [
                            Text(
                              'Grade',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.0,
                                color: AppColors.merubg,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign:
                                  TextAlign.center, // Center the text itself
                            ),
                            SizedBox(height: 8.0),
                            // Space between text and container
                            Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(
                                  color: Colors.green, // Border color
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                logInProvider.overallgrade,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, // Text color
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
              Container(
                color: AppColors.meruWhite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // First column
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Station Name',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11.0,
                                    color: AppColors.merubg,
                                  ),
                                ),
                                SizedBox(height: 4.0),
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
                        // Second column
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Station Code',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11.0,
                                    color: AppColors.merubg,
                                  ),
                                ),
                                SizedBox(height: 4.0),
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
                        // Third column
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Station Type',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11.0,
                                    color: AppColors.merubg,
                                  ),
                                ),
                                SizedBox(height: 4.0),
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
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 16,
                      endIndent: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // First column
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SM Name',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11.0,
                                    color: AppColors.merubg,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                // Space between title and value
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
                        // Second column
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'RM Name',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: AppColors.merubg,
                                    fontSize: 11.0,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                // Space between title and value
                                Text(
                                  logInProvider.clustermanagername,
                                  // Assuming this is the correct property
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Third column
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CM Name',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: AppColors.merubg,
                                    fontSize: 11.0,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                // Space between title and value
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
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 16,
                      endIndent: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // First column
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Auditor Name',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: AppColors.merubg,
                                    fontSize: 11.0,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  logInProvider.auditorname,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Second column
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Start time of Audit',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: AppColors.merubg,
                                    fontSize: 11.0,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  logInProvider.auditstarttime,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Third column
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'End time of Audit',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: AppColors.merubg,
                                    fontSize: 11.0,
                                  ),
                                ),
                                SizedBox(height: 4.0),
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
                      ],
                    ),
                  ],
                ),
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
                  tilePadding: EdgeInsets.zero,
                  // Remove padding inside the tile
                  childrenPadding: EdgeInsets.zero,
                  // Remove padding inside the children
                  leading: IconButton(
                    icon: Container(
                      color: AppColors.meruYellow,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.ac_unit_sharp,
                            color: AppColors.meruBlack),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  title: Text(logInProvider.evolscoresummary),
                  trailing: Icon(Icons.expand_more),

                  children: logInProvider.header.isNotEmpty
                      ? logInProvider.header.asMap().entries.map((entry) {
                          int index = entry.key + 1; // Start index at 1
                          var item = entry.value;
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
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Card(
                                      margin: EdgeInsets.zero,
                                      elevation: 0,
                                      color: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Colors.grey, // Border color
                                          width: 0.4, // Border width
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(12.0),
                                            decoration: BoxDecoration(
                                              color: AppColors.meruYellow,
                                              border: Border.all(
                                                color: AppColors
                                                    .meruYellow, // Yellow border color
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Text(
                                              "$index",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '${item.sectionName ?? 'N/A'} - ${item.obtainedScore + "%" ?? '0%'}',
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
                                                color:
                                                    _getGradeColor(item.grade),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
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
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text('Non Compliance Score'),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('No of NCs'),
                                        Text(item.ncTotal ?? '0'),
                                        Text('Maximum Score'),
                                        Text(item.maxScore ?? 'N/A'),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                  tilePadding: EdgeInsets.zero,
                  // Remove padding inside the tile
                  childrenPadding: EdgeInsets.zero,
                  // Remove padding inside the children
                  leading: IconButton(
                    icon: Container(
                      color: AppColors.meruYellow,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.ac_unit_sharp,
                            color: AppColors.meruBlack),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  title: Text(logInProvider.cumusummary),
                  trailing: Icon(Icons.expand_more),
                  children: logInProvider.subheader.isNotEmpty
                      ? logInProvider.subheader.asMap().entries.map((entry) {
                          int index = entry.key + 1; // Start index at 1
                          var item = entry.value;

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
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Card(
                                      margin: EdgeInsets.zero,
                                      elevation: 0,
                                      color: AppColors.meruWhite,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Colors.grey, // Border color
                                          width: 0.4, // Border width
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(12.0),
                                            decoration: BoxDecoration(
                                              color: AppColors.meruYellow,
                                              border: Border.all(
                                                color: AppColors
                                                    .meruYellow, // Yellow border color
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Text(
                                              '$index',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '${item.sectionName ?? 'N/A'} - ${item.obtainedScore + "%" ?? '0%'}',
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
                                                color:
                                                    _getGradeColor(item.grade),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
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
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text('Non Compliance Score'),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('No of NCs'),
                                        Text(item.ncTotal ?? '0'),
                                        Text('Maximum Score'),
                                        Text(item.maxScore ?? 'N/A'),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                  tilePadding: EdgeInsets.zero,
                  // Remove padding inside the tile
                  childrenPadding: EdgeInsets.zero,
                  // Remove padding inside the children
                  leading: IconButton(
                    icon: Container(
                      color: AppColors.meruYellow,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.ac_unit_sharp,
                            color: AppColors.meruBlack),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                          color: AppColors.meruYellow,
                                          border: Border.all(
                                            color: AppColors
                                                .meruYellow, // Yellow border color
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
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
                                        item.sectionName ?? 'N/A',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        '${item.obtainedScore ?? '0%'}',
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('No of NCs'),
                                      Text(item.ncTotal ?? '0'),
                                      Text('Maximum Score'),
                                      Text(item.maxScore ?? 'N/A'),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
    } else {
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
            onPressed: () =>
                Navigator.pop(context), // Handle back button press
          ),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 180,
                ),
                Container(
                  width: 250,
                  height: 130,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/nodata.png',
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'No data found',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.0,
                    color: Colors.black, // Adjust the color as needed
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  Widget buildCard(Section header) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: AppColors.meruWhite,
      elevation: 0, // Remove the shadow
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
        tilePadding: EdgeInsets.zero,
        // Remove padding inside the tile
        childrenPadding: EdgeInsets.zero,
        // Remove padding inside the children
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
              maxHeight: MediaQuery.of(context).size.height *
                  0.5, // Adjust the height as needed
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

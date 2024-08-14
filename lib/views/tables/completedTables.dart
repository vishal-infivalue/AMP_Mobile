import 'package:amp/routes/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/constant_strings.dart';
import '../../utils/global_values.dart';

/*class CompletedTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text('Completed Audits',
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: AppColors.meruRed,
              fontSize: 14.0,
              fontStyle: FontStyle.normal,
            )
        ),
        backgroundColor: AppColors.meruWhite,
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_sharp, color: AppColors.meruRed), // Blue icon
          onPressed: () => Navigator.pop(context), // Handle back button press
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Completed Audits in the last 15 days.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: AppColors.meruBlack,
                    fontSize: 12.0,
                    letterSpacing: 1,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              // New Table Section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  border: TableBorder.all(color: Colors.black),
                  columnWidths: const {
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                    3: FlexColumnWidth(),
                    4: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: AppColors.meruRed,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Station Name',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.meruWhite,
                              fontSize: 12.0,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Audit Type',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.meruWhite,
                              fontSize: 12.0,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Last Audited Date',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.meruWhite,
                              fontSize: 12.0,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'View Audit',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.meruWhite,
                              fontSize: 12.0,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Replace the below rows with actual data
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Libala',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: AppColors.meruBlack,
                              fontSize: 12.0,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'ERB Consumer',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: AppColors.meruBlack,
                              fontSize: 12.0,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '11th June 2024',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: AppColors.meruBlack,
                              fontSize: 12.0,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routenames.evaluationScorePage);
                              // Navigator.pushNamed(context, RouteName.form);
                            },
                            child: Text(
                              'View Report',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.blue,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Katuba',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: AppColors.meruBlack,
                              fontSize: 12.0,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'ERB Technical',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: AppColors.meruBlack,
                              fontSize: 12.0,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '14th June 2024',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: AppColors.meruBlack,
                              fontSize: 12.0,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routenames.evaluationScorePage);
                              // Navigator.pushNamed(context, RouteName.form);
                            },
                            child: Text(
                              'View Report',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.blue,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Libala',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: AppColors.meruBlack,
                              fontSize: 12.0,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'ERB RO Hygine',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: AppColors.meruBlack,
                              fontSize: 12.0,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '14th June 2024',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: AppColors.meruBlack,
                              fontSize: 12.0,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routenames.evaluationScorePage);
                            },
                            child: Text(
                              'View Report',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.blue,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Libala',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: AppColors.meruBlack,
                              fontSize: 12.0,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'ERB Technical',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: AppColors.meruBlack,
                              fontSize: 12.0,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '16th June 2024',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: AppColors.meruBlack,
                              fontSize: 12.0,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routenames.evaluationScorePage);
                            },
                            child: Text(
                              'View Report',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.blue,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Add more rows as needed
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}*/

class CompletedTable extends StatelessWidget {
  const CompletedTable({super.key});

  @override
  Widget build(BuildContext context) {

    GlobalVariables gb = GlobalVariables();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Completed Audits',
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  gb.completedaudits_gb,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: AppColors.meruBlack,
                    fontSize: 12.0,
                    letterSpacing: 1,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Card(
                elevation: 4,
                color: AppColors.meruWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Number of Completed Audits',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          gb.numberOfAuditsCompleted_gb,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Table(
                  border: TableBorder.all(color: Colors.black),
                  columnWidths: const {
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                    3: FlexColumnWidth(),
                    4: FlexColumnWidth(),
                  },
                  children: [
                    const TableRow(
                      decoration: BoxDecoration(
                        color: AppColors.meruRed,
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Station Name',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.meruWhite,
                              fontSize: 12.0,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Audit Type',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.meruWhite,
                              fontSize: 12.0,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Due Date',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.meruWhite,
                              fontSize: 12.0,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Last Audit Date',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.meruWhite,
                              fontSize: 12.0,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'View Audit',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.meruWhite,
                              fontSize: 12.0,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ...gb.completedAuditList_gb.map((audit) {
                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              audit.stationname,
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: AppColors.meruBlack,
                                fontSize: 10.0,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              audit.audittype,
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: AppColors.meruBlack,
                                fontSize: 10.0,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              audit.duedate,
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: AppColors.meruBlack,
                                fontSize: 10.0,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              audit.lastauditdate,
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: AppColors.meruBlack,
                                fontSize: 10.0,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                             /* Container(
                                width: 50,
                                height: 30,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  'assets/images/icon_start.png',
                                ),
                              ),*/

                              GestureDetector(
                                onTap: () {

                                  gb.completed_auditId_gb = audit.auditid;

                                  // Handle the tap event here
                                 switch(audit.audittype){
                                   case ConstantStrings.ERBTECH:
                                     Navigator.pushNamed(
                                         context, Routenames.evaluationScorePage);

                                   case ConstantStrings.ERBCONA:
                                     Navigator.pushNamed(
                                         context, Routenames.evaluationScorePage);
                                     break;

                                   default:
                                     ScaffoldMessenger.of(context)
                                         .showSnackBar(const SnackBar(
                                         content: Text(
                                             "Under Development")));
                                 }
                                  // You can navigate to another screen or perform any other action
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'View Audit',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.blue,
                                      fontSize: 12.0,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                              )

                             /* InkWell(
                                child: const Text(
                                  '\nView Audit',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.blue,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),*/
                            ],
                          )
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}








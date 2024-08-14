import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers_vm/generateOtp_provider.dart';
import '../../utils/app_colors.dart';

class TopPerformingTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logInProvider = Provider.of<APIProvider>(context);
    logInProvider.getperformingstations(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Top Performing Stations',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: AppColors.meruRed,
            fontSize: 14.0,
            fontStyle: FontStyle.normal,
          ),
        ),
        backgroundColor: AppColors.meruWhite,
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_sharp, color: AppColors.meruRed),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 17.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Bottom 3 performing Stations.',
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
              SizedBox(height: 3.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  border: TableBorder.all(color: Colors.black),
                  columnWidths: const {
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: AppColors.meruRed,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.meruRed,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              'Station Name',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 12.0,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text(
                              'Station Manager',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 12.0,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              'Average Score',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 12.0,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Dynamically generated rows
                    ...logInProvider.stationList.map((station) {
                      double avgscore = station.avgScore;
                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              station.stationCode,
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
                              station.managername,
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
                              "$avgscore",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: AppColors.meruBlack,
                                fontSize: 12.0,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
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

/*class TopPerformingTable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
        Text('Top Performing Stations',
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
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Top 3 performing Stations.',
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


              SizedBox(
                height: 3.0,
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
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.meruRed,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              'Station Name',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 12.0,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text(
                              'Station Manager',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 12.0,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              'Average Score',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 12.0,
                                letterSpacing: 1,
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
                            'ZP - 17',
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
                            'Chartiy Mulena',
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
                            '55 % Top',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: AppColors.meruBlack,
                              fontSize: 12.0,
                              fontStyle: FontStyle.normal,
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
                            'ZP - 23',
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
                            'Shadreac Nyoni',
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
                            '53.54 % 2nd',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: AppColors.meruBlack,
                              fontSize: 12.0,
                              fontStyle: FontStyle.normal,
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
                            'ZP - 78',
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
                            'Kabwe Kunda',
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
                            '50.51 % 3rd',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: AppColors.meruBlack,
                              fontSize: 12.0,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
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








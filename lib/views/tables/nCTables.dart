import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/app_colors.dart';


class NonComplianceTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text('Non Compliance Aging',
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
              SizedBox(
                height: 17.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Non Compliance Ageing Status',
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
                            'Station Manager',
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
                            'NC Name',
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
                            'NC Opened Date',
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
                            'Age \n (in Days)',
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
                            'Charity Mulenga',
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
                            'The attendances are wearing clean uniform. No oil Spil ',
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
                            '25th April 2024 ',
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
                            '64 days ',
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
                            'Charity Mulenga',
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
                            'The price and display not intact. Make it clear',
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
                            '25th April 2024 ',
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
                            '64 days ',
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
                            'Shaowpeck Nyoni',
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
                            'Product c..... w... Make it visible',
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
                            '20th April 2024 ',
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
                            '69 days ',
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
                            'ZP - 76',
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
                            'Water Dip, Yes in the tank at some points.',
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
                            '22nd April 2024 ',
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
                            '67 days ',
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
}








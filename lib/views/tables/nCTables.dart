import 'package:amp/routes/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/app_colors.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/app_colors.dart';

import 'package:amp/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/app_colors.dart';

class NonComplianceTable extends StatefulWidget {
  @override
  _NonComplianceTableState createState() => _NonComplianceTableState();
}

class _NonComplianceTableState extends State<NonComplianceTable> {
  void _openFilterDrawer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.5, // Half the screen width
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Filter',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: AppColors.meruBlack,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select Option',
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['Option 1', 'Option 2', 'Option 3']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    // Handle dropdown value change
                  },
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Implement search functionality
                        },
                        child: Text('Search'),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Implement clear functionality
                        },
                        child: Text('Clear'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Non Compliance Aging',
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
          actions: [
            TextButton(
              onPressed: _openFilterDrawer,
              child: Text(
                'Filter',
                style: TextStyle(
                  color: AppColors.meruRed,
                  fontSize: 14.0,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
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
    'Number of open NCs by age ',
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
    5: FlexColumnWidth(),
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
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Container(
    width: 50,
    height: 30,
    decoration: const BoxDecoration(
    shape: BoxShape.circle,
    ),
    child: Image.asset(
    'assets/images/icon_start.png',
    ),
    ),
    InkWell(
    onTap: () {
    Navigator.pushNamed(
    context, Routenames.ncDetailPage);
    },
    child: const Text(
      'Go\n',
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.blue,
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.underline,
      ),
    ),
    ),
    ],
    )),
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


/*class NonComplianceTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Non Compliance Aging',
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
                  'Number of open NCs by age ',
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
                    5: FlexColumnWidth(),
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
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    'assets/images/icon_start.png',
                                  ),
                                ),
                                InkWell(
                                  onTap: (){

                                    Navigator.pushNamed(context, Routenames.ncDetailPage);

                                  },
                                  child: const Text(
                                    'Go\n',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.blue,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            )),
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

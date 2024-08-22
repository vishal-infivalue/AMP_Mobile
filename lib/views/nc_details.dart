import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class NCDetailPage extends StatefulWidget {
  final String omc;
  final String site;
  final String address;
  final String contacts;
  final String ocr;
  final String grading;

  const NCDetailPage({
    super.key,
    required this.omc,
    required this.site,
    required this.address,
    required this.contacts,
    required this.ocr,
    required this.grading,
  });

  @override
  _NCDetailPageState createState() => _NCDetailPageState();
}

class _NCDetailPageState extends State<NCDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NC Details',
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: AppColors.meruRed,
              fontSize: 14.0,
              fontStyle: FontStyle.normal,
            )),
        backgroundColor: AppColors.meruWhite,
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_sharp, color: AppColors.meruRed),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: AppColors.meruWhite,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.meruRed,
                ),
                child: Text(
                  'Navigation',
                  style: TextStyle(
                    color: AppColors.meruWhite,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  // Add navigation logic here
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  // Add navigation logic here
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                  // Add logout logic here
                },
              ),
            ],
          ),
        ),
        width: MediaQuery.of(context).size.width * 0.5, // Half page width
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                                "logInProvider.stationname",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                                "logInProvider.stationname",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                                "logInProvider.stationname",
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
                                'Station Name',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.0,
                                  color: AppColors.merubg,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                "logInProvider.stationname",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                                "logInProvider.stationname",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                                "logInProvider.stationname",
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
                ],
              ),
            ),
            SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'NC Assigned to : ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.merubg,
                      fontSize: 11.0,
                    ),
                  ),
                  Text(
                    'Murali Manohar',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.meruBlack,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Audit Question : ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.merubg,
                      fontSize: 11.0,
                    ),
                  ),
                  Text(
                    'Fuel Dispenser',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.meruBlack,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Audit Response : ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.merubg,
                      fontSize: 11.0,
                    ),
                  ),
                  Text(
                    'Present = 0',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.meruBlack,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Audit Score : ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.merubg,
                      fontSize: 11.0,
                    ),
                  ),
                  Text(
                    'Good',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.meruBlack,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Critical NC : ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.merubg,
                      fontSize: 11.0,
                    ),
                  ),
                  Text(
                    'Yes',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.meruBlack,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Correction : ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.merubg,
                      fontSize: 11.0,
                    ),
                  ),
                  Text(
                    'Yes',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.meruBlack,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Notes:',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppColors.merubg,
                  fontSize: 11.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppColors.meruBlack,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

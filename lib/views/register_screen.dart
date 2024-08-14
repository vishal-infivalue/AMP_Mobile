/*
import 'package:amp/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({required Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}


class _RegisterScreenState extends State<RegisterScreen> {

  void initState() {
    super.initState();
    _showPermissionsDialog();
  }

  Future<void> _showPermissionsDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false, // Dialog won't close unless the button is clicked
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permissions Required', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Audit Management Platform requires the following permissions to function properly:",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 10),
              Text(
                "1. Camera Permission: To capture photograph.\n"
                    "2. Storage Permission: To store and record files related.\n"
                    "3. Location Permission: To fetch current location required to maintain statistics.",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('I understand', style: TextStyle(color: AppColors.meruRed)),
              onPressed: () {
                Navigator.of(context).pop();
                requestPermissions();
              },
            ),
          ],
        );
      },
    );
  }


  Future<void> requestPermissions() async {
    // Request camera permission
    if (await Permission.camera.request().isGranted) {
      // Camera permission granted
    } else {
      // Camera permission denied
    }

    // Request location permission
    if (await Permission.location.request().isGranted) {
      // Location permission granted
    } else {
      // Location permission denied
    }

    // Request storage permission
    if (await Permission.storage.request().isGranted) {
      // Storage permission granted
    } else {
      // Storage permission denied
    }

    // Optionally, you can also check the status of permissions like this:
    PermissionStatus cameraStatus = await Permission.camera.status;
    PermissionStatus locationStatus = await Permission.location.status;
    PermissionStatus storageStatus = await Permission.storage.status;

    if (cameraStatus.isGranted && locationStatus.isGranted && storageStatus.isGranted) {
      // All permissions granted
    } else {
      // One or more permissions denied
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.meruYellow,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: AppColors.meruRed,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                width: 180,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.meruYellow,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/splash_logo.png',
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'LogIn',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter your user Id. we'll send you a verification code so to your regsitered email id and phone number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: AppColors.meruYellow,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        prefix: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '(CM)-',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        suffixIcon: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 32,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => OtpScreen(key: Key(""),)),
                          );
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(AppColors.meruRed),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Generate OTP',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 28,
              ),
              Container(
                width: 60,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.meruYellow,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/menu_logo.png',
                ),
              ),

              Text(
                "@ Mount Meru ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Audit Management Platform 2024",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),


            ],
          ),
        ),
      ),
    );
  }
}

*/


import 'package:amp/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({required Key key}) : super(key: key);

  final CollectionReference baseUrlCollection = FirebaseFirestore.instance.collection('baseUrl');

  Future<void> fetchData() async {
    QuerySnapshot querySnapshot = await baseUrlCollection.get();

    for (var doc in querySnapshot.docs) {
      print(doc.data());
    }
  }

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPermissionsDialog();
    });
  }

  Future<void> _showPermissionsDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false, // Dialog won't close unless the button is clicked
      builder: (BuildContext context) {
        return AlertDialog(
          title : Text(
            "Permissions Required",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontStyle: FontStyle.normal,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Audit Management Platform requires the following permissions to function properly",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppColors.meruBlack,
                  fontSize: 14.0,
                  letterSpacing: 1,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.left,
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
              SizedBox(height: 10),
              Text(
                "• Camera Permission:\nTo capture photograph for an audit.\n\n"
                    "• Storage Permission:\nTo store and record internal files related to the application.\n\n"
                    "• Location Permission:\nTo fetch current location required for performing an audit.\n\n\n",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppColors.meruBlack,
                  fontSize: 12.0,
                  letterSpacing: 1,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('I understand', style: TextStyle(color: AppColors.meruRed,fontSize: 18.0,
                letterSpacing: 1,)),
              onPressed: () {
                Navigator.of(context).pop();
                requestPermissions();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> requestPermissions() async {
    // Request camera permission
    if (await Permission.camera.request().isGranted) {
      // Camera permission granted
    } else {
      // Camera permission denied
    }

    // Request location permission
    if (await Permission.location.request().isGranted) {
      // Location permission granted
    } else {
      // Location permission denied
    }

    // Request storage permission
    if (await Permission.storage.request().isGranted) {
      // Storage permission granted
    } else {
      // Storage permission denied
    }

    // Optionally, you can also check the status of permissions like this:
    PermissionStatus cameraStatus = await Permission.camera.status;
    PermissionStatus locationStatus = await Permission.location.status;
    PermissionStatus storageStatus = await Permission.storage.status;

    if (cameraStatus.isGranted && locationStatus.isGranted && storageStatus.isGranted) {
      // All permissions granted
    } else {
      // One or more permissions denied
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.meruYellow,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: AppColors.meruRed,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                width: 180,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.meruYellow,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/splash_logo.png',
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'LogIn',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter your user Id. we'll send you a verification code so to your registered email id and phone number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: AppColors.meruYellow,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        prefix: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '(CM)-',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        suffixIcon: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 32,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => OtpScreen(key: Key("value"))),
                          );
                        },
                        style: ButtonStyle(
                          foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(AppColors.meruRed),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Generate OTP',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 28,
              ),
              Container(
                width: 60,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.meruYellow,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/menu_logo.png',
                ),
              ),

              Text(
                "@ Mount Meru ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Audit Management Platform 2024",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

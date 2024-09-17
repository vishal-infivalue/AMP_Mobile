import 'dart:convert';
import 'dart:math';

import 'package:amp/utils/constant_strings.dart';
import 'package:amp/utils/global_values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers_vm/generateOtp_provider.dart';
import '../../routes/route_names.dart';
import '../../utils/app_colors.dart';
import '../../utils/shared_preference_helper.dart';



class AuditLogin extends StatefulWidget {
  final Map args;

  const AuditLogin({super.key, required this.args});

  // const AuditLogin({super.key});

  @override
  State<AuditLogin> createState() => _AuditLoginState();
}

class _AuditLoginState extends State<AuditLogin> {
  final SharedPreferenceHelper _sharedPrefs = SharedPreferenceHelper();
  final _formKey = GlobalKey<FormState>(); // Declare a GlobalKey for the Form
  final _employeeIdController = TextEditingController();
  bool _showLoading = false;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _employeeIdController.addListener(_checkInputLength);
  }

  void _checkInputLength() {
    setState(() {
      if (_employeeIdController.text.length == 8 ) {

        GlobalVariables gb = GlobalVariables();

        final logInProvider = Provider.of<APIProvider>(context, listen: false);

        Map<String, dynamic> data = {
          "id": _employeeIdController.text.toString(),
        };

        String jsonData = jsonEncode(data);
        print(jsonData);

        logInProvider.prevalidateUser(jsonData, context);
        _isButtonEnabled = gb.isButtonEnabled_gb;


      }
      else {
        print("ERROR");
        _isButtonEnabled = false;
      }
    });
  }

  @override
  void dispose() {
    _employeeIdController.removeListener(_checkInputLength);
    _employeeIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logInProvider =  Provider.of<APIProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.meruYellow,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: 100,
                    width: 150,
                    child: Image.asset("assets/images/menu_logo.png"),
                  ),
                ),
                Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: AppColors.meruBlack,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: TextAlign.left,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 8),
                  child: Text(
                    'Enter your user id. we’ll send you a verification code to your registered email id and phone number',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.merubg,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 20.0), // Space between TextField and Button

                SizedBox(
                  width: 300.0,
                  height: 50.0,
                  child: TextFormField(
                    controller: _employeeIdController,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: AppColors.meruRed,
                      fontSize: 12.0,
                      fontStyle: FontStyle.normal,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Enter your User ID',
                      labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        color: AppColors.meruRed,
                        fontSize: 12.0,
                        fontStyle: FontStyle.normal,
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: AppColors.meruRed,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.merubg),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.merubg),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your User ID';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  width: 300.0,
                  height: 50.0,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.meruRed,
                      foregroundColor: AppColors.meruWhite,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      minimumSize: Size(
                        MediaQuery.of(context).size.width * 0.2,
                        50.0,
                      ),
                    ),
                    label: logInProvider.loading
                        ? CircularProgressIndicator(
                      color: AppColors.meruYellow,
                      strokeWidth: 1.0,
                    )
                        : Text(
                      "Generate OTP",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        color: AppColors.meruWhite,
                        fontSize: 12.0,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    onPressed: true
                        ? () async {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> data = {
                          "id": _employeeIdController.text.toString(),
                        };

                        _sharedPrefs.saveString(ConstantStrings.userIdLoggedIn, _employeeIdController.text.toString());

                        String jsonData = jsonEncode(data);
                        print(jsonData);
                        logInProvider.generateOtp(jsonData, context);
                        if(_employeeIdController.text.toString() == "16031592" ||_employeeIdController.text.toString() == "18053354"||_employeeIdController.text.toString() == "160314050"){
                          Navigator.pushNamed(context, Routenames.otpScreen);
                        }


                      }
                    }
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

/*  @override
  Widget build(BuildContext context) {

    final logInProvider =  Provider.of<GenerateotpProviderProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.meruYellow,
      // Set the background color of the Scaffold
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center the content
              children: [
                // Logo
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: 100,
                    width: 150,
                    child: Image.asset("assets/images/menu_logo.png"),
                  ),
                ),

                Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: AppColors.meruBlack,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: TextAlign.left,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 8),
                  child: Text(
                    'Enter your user id. we’ll send you a verification code so to your registered email id and phone number ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.merubg,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                SizedBox(height: 20.0), // Space between TextField and Button

                // Employee ID field with validation
                SizedBox(
                  width: 300.0,
                  height: 50.0,
                  child: TextFormField(
                    controller: _employeeIdController,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: AppColors.meruRed,
                      fontSize: 12.0,
                      fontStyle: FontStyle.normal,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Enter your User ID',
                      labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        color: AppColors.meruRed,
                        fontSize: 12.0,
                        fontStyle: FontStyle.normal,
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: AppColors.meruRed,
                      ),
                      // Use labelText for title-like hint
                      errorBorder: OutlineInputBorder(
                        // Set red border for errors
                        borderSide: BorderSide(color: AppColors.merubg),
                      ),
                      focusedBorder: OutlineInputBorder(
                        // Maintain default border on focus
                        borderSide:
                            BorderSide(color: AppColors.merubg), // Use theme color
                      ),
                    ),
                    validator: (value) {


                      if (value == null || value.isEmpty) {
                        return 'Please enter your User ID';
                      }
                      return null; // Validation successful
                    },
                  ),
                ),

                const SizedBox(height: 20.0),

                Container(
                  width: 300.0,
                  height: 50.0,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.meruRed,
                      foregroundColor: AppColors.meruWhite,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      minimumSize: Size(
                        MediaQuery.of(context).size.width * 0.2,
                        50.0,
                      ),
                    ),
                    label: _showLoading
                        ? CircularProgressIndicator(
                      color: AppColors.meruYellow,
                      strokeWidth: 1.0,
                    )
                        : Text(
                      "Generate OTP",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        color: AppColors.meruWhite,
                        fontSize: 12.0,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    onPressed: _isButtonEnabled
                        ? () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() => _showLoading = true);
                        await Future.delayed(const Duration(seconds: 2));
                        setState(() => _showLoading = false);

                        Map<String, dynamic> data = {
                          "id": _employeeIdController.text.toString(),
                        };
                        logInProvider.generateOtp(data, context);


                      }
                    }
                        : null, // Disable button if not enabled
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }*/
}


/*
import 'dart:convert';

import 'package:amp/utils/app_colors.dart';
import 'package:amp/utils/constant_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers_vm/generateOtp_provider.dart';
import '../utils/shared_preference_helper.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({required Key key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();

}
class _OtpScreenState extends State<OtpScreen> {
  List<String> otpValues = ["", "", "", "", "", ""];
  final List<TextEditingController> _controllers = List.generate(
    6,
        (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6,
        (_) => FocusNode(),
  );

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SharedPreferenceHelper sharedPrefs = SharedPreferenceHelper();
    final logInProvider = Provider.of<APIProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.meruYellow,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: AppColors.meruRed,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                width: 180,
                height: 200,
                decoration: const BoxDecoration(
                  color: AppColors.meruYellow,
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/images/menu_logo.png'),
              ),
              const SizedBox(height: 24),
              const Text(
                'Validation',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(6, (index) {
                        return _textFieldOTP(
                          first: index == 0,
                          last: index == 5,
                          index: index,
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                        );
                      }),
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: 300.0,
                      height: 50.0,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.meruRed,
                          foregroundColor: AppColors.meruWhite,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                          minimumSize: Size(MediaQuery.of(context).size.width * 0.2, 50.0),
                        ),
                        label: logInProvider.loading
                            ? const CircularProgressIndicator(
                          color: AppColors.meruYellow,
                          strokeWidth: 1.0,
                        )
                            : const Text(
                          "Submit",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            color: AppColors.meruWhite,
                            fontSize: 12.0,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        onPressed: () async {
                          String? userIdLoggedIn = await sharedPrefs.getString(ConstantStrings.userIdLoggedIn);
                          String otp = otpValues.join();
                          Map<String, dynamic> data = {
                            "id": userIdLoggedIn,
                            "otp": otp,
                          };
                          String jsonData = jsonEncode(data);
                          logInProvider.validateUserOtp(jsonData, context);
                        },
                      ),
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

  Widget _textFieldOTP({
    required bool first,
    required bool last,
    required int index,
    required TextEditingController controller,
    required FocusNode focusNode,
  }) {
    return SizedBox(
      height: 55,
      child: AspectRatio(
        aspectRatio: 0.8,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            onChanged: (value) {
              if (value.length == 1 && !last) {
                FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
              }
              if (value.isEmpty && !first) {
                FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
              }
              // Store the value in the otpValues list
              otpValues[index] = value;
            },
            showCursor: false,
            readOnly: false,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              counter: const Offstage(),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: AppColors.meruRed),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

*/


import 'dart:convert';

import 'package:amp/utils/app_colors.dart';
import 'package:amp/utils/constant_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers_vm/generateOtp_provider.dart';
import '../utils/shared_preference_helper.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({required Key key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();

}
class _OtpScreenState extends State<OtpScreen> {
  List<String> otpValues = ["", "", "", "", "", ""];
  final List<TextEditingController> _controllers = List.generate(
    6,
        (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6,
        (_) => FocusNode(),
  );

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SharedPreferenceHelper sharedPrefs = SharedPreferenceHelper();
    final logInProvider = Provider.of<APIProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.meruYellow,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: AppColors.meruRed,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                width: 180,
                height: 200,
                decoration: const BoxDecoration(
                  color: AppColors.meruYellow,
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/images/menu_logo.png'),
              ),
              const SizedBox(height: 24),
              const Text(
                'Validation',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(6, (index) {
                        return _textFieldOTP(
                          first: index == 0,
                          last: index == 5,
                          index: index,
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                        );
                      }),
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: 300.0,
                      height: 50.0,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.meruRed,
                          foregroundColor: AppColors.meruWhite,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                          minimumSize: Size(MediaQuery.of(context).size.width * 0.2, 50.0),
                        ),
                        label: logInProvider.loading
                            ? const CircularProgressIndicator(
                          color: AppColors.meruYellow,
                          strokeWidth: 1.0,
                        )
                            : const Text(
                          "Submit",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            color: AppColors.meruWhite,
                            fontSize: 12.0,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        onPressed: () async {
                          String? userIdLoggedIn = await sharedPrefs.getString(ConstantStrings.userIdLoggedIn);
                          String otp = otpValues.join();
                          Map<String, dynamic> data = {
                            "id": userIdLoggedIn,
                            "otp": otp,
                          };
                          String jsonData = jsonEncode(data);
                          logInProvider.validateUserOtp(jsonData, context);
                        },
                      ),
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

  Widget _textFieldOTP({
    required bool first,
    required bool last,
    required int index,
    required TextEditingController controller,
    required FocusNode focusNode,
  }) {
    return SizedBox(
      height: 55,
      child: AspectRatio(
        aspectRatio: 0.8,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            onChanged: (value) {
              if (value.length == 1 && !last) {
                FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
              }
              if (value.isEmpty && !first) {
                FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
              }
              // Store the value in the otpValues list
              otpValues[index] = value;
            },
            showCursor: false,
            readOnly: false,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              counter: const Offstage(),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: AppColors.meruRed),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


/*class _OtpScreenState extends State<OtpScreen> {
  List<String> otpValues = ["", "", "", "", "", ""];

  @override
  Widget build(BuildContext context) {
    final SharedPreferenceHelper sharedPrefs = SharedPreferenceHelper();
    final logInProvider = Provider.of<APIProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.meruYellow,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: AppColors.meruRed,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                width: 180,
                height: 200,
                decoration: const BoxDecoration(
                  color: AppColors.meruYellow,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/menu_logo.png',
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Validation',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _textFieldOTP(first: true, last: false, index: 0),
                        _textFieldOTP(first: false, last: false, index: 1),
                        _textFieldOTP(first: false, last: false, index: 2),
                        _textFieldOTP(first: false, last: false, index: 3),
                        _textFieldOTP(first: false, last: false, index: 4),
                        _textFieldOTP(first: false, last: true, index: 5),
                      ],
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: 300.0,
                      height: 50.0,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.meruRed,
                          foregroundColor: AppColors.meruWhite,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.2,
                            50.0,
                          ),
                        ),
                        label: logInProvider.loading
                            ? const CircularProgressIndicator(
                                color: AppColors.meruYellow,
                                strokeWidth: 1.0,
                              )
                            : const Text(
                                "Submit",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.meruWhite,
                                  fontSize: 12.0,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                        onPressed: () async {
                          String? userIdLoggedIn = await sharedPrefs
                              .getString(ConstantStrings.userIdLoggedIn);

                          String otp = otpValues.join();
                          Map<String, dynamic> data = {
                            "id": userIdLoggedIn,
                            "otp": otp,
                          };

                          String jsonData = jsonEncode(data);
                          logInProvider.validateUserOtp(jsonData, context);
                        },
                      ),
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

  Widget _textFieldOTP({
    required bool first,
    required bool last,
    required int index,
  }) {
    return SizedBox(
      height: 55,
      child: AspectRatio(
        aspectRatio: 0.8,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextField(
            // Removed autofocus: true
            onChanged: (value) {
              if (value.length == 1 && !last) {
                FocusScope.of(context).nextFocus();
              }
              if (value.isEmpty && !first) {
                FocusScope.of(context).previousFocus();
              }
              // Store the value in the otpValues list
              otpValues[index] = value;
            },
            showCursor: false,
            readOnly: false,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              counter: const Offstage(),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.black12),
                  borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: AppColors.meruRed),
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ),
    );
  }

}*/


import 'package:amp/views/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../../utils/app_colors.dart';

class OtpTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;

  const OtpTextField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.0,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16.0),
        decoration: const InputDecoration(
          counterText: '', // Hide the counter for number of characters
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class OtpValidationScreen extends StatefulWidget {
  const OtpValidationScreen({super.key});

  @override
  State<OtpValidationScreen> createState() => _OtpValidationScreenState();
}

class _OtpValidationScreenState extends State<OtpValidationScreen> {
  bool _showLoading = false;
  final _otpController1 = TextEditingController();
  final _otpController2 = TextEditingController();
  final _otpController3 = TextEditingController();
  final _otpController4 = TextEditingController();
  final _otpController5 = TextEditingController();
  final _otpController6 = TextEditingController();

  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final _focusNode3 = FocusNode();
  final _focusNode4 = FocusNode();
  final _focusNode5 = FocusNode();
  final _focusNode6 = FocusNode();

  int _timer = 30;
  late Timer _countdownTimer;
  bool _isResendButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _timer = 30;
      _isResendButtonEnabled = false;
    });

    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timer > 1) {
        setState(() {
          _timer--;
        });
      } else {
        _countdownTimer.cancel();
        setState(() {
          _isResendButtonEnabled = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _otpController1.dispose();
    _otpController2.dispose();
    _otpController3.dispose();
    _otpController4.dispose();
    _otpController5.dispose();
    _otpController6.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _focusNode5.dispose();
    _focusNode6.dispose();
    _countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: const Center(
            child: Text('Audit Management Platform',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: AppColors.meruWhite,
                  fontSize: 14.0,
                  fontStyle: FontStyle.normal,
                ))),
        backgroundColor: AppColors.meruRed,
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_sharp, color: Colors.white),
          // Blue icon
          onPressed: () => Navigator.pop(context), // Handle back button press
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'OTP Validation',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: AppColors.meruBlack,
                fontSize: 32.0,
                fontStyle: FontStyle.normal,
              ),
            ),
            const SizedBox(height: 40.0),
            Center(
              child: Column(
                children: [
                  const Text(
                    'Please enter the OTP sent to your mobile number',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: AppColors.meruRed,
                      fontSize: 14.0,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    width: 450,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OtpTextField(
                          controller: _otpController1,
                          focusNode: _focusNode1,
                          onChanged: (value) {
                            if (value.length == 1 && value != '') {
                              _focusNode2.requestFocus();
                            } else if (value.isEmpty) {
                              _focusNode1.requestFocus();
                            }
                          },
                        ),
                        OtpTextField(
                          controller: _otpController2,
                          focusNode: _focusNode2,
                          onChanged: (value) {
                            if (value.length == 1 && value != '') {
                              _focusNode3.requestFocus();
                            } else if (value.isEmpty) {
                              _focusNode1.requestFocus();
                            }
                          },
                        ),
                        OtpTextField(
                          controller: _otpController3,
                          focusNode: _focusNode3,
                          onChanged: (value) {
                            if (value.length == 1 && value != '') {
                              _focusNode4.requestFocus();
                            } else if (value.isEmpty) {
                              _focusNode2.requestFocus();
                            }
                          },
                        ),
                        OtpTextField(
                          controller: _otpController4,
                          focusNode: _focusNode4,
                          onChanged: (value) {
                            if (value.length == 1 && value != '') {
                              _focusNode5.requestFocus();
                            } else if (value.isEmpty) {
                              _focusNode3.requestFocus();
                            }
                          },
                        ),
                        OtpTextField(
                          controller: _otpController5,
                          focusNode: _focusNode5,
                          onChanged: (value) {
                            if (value.length == 1 && value != '') {
                              _focusNode6.requestFocus();
                            } else if (value.isEmpty) {
                              _focusNode4.requestFocus();
                            }
                          },
                        ),
                        OtpTextField(
                          controller: _otpController6,
                          focusNode: _focusNode6,
                          onChanged: (value) {
                            if (value.length == 1) {
                              // Handle potential overflow (optional)
                            } else if (value.isEmpty) {
                              _focusNode5.requestFocus();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_getEnteredOtp() == '123456') {
                        setState(() => _showLoading = true);
                        await Future.delayed(const Duration(seconds: 4));
                        setState(() => _showLoading = false);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DM_DashboardScreen()),
                        );
                      } else {
                        // Show error message for invalid OTP
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid OTP! Please try again.'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.meruRed,
                        foregroundColor: AppColors.meruWhite,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(
                                8.0))), // Adjust corner radius as desired
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.2,
                            50.0) // Adjust width and height
                        ),
                    child: _showLoading
                        ? CircularProgressIndicator(
                            color: AppColors.meruYellow,
                            strokeWidth: 1.0,
                          )
                        : Text(
                            "Submit",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              color: AppColors.meruWhite,
                              fontSize: 12.0,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                  ),
                  const SizedBox(height: 20.0),
                  if (_timer > 0)
                    Text(
                      'Resend code in $_timer seconds',
                      style:
                          const TextStyle(fontSize: 12.0, color: Colors.black),
                    ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _isResendButtonEnabled ? _startTimer : null,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: _isResendButtonEnabled
                            ? AppColors.meruRed
                            : Colors.grey,
                        foregroundColor: AppColors.meruWhite,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(
                                8.0))), // Adjust corner radius as desired
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.2,
                            50.0) // Adjust width and height
                        ),
                    child: Text(
                      "Resend Code",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        color: AppColors.meruWhite,
                        fontSize: 12.0,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 100,
                  ),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: Image.asset("assets/images/menu_logo.png"),
                  ),
                  Text(
                    "Mount Meru Group",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: AppColors.meruRed,
                      fontSize: 12.0,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  Text(
                    'Delivering Excellence since 40 years...',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: AppColors.meruRed,
                      fontSize: 12.0,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getEnteredOtp() {
    return '${_otpController1.text}${_otpController2.text}${_otpController3.text}${_otpController4.text}${_otpController5.text}${_otpController6.text}';
  }
}

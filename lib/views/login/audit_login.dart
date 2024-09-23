import 'dart:convert';

import 'package:amp/utils/constant_strings.dart';
import 'package:amp/utils/shared_preference_helper.dart';
import 'package:amp/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../providers_vm/generateOtp_provider.dart';
import '../../routes/route_names.dart';
import '../../utils/app_colors.dart';


class AuditLogin extends StatefulWidget {
  const AuditLogin({Key? key}) : super(key: key);

  @override
  _AuditLoginState createState() => _AuditLoginState();
}

class _AuditLoginState extends State<AuditLogin> {
  final _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _employeeIdController = TextEditingController();
  final SharedPreferenceHelper sharedPrefs = SharedPreferenceHelper();
  String? _errorMessage;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final logInProvider = Provider.of<APIProvider>(context);
    _checkAndRequestPermissions();
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
                _buildLogo(),
                const SizedBox(height: 20.0),
                _buildTitle(),
                const SizedBox(height: 20.0),
                _buildEmployeeIdField(),
                const SizedBox(height: 20.0),
                _buildSubmitButton(logInProvider),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 100,
        width: 150,
        child: Image.asset("assets/images/menu_logo.png"),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          AppStrings.login,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: AppColors.meruBlack,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 8),
          child: Text(
            AppStrings.loginPage,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: AppColors.merubg,
              fontSize: 12.0,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }

  Widget _buildEmployeeIdField() {
    return SizedBox(
      width: 280.0,
      height: 70.0,
      child: TextFormField(
        focusNode: _focusNode,
        controller: _employeeIdController,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          color: AppColors.meruRed,
          fontSize: 12.0,
        ),
        decoration: InputDecoration(
          labelText: '',
          prefixIcon: Icon(
            Icons.person,
            color: AppColors.meruRed,
          ),
          enabledBorder: _buildInputBorder(),
          focusedBorder: _buildInputBorder(),
          errorBorder: _buildInputBorder(),
          focusedErrorBorder: _buildInputBorder(),
          disabledBorder: _buildInputBorder(),
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
          errorText: _errorMessage,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppStrings.emptyUserId;
          }
          return null;
        },
        onChanged: (value) {
          if (_errorMessage != null && value.isNotEmpty) {
            setState(() {
              _errorMessage = null;
            });
          }
        },
        onFieldSubmitted: (value) {
          if (value.isEmpty) {
            setState(() {
              _errorMessage = AppStrings.emptyUserId;
            });
          }
        },
      ),
    );
  }

  OutlineInputBorder _buildInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    );
  }

  Widget _buildSubmitButton(APIProvider logInProvider) {
    return Container(
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
                AppStrings.generateOTP,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                  color: AppColors.meruWhite,
                  fontSize: 12.0,
                ),
              ),
        onPressed: () async {
          _focusNode.unfocus();
          if (_formKey.currentState!.validate()) {
            final logInProvider =
                Provider.of<APIProvider>(context, listen: false);

            Map<String, dynamic> data = {
              "id": _employeeIdController.text,
            };

            String jsonData = jsonEncode(data);
            print(jsonData);

            await _handleApiCall(logInProvider);
          }
        },
      ),
    );
  }

  Future<void> _handleApiCall(APIProvider logInProvider) async {
    try {
      await logInProvider.prevalidateUser(
          jsonEncode({"id": _employeeIdController.text}), context);

      if (logInProvider.userId == _employeeIdController.text) {
        await logInProvider.generateOtp(jsonEncode({"id": _employeeIdController.text}), context);
        sharedPrefs.saveString(ConstantStrings.userIdLoggedIn,logInProvider.userId);
        Navigator.pushNamed(context, Routenames.otpScreen);
      }
    } catch (error) {
      print('Error during API call: $error');
    }
  }


  Future<void> _checkAndRequestPermissions() async {
    // Check for specific permissions based on Android versions
    if (await Permission.mediaLibrary.request().isDenied) {
      var status = await [
        Permission.camera,
        Permission.location,
        Permission.storage,
        Permission.manageExternalStorage,
        Permission.mediaLibrary,
      ].request();

      if (status[Permission.camera]!.isDenied ||
          status[Permission.location]!.isDenied ||
          status[Permission.storage]!.isDenied ||
          status[Permission.manageExternalStorage]!.isDenied ||
          status[Permission.mediaLibrary]!.isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Permissions are required to proceed.')),
        );
      }
    }
  }


/*  Future<void> _checkAndRequestPermissions() async {
    var status = await [
      Permission.camera,
      Permission.location,
      Permission.storage,
    ].request();

    if (status[Permission.camera]!.isDenied ||
        status[Permission.location]!.isDenied ||
        status[Permission.storage]!.isDenied) {
      // Handle the case when permissions are denied
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permissions are required to proceed.')),
      );
    }
  }*/
}

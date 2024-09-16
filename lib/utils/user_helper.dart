import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../response/validateUserOtp.dart';

class UserDetailsHelper {
  static const String userDetailsKey = 'userDetails';

  static Future<UserResponse?> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDetailsJson = prefs.getString(userDetailsKey);

    if (userDetailsJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userDetailsJson);
      return UserResponse.fromJson(userMap);
    }
    return null;
  }

  // Method to get initials from UserResponse
  static String getInitials(UserResponse user) {
    String firstNameInitial = user.firstName.isNotEmpty ? user.firstName[0] : '';
    String lastNameInitial = user.lastName.isNotEmpty ? user.lastName[0] : '';
    return '$firstNameInitial$lastNameInitial'.toUpperCase();
  }
}


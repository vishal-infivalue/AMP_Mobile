import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppColors {
  //theme for Mount Meru
  static const Color meruYellow = Color(0xFFFFF600);
  static const Color merubtnOrange = Color(0xFFFFAE42);
  static const Color meruRed = Color(0xFFBA2F2F);
  static const Color meruBlack = Color(0xFF0B0A0A);
  static const Color meruWhite = Color(0xFFFFFFFF);
  static const Color merubg = Color(0xFF9D9C9C);
  static const Color merudashBg = Color(0xFFE4DDDD);


  // static Color merudashBg = HexColor("#9D9C9C");

  // Material Design colors
  static const Color kPrimaryColor = Colors.blue;
  static const Color kAccentColor = Colors.deepOrange;
  static const Color kPrimaryLightColor = Colors.lightBlue;
  static const Color kPrimaryDarkColor = Colors.indigo;
  static const Color kSecondaryColor = Colors.green;
  static const Color kSecondaryLightColor = Colors.lightGreen;
  static const Color kSecondaryDarkColor = Colors.greenAccent;
  static const Color kErrorColor = Colors.red;
  static const Color kBackgroundColor = Colors.white;
  static const Color kSurfaceColor = Colors.grey;
  static const Color kAppBarColor = Colors.blue;

  // Custom colors
  static const Color kBackgroundGradientStart = Color(0xFFE53935);
  static const Color kBackgroundGradientEnd = Color(0xFFFF5252);
  static const Color kButtonColor = Color(0xFF4CAF50);
  static const Color kButtonTextColor = Colors.white;
  static const Color kTextColor = Colors.black87;
  static const Color kHintTextColor = Colors.grey;
  static const Color kIconColor = Colors.grey;
  static const Color kDividerColor = Colors.grey;
  static const Color kCardColor = Colors.white;
  static const Color kCardTextColor = Colors.black;
  static const Color kDisabledColor = Colors.grey;
  static const Color kSuccessColor = Colors.green;
  static const Color kWarningColor = Colors.amber;
  static const Color kInfoColor = Colors.blue;
  static const Color kDarkTextColor = Colors.black87;
  static const Color kLightTextColor = Colors.white;
  static const Color kTransparentColor = Colors.transparent;

  // Gradients
  static const LinearGradient kGradientBlue = LinearGradient(
    colors: [Color(0xFF394497), Color(0xFF444FAB), Color(0xFF5E6BD8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient kGradientGreen = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

// Add more colors and gradients as needed
}

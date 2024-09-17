import 'package:amp/routes/route_names.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      // Navigator.pushNamed(context, Routenames.loginScreen);
      Navigator.pushNamed(context, Routenames.dmDashboardScreen);
      // Navigator.pushNamed(context, Routenames.smDashboardScreen);
      // Navigator.pushNamed(context, Routenames.cmDashboardScreen);
      // Navigator.pushNamed(context, Routenames.);
      // Navigator.pushNamed(context, Routenames.ERBScreen_Tech);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Image.asset("assets/images/menu_logo.png"),
        ),
      ),
    );
  }
}

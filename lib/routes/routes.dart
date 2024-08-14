import 'package:amp/routes/route_names.dart';
import 'package:amp/views/bottomPerformingTables.dart';
import 'package:amp/views/forms/technical_checklist.dart';
import 'package:amp/views/login/audit_login.dart';
import 'package:amp/views/login/otp_validation_screen.dart';
import 'package:amp/views/notification_screen.dart';
import 'package:amp/views/otp_screen.dart';
import 'package:amp/views/register_screen.dart';
import 'package:amp/views/signature_pad/signature_witness.dart';
import 'package:amp/views/tables/averageTables.dart';
import 'package:amp/views/tables/completedTables.dart';
import 'package:amp/views/tables/nCTables.dart';
import 'package:amp/views/tables/pending_table.dart';
import 'package:amp/views/tables/topPerformingTables.dart';
import 'package:flutter/material.dart';

import '../views/cm_dashboard_screen.dart';
import '../views/dashboard_screen.dart';
import '../views/evaluation_preview.dart';
import '../views/evaluation_score_summary.dart';
import '../views/forms/erb_technical_checklist.dart';
import '../views/forms/technical_checklist_tech.dart';
import '../views/forms/technical_test.dart';
import '../views/profile/profile.dart';
import '../views/signature_pad/signature_pad.dart';
import '../views/splash_screen.dart';
import '../views/welcome_screen.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routenames.splashScreen:
        return MaterialPageRoute(
            builder: (globalContext) => const SplashScreen());

      case Routenames.loginScreen:
        return MaterialPageRoute(
            builder: (globalContext) =>  AuditLogin(args: {},));
        
        case Routenames.otpScreen:
        /*return MaterialPageRoute(
            builder: (globalContext) =>  OtpValidationScreen(key: Key("")));*/

        return MaterialPageRoute(
            builder: (globalContext) =>  OtpScreen(key: Key("")));

        case Routenames.cmDashboardScreen:
        return MaterialPageRoute(
            builder: (globalContext) =>  DM_DashboardScreen());

        case Routenames.dmDashboardScreen:
        return MaterialPageRoute(
            builder: (globalContext) =>  DM_DashboardScreen());

        case Routenames.profileScreen:
        return MaterialPageRoute(
            builder: (globalContext) =>  ProfileScreen());

      case Routenames.ERBScreen:
        return MaterialPageRoute(
            builder: (globalContext) => ERB_Audit_Tech());

        case Routenames.ERBScreen_Tech:
        return MaterialPageRoute(
            builder: (globalContext) => TechnicalTest());

        /*return MaterialPageRoute(
            builder: (globalContext) => TechnicalTest());*/

        case Routenames.evaluationScorePage:
        return MaterialPageRoute(
            builder: (globalContext) => EvaluationScorePage(address: '',contacts: '',grading: '',ocr: '',
            omc: '',site: ''));

      case Routenames.evaluationPreview:
        return MaterialPageRoute(
            builder: (globalContext) => EvaluationPreview(address: '',contacts: '',grading: '',ocr: '',
                omc: '',site: ''));

      case Routenames.registerScreen:
        return MaterialPageRoute(
            builder: (globalContext) =>  RegisterScreen(key: Key("value")));

      case Routenames.welcomeScreen:
        return MaterialPageRoute(
            builder: (globalContext) => const WelcomeScreen(key: Key("value"),));

      case Routenames.averageScoreTable:
        return MaterialPageRoute(
            builder: (globalContext) =>  AverageScoreTable());

        case Routenames.bottomPerformingTable:
        return MaterialPageRoute(
            builder: (globalContext) =>  BottomPerformingTable());

        case Routenames.nonComplianceTable:
        return MaterialPageRoute(
            builder: (globalContext) =>  NonComplianceTable());

      case Routenames.topPerformingTable:
        return MaterialPageRoute(
            builder: (globalContext) =>  TopPerformingTable());

      case Routenames.pendingTable:
        return MaterialPageRoute(
            builder: (globalContext) =>  PendingTable());

        case Routenames.completedTable:
        return MaterialPageRoute(
            builder: (globalContext) =>  CompletedTable());

        case Routenames.witnessSignature:
        return MaterialPageRoute(
            builder: (globalContext) =>  WitnessSignature());

        case Routenames.signaturePadScreen:
        return MaterialPageRoute(
            builder: (globalContext) =>  SignaturePadScreen());

        case Routenames.notificationScreen:
        /*return MaterialPageRoute(
            builder: (globalContext) =>  NotificationScreen(notifications: [],));*/

      default:
        return MaterialPageRoute(builder: (globalContext) {
          return const Scaffold(
            body: Center(
              child: Text("Something went wrong."),
            ),
          );
        });
    }
  }
}

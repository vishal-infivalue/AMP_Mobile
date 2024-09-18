import 'package:amp/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class CommonFunctions {
  static String roundDoubleToString(double value) {
    int roundedValue = value.round();
    return roundedValue.toString();
  }


  static Future<void> showConfirmationDialog({
    required BuildContext context,
    required String message,
    required VoidCallback onOkayPressed,
    required VoidCallback onCancelPressed,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onCancelPressed(); // Call the Cancel callback
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onOkayPressed(); // Call the Okay callback
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showMessageDialog({
    required BuildContext context,
    required String message,
    required VoidCallback onYesPressed,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onYesPressed(); // Call the Okay callback
              },
              child: const Text('Okay'),
            ),
          ],
        );
      },
    );
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
    );
  }

  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: TweenAnimationBuilder<Color?>(
            tween: ColorTween(begin: Colors.red, end: Colors.yellow),
            duration: Duration(seconds: 1),
            builder: (context, color, _) {
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(color!),
              );
            },
            onEnd: () {
              // No need to do anything here
            },
          ),
        );
      },
    );
/*    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );*/
  }

  // Dismiss loading dialog
  static void dismissLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  // Show success or error dialog
  static void showAlertDialog(
      BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}


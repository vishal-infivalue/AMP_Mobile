import 'package:flutter/material.dart';
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
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogWithForm extends StatefulWidget {
  @override
  _DialogWithFormState createState() => _DialogWithFormState();
}

class _DialogWithFormState extends State<DialogWithForm> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Review",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _textController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Write your Review';
                }
                return null;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Submit",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // Do something with the input
                  print('Input: ${_textController.text}');
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialog with TextFormField'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Open Dialog'),
          onPressed: _showDialog,
        ),
      ),
    );
  }
}
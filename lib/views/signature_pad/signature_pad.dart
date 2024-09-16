import 'package:amp/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../../utils/app_colors.dart';


class SignaturePadScreen extends StatefulWidget {
  const SignaturePadScreen({super.key});

  @override
  _SignaturePadScreenState createState() => _SignaturePadScreenState();
}

class _SignaturePadScreenState extends State<SignaturePadScreen> {
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  bool _showLoading = false;

  void _submitForm() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false, // Prevent back button press
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Audit Submission",style: TextStyle(
                fontFamily: 'Montserrat',
                color: AppColors.meruBlack,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
              ),),
              SizedBox(height: 16.0),
              Text("ERB_CC_00-07-2024.pdf will be submitted to the station. Please Sign and Submit the physical copy.",style: TextStyle(
                fontFamily: 'Montserrat',
                color: AppColors.meruBlack,
                fontSize: 12.0,
                fontStyle: FontStyle.normal,
              ),),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton.icon(
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
                    icon: const Icon(Icons.arrow_circle_right),
                    label: _showLoading
                        ? CircularProgressIndicator(
                      color: AppColors.meruYellow,
                      strokeWidth: 1.0,
                    )
                        : Text(
                      "SUBMIT TO STATION",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: AppColors.meruWhite,
                        fontSize: 12.0,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        _showLoading = true;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Form uploading')),
                      );
                      Navigator.pushNamed(context, Routenames.dmDashboardScreen);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('ERB-CC on date 14-07-2024 has been generated and sent to your email. Please sign the printed copy.')),
                      );

                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*void _submitForm() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Form Submission'),
        content: Text('The form will be submitted.'),
        actions: <Widget>[

          ElevatedButton(
            onPressed: () async {
              Navigator.pushNamed(context, RouteName.dashboard);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.meruRed,
                foregroundColor: AppColors.AppColors.meruWhite,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(
                        8.0))), // Adjust corner radius as desired
                minimumSize: Size(
                    MediaQuery.of(context).size.width * 0.4,
                    50.0) // Adjust width and height
            ),
            child: _showLoading
                ? CircularProgressIndicator(color: AppColors.meruYellow)
                : const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() => _showLoading = true);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Form uploading')),
              );
              // Navigator.of(context).pop();
              await Future.delayed(const Duration(seconds: 4));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Form Submitted')),
              );
              setState(() => _showLoading = false);


              Navigator.pushNamed(context, RouteName.dashboard);

            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.meruRed,
                foregroundColor: AppColors.AppColors.meruWhite,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(
                        8.0))), // Adjust corner radius as desired
                minimumSize: Size(
                    MediaQuery.of(context).size.width * 0.4,
                    50.0) // Adjust width and height
            ),
            child: _showLoading
                ? CircularProgressIndicator(color: AppColors.meruYellow)
                : const Text("Submit"),
          ),
        ],
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Signature',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: AppColors.meruWhite,
            fontSize: 14.0,
            fontStyle: FontStyle.normal,
          ),
        ),
        backgroundColor: AppColors.meruRed,
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_sharp, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            Text("Sign of CM/RH",style: TextStyle(
              fontFamily: 'Montserrat',
              color: AppColors.meruBlack,
              fontSize: 14.0,
              fontStyle: FontStyle.normal,
            ),),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SfSignaturePad(
                  key: _signaturePadKey,
                  backgroundColor: Colors.grey[200]!,
                ),
              ),
            ),
            /*ElevatedButton.icon(
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
              icon: const Icon(Icons.send),
              label: _showLoading
                  ? CircularProgressIndicator(
                color: AppColors.meruYellow,
                strokeWidth: 1.0,
              )
                  : Text(
                "Submit Form",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                  color: AppColors.meruWhite,
                  fontSize: 12.0,
                  fontStyle: FontStyle.normal,
                ),
              ),
              onPressed: () async {
                setState(() {
                  _showLoading= true;
                });
                await Future.delayed(const Duration(seconds: 2));
                _submitForm();
                setState(() {
                  _showLoading = false;
                });
              },
            ),*/
          ],
        ),
      ),
    );
  }
}

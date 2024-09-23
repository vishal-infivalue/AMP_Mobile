import 'dart:convert';
import 'dart:io';

import 'package:amp/utils/constant_strings.dart';
import 'package:amp/utils/global_values.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers_vm/generateOtp_provider.dart';
import '../utils/app_colors.dart';

class NCDetailPage extends StatefulWidget {
  final String position;

  const NCDetailPage({
    super.key,
    required this.position,
  });

  @override
  _NCDetailPageState createState() => _NCDetailPageState();
}



class _NCDetailPageState extends State<NCDetailPage> {
  int index = 0;
  int auditId = 0;


  final _employeeIdController = TextEditingController();

  Future<Map<String, dynamic>?> loadData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? auditId = prefs.getInt(ConstantStrings.selectedNCAuditId);
      final logInProvider = Provider.of<APIProvider>(context, listen: false);
      GlobalVariables gb = GlobalVariables();
      Map<String, dynamic> data = {
        "id": gb.ncAudit,
        "comment": _employeeIdController.text.toString(),
      };

      String jsonData = jsonEncode(data);
      print(jsonData);

      logInProvider.postNCUpdate(jsonData, context);
    }catch(e){
      print("ERROR");
    }

  }

  Future<Map<String, dynamic>?> loadIndex() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      index = prefs.getInt(ConstantStrings.selectedNCIndex)!;
      auditId = prefs.getInt(ConstantStrings.selectedNCAuditId)!;
      print("INDEX VALUE IS $index");
      print("INDEX VALUE IS $auditId");
    }catch(e){
      print("SOME ERROR");
    }
  }

  @override
  void dispose() {
    _employeeIdController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    GlobalVariables gb = GlobalVariables();

    // loadIndex();
    return Scaffold(
      appBar: AppBar(
        title: const Text('NC Details',
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: AppColors.meruRed,
              fontSize: 14.0,
              fontStyle: FontStyle.normal,
            )),
        backgroundColor: AppColors.meruWhite,
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_sharp, color: AppColors.meruRed),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: AppColors.meruWhite,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.meruRed,
                ),
                child: Text(
                  'Navigation',
                  style: TextStyle(
                    color: AppColors.meruWhite,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  // Add navigation logic here
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  // Add navigation logic here
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                  // Add logout logic here
                },
              ),
            ],
          ),
        ),
        width: MediaQuery.of(context).size.width * 0.5, // Half page width
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.meruWhite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First column
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Station Name',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.0,
                                  color: AppColors.merubg,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                gb.ncAuditTable_gb[gb.index].station!.stationname!+""+gb.ncAudit.toString(),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Station Code',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.0,
                                  color: AppColors.merubg,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                gb.ncAuditTable_gb[gb.index].station!.stationcode!,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SM Name',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.0,
                                  color: AppColors.merubg,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                gb.ncAuditTable_gb[gb.index].stationManager!.firstname!+" "+gb.ncAuditTable_gb[0]!.stationManager!.lastname!,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First column
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CM Name',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.0,
                                  color: AppColors.merubg,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                gb.ncAuditTable_gb[gb.index].clusterManager!.firstname!+" "+gb.ncAuditTable_gb[0]!.clusterManager!.lastname!,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Auditor Name',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.0,
                                  color: AppColors.merubg,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                gb.ncAuditTable_gb[gb.index].auditor!.firstname!+" "+gb.ncAuditTable_gb[0]!.auditor!.lastname!,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Audit type',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.0,
                                  color: AppColors.merubg,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                "ERB Technical",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First column
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Audit Id',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.0,
                                  color: AppColors.merubg,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                gb.ncAuditTable_gb[gb.index].audit!.id!.toString(),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Auditor Date',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.0,
                                  color: AppColors.merubg,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                gb.ncAuditTable_gb[gb.index].audit!.scheduledDate.toString(),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'NC Age',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.0,
                                  color: AppColors.merubg,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                "20",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First column
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'NC Type',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.0,
                                  color: AppColors.merubg,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                gb.ncAuditTable_gb[gb.index].audit!.type!,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Zoho ticket Number',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.0,
                                  color: AppColors.merubg,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                "221101",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'zoho ticket status',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.0,
                                  color: AppColors.merubg,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                "-",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                ],
              ),
            ),
            SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'NC Assigned to : ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.merubg,
                      fontSize: 11.0,
                    ),
                  ),
                  Text(
                    gb.ncAuditTable_gb[gb.index].auditor!.lastname!,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.meruBlack,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Audit Question : ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.merubg,
                      fontSize: 11.0,
                    ),
                  ),
                  Text(
                    'Fuel Dispenser',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.meruBlack,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Audit Remark : ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.merubg,
                      fontSize: 11.0,
                    ),
                  ),
                  Text(
                    "From app",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.meruBlack,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Upload Picture : ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.merubg,
                      fontSize: 11.0,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: AppColors.meruWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      minimumSize: Size(25.0, 25.0),
                    ),
                    child: Image.asset(
                        "assets/images/fg_upload.png"),
                    onPressed: () async {
                      _openCamera();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.merubg,
                      fontSize: 11.0,
                    ),
                  ),
                  SizedBox(
                    width: 280.0,
                    height: 50.0,
                    child: TextFormField(
                      controller: _employeeIdController,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: AppColors.meruBlack,
                        fontSize: 11.0,
                        fontStyle: FontStyle.normal,
                      ),
                      decoration: InputDecoration(
                        labelText: 'NC Comment',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                          color: AppColors.merudashBg,
                          fontSize: 12.0,
                          fontStyle: FontStyle.normal,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.merubg),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.merubg),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Add some comment';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),



            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: AppColors.meruWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        minimumSize: Size(20, 40.0),
                      ),
                      label: Text(
                        "Update",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                          color: AppColors.meruWhite,
                          fontSize: 8.0,
                        ),
                      ),
                      onPressed: () {

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Center(
                              child: TweenAnimationBuilder<Color?>(
                                tween:
                                ColorTween(begin: Colors.red, end: Colors.yellow),
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

                        Future.delayed(Duration(seconds: 4), () {
                          Navigator.of(context).pop();

                          // Call your API or perform any action
                         // Close the CircularProgressIndicator dialog
                        });

                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: AppColors.meruWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        minimumSize: Size(20, 40.0),
                      ),
                      label: Text(
                        "Close NC",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                          color: AppColors.meruWhite,
                          fontSize: 8.0,
                        ),
                      ),
                      onPressed: () {
                        loadData();
                      },
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
}

File? _image;
final ImagePicker _picker = ImagePicker();

Future<void> _openCamera() async {
  final pickedFile = await _picker.pickImage(source: ImageSource.camera);

  if (pickedFile != null) {
    _image = File(pickedFile.path);
  } else {
    print('No image selected.');
  }
}

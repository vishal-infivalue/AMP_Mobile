import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../providers_vm/generateOtp_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/global_values.dart';

class SubmittedTable extends StatefulWidget {
  @override
  _SubmittedTableState createState() => _SubmittedTableState();
}

class _SubmittedTableState extends State<SubmittedTable> {
  FilePickerResult? result;
  File? _selectedFile;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    GlobalVariables gb = GlobalVariables();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Submitted Audits',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: AppColors.meruRed,
            fontSize: 14.0,
            fontStyle: FontStyle.normal,
          ),
        ),
        backgroundColor: AppColors.meruWhite,
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_sharp,
              color: AppColors.meruRed),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                elevation: 4,
                color: AppColors.meruWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'List of audits pending final \nsignature and submission',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          gb.numberOfAuditsSubmitted_gb,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Table(
                  border: TableBorder.all(color: Colors.black),
                  columnWidths: const {
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                    3: FlexColumnWidth(),
                    4: FlexColumnWidth(),
                  },
                  children: [
                    const TableRow(
                      decoration: BoxDecoration(
                        color: AppColors.meruRed,
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Audit Number',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.meruWhite,
                              fontSize: 12.0,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Audit Type',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.meruWhite,
                              fontSize: 12.0,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Audit Date',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.meruWhite,
                              fontSize: 12.0,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Status',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.meruWhite,
                              fontSize: 12.0,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Upload Pdf',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.meruWhite,
                              fontSize: 12.0,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ...gb.submittedAuditTable_gb.map((audit) {
                      String auditId = audit.id.toString();
                      return TableRow(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                auditId,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: AppColors.meruBlack,
                                  fontSize: 10.0,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                audit.type,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: AppColors.meruBlack,
                                  fontSize: 10.0,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                audit.scheduledDate,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: AppColors.meruBlack,
                                  fontSize: 10.0,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                audit.state,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: AppColors.meruBlack,
                                  fontSize: 10.0,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
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
                                      "assets/images/upload_icon.png"),
                                  onPressed: () async {
                                    result = await FilePicker.platform
                                        .pickFiles(allowMultiple: false);

                                    if (result == null) {
                                      print("No file selected");
                                    } else {
                                      setState(() {});
                                      for (var element in result!.files) {
                                        print(element.name);
                                        _selectedFile = File(element.path!);

                                        // Upload the selected file immediately
                                        await _uploadFile(auditId);
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickFile() async {
    // Check if permissions are granted
    bool permissionGranted = await _checkPermission();

    if (permissionGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'], // Only allow PDF files
      );

      if (result != null) {
        // Get the file
        File file = File(result.files.single.path!);
        String? mimeType = lookupMimeType(file.path);

        // Ensure it's a PDF
        if (mimeType == 'application/pdf') {
          setState(() {
            _selectedFile = file;
          });
        } else {
          // Show error if the file is not a PDF
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please select a PDF file')),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Permission denied. Please allow storage access.')),
      );
    }
  }

  // Method to upload file and complete audit
  Future<void> _uploadFile(String auditId) async {
    if (_selectedFile != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Call the completeAudit method with the selected file
        final logInProvider = Provider.of<APIProvider>(context, listen: false);
        await logInProvider.completeAudit(auditId, _selectedFile!, context);

      } catch (e) {

      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      // Show error if no file is selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a file to upload')),
      );
    }
  }

  // Method to check and request permission
  Future<bool> _checkPermission() async {
    // Check the storage permission status
    var status = await Permission.storage.status;
    // For Android 11 and above, request manageExternalStorage permission
    if (Platform.isAndroid && await Permission.manageExternalStorage.isDenied) {
      status = await Permission.manageExternalStorage.request();
    }

    if (status.isDenied) {
      status = await Permission.storage.request();
    }

    return status.isGranted;
  }
}

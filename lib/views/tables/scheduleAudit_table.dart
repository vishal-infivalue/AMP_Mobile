import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers_vm/generateOtp_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/global_values.dart';
import 'all_auditors_response.dart';

class ScheduleAuditTable extends StatelessWidget {
  const ScheduleAuditTable({super.key});

  @override
  Widget build(BuildContext context) {

    GlobalVariables gb = GlobalVariables();


    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Schedule Audits',
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                  "",
                  style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: AppColors.meruBlack,
                          fontSize: 12.0,
                          letterSpacing: 1,
                          fontStyle: FontStyle.normal,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
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
                        "Number of Stations for which ERB\n Compliance Team Audit hasn't\n been performed for last 45 days ",
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
                          gb.schedulableAuditsCount_gb,
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
                          5: FlexColumnWidth(),
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
                                  'Station Name',
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
                                  'Last Audit Date',
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
                            'Schedule Audit',
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
                    ...?gb.schedulableAuditsList_gb?.map((audit) {
                      return TableRow(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                audit.stationCode!,
                                // audit.stationname,
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
                                audit.type!,
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
                                audit.scheduledDate!.toString(),
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
                                      Container(
                                        width: 50,
                                        height: 30,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          'assets/images/icon_start.png',
                                        ),
                                      ),
                                      InkWell(
                                  onTap: () {
                                    _openFilterDrawer(
                                        context,
                                        audit.stationCode.toString(),
                                        audit.type.toString());
                                  },
                                        child: const Text(
                                    'Create\n',
                                    style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.blue,
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.normal,
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
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
}

_openFilterDrawer(BuildContext context, String stationCode, String auditType) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevents closing the dialog by tapping outside
    builder: (BuildContext context) {
      DateTime? selectedFromDate;
      DateTime? selectedToDate;
      String? selectedAuditorName; // To store selected auditor's name
      int? selectedAuditorId;

      final logInProvider = Provider.of<APIProvider>(context,
          listen: false); // To store selected auditor's ID

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Create Audits',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.meruBlack,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  Text(
                    "Station Code: $stationCode",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.meruBlack,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    "Audit Type: $auditType",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.meruBlack,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Assign Auditor',
                      border: OutlineInputBorder(),
                    ),
                    // Populate the dropdown menu dynamically
                    items: logInProvider.bodyAuditor!
                        .map<DropdownMenuItem<String>>((Auditor auditor) {
                      return DropdownMenuItem<String>(
                        value: auditor.id.toString(), // Use auditor ID as value
                        child: Text(
                          "${auditor.firstname} ${auditor.lastname}",
                          // Display full name
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AppColors.meruBlack,
                            fontSize: 12.0,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        // Find the selected auditor by matching ID
                        var selectedAuditor = logInProvider.bodyAuditor
                            ?.firstWhere(
                                (auditor) => auditor.id.toString() == newValue);
                        selectedAuditorName =
                            "${selectedAuditor?.firstname} ${selectedAuditor?.lastname}";
                        selectedAuditorId = selectedAuditor?.id;

                        // Handle dropdown value change here
                        print(
                            "Selected Auditor: $selectedAuditorName, ID: $selectedAuditorId");
                      });
                    },
                    // Ensure the selected value exists in the list
                    value: selectedAuditorId != null &&
                            logInProvider.bodyAuditor!.any(
                                (auditor) => auditor.id == selectedAuditorId)
                        ? selectedAuditorId.toString()
                        : null,
                  ),

                  const SizedBox(height: 16.0),

                  // From Date Picker
                  /*SizedBox(
                    width: double.infinity,
                    // Ensures the width matches other items
                    child: GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedFromDate ?? DateTime.now(),
                          firstDate: DateTime.now(), // Restrict past dates
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            selectedFromDate = pickedDate;
                            if (selectedToDate != null &&
                                selectedToDate!.isBefore(selectedFromDate!)) {
                              selectedToDate = null; // Reset To Date if invalid
                            }
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          selectedFromDate != null
                              ? 'From: ${selectedFromDate!.toLocal().toString().split(' ')[0]}'
                              : 'From',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: AppColors.meruBlack,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),*/

                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedFromDate ?? DateTime.now(),
                          firstDate: DateTime.now(), // Restrict past dates
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            selectedFromDate = pickedDate;
                            if (selectedToDate != null &&
                                selectedToDate!.isBefore(selectedFromDate!)) {
                              selectedToDate = null; // Reset To Date if invalid
                            }
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          selectedFromDate != null
                              ? 'From: ${selectedFromDate!.toUtc().toIso8601String()}' // Format to "2024-10-29T18:30:00.000+00:00"
                              : 'From',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: AppColors.meruBlack,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                        child: const Text(
                          "Schedule",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AppColors.meruWhite,
                            fontSize: 12.0,
                          ),
                        ),
                        onPressed: () {
                          Map<String, dynamic> data = {
                            "due_Date": "2024-10-29T18:30:00.000+00:00",
                            "type": auditType,
                            "stationcode": stationCode,
                            "auditor": selectedAuditorId.toString()
                          };

                          String jsonData = jsonEncode(data);
                          print(jsonData);
                          logInProvider.createAudit(jsonData, context);
                        },
                      ),
                      const SizedBox(width: 8.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AppColors.meruWhite,
                            fontSize: 12.0,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close dialog
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

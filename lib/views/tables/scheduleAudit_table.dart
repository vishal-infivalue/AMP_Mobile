import 'dart:convert';

import 'package:amp/utils/CommonFunctions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers_vm/generateOtp_provider.dart';
import '../../routes/route_names.dart';
import '../../utils/app_colors.dart';
import '../../utils/constant_strings.dart';
import '../../utils/global_values.dart';



  class ScheduleAuditTable extends StatelessWidget {
  const ScheduleAuditTable({super.key});

  @override
  Widget build(BuildContext context) {

    GlobalVariables gb = GlobalVariables();


    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scheduled Audits',
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
                          gb.upcomingAuditMessage_gb,
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
                              ' List of audits pending final signature and submission',
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
                                gb.numberOfAuditsUpcoming_gb,
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
                                  'Due Date',
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
                                  'Perform Audit',
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
                          ...gb.pendingAuditTable_gb.map((audit) {
                            return TableRow(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      audit.stationname+audit.auditid,
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
                                      audit.audittype,
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
                                      audit.duedate,
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
                                      audit.lastauditdate,
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
                                      "Pending",
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
                                        onTap: () async {

                                         /* String auditId = audit.auditid;
                                          late Future<void> auditLoadData;
                                          Map<String, dynamic> data = {
                                            "id": "$auditId",
                                          };

                                          String jsonData = jsonEncode(data);
                                          print(jsonData);

                                          final logInProvider = Provider.of<APIProvider>(context);
                                          logInProvider.getclusteravgscore(context);
                                          auditLoadData = logInProvider.getAuditScreenData(jsonData, context);*/



                                          gb.auditId_gb = audit.auditid;

                                          switch (audit.audittype) {
                                            case ConstantStrings.ERBTECH:

                                              final apiProvider = Provider.of<APIProvider>(context, listen: false);
                                              GlobalVariables gb = GlobalVariables();
                                              String auditId = gb.auditId_gb;
                                              Map<String, dynamic> data = {
                                                "id": "$auditId",
                                              };
                                              // Map<String, dynamic> data = {"id": "260720240001"};
                                              String jsonData = jsonEncode(data);
                                              await apiProvider.getAuditScreenData(jsonData, context);

                                             print("TESTTESTTEST"+auditId);

                                              // Fluttertoast.showToast(
                                              //   msg: auditId,
                                              //   toastLength: Toast.LENGTH_SHORT,
                                              //   gravity: ToastGravity.BOTTOM,
                                              //   backgroundColor: Colors.black54,
                                              //   textColor: Colors.white,
                                              // );

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

                                              // Simulate a delay of 4 seconds
                                              Future.delayed(Duration(seconds: 1), () {
                                                Navigator.of(context)
                                                    .pop(); // Close the CircularProgressIndicator dialog

                                                if(auditId == "10000000006"){

                                                  CommonFunctions.showMessageDialog
                                                    (context: context,
                                                      message: "You are not in radius specified for this Station. Please launch Audit when you are at Station Location",
                                                      onYesPressed: () {

                                                      });

                                                }else{
                                                  Navigator.pushNamed(
                                                      context, Routenames.ERBScreen_Tech);
                                                }

                                              });


                                              break;


                                            case ConstantStrings.FUEL:
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Under Development")));
                                              break;
                                            case ConstantStrings.HSE:
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Under Development")));
                                              break;
                                            case ConstantStrings.ERBCONA:

                                              final apiProvider = Provider.of<APIProvider>(context, listen: false);
                                              GlobalVariables gb = GlobalVariables();
                                              String auditId = gb.auditId_gb;
                                              Map<String, dynamic> data = {
                                                "id": "$auditId",
                                              };
                                              // Map<String, dynamic> data = {"id": "260720240001"};
                                              String jsonData = jsonEncode(data);
                                              await apiProvider.getAuditScreenData(jsonData, context);

                                              print("TESTTESTTEST"+auditId);

                                              /*Fluttertoast.showToast(
                                                msg: auditId,
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: Colors.black54,
                                                textColor: Colors.white,
                                              );*/

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

                                              // Simulate a delay of 4 seconds
                                              Future.delayed(Duration(seconds: 1), () {
                                                Navigator.of(context)
                                                    .pop(); // Close the CircularProgressIndicator dialog

                                                if(auditId == "10000000005"){

                                                  CommonFunctions.showMessageDialog
                                                    (context: context,
                                                      message: "You are not in radius specified for this Station. Please launch Audit when you are at Station Location",
                                                      onYesPressed: () {

                                                      });

                                                }else{
                                                  Navigator.pushNamed(
                                                      context, Routenames.ERBScreen);
                                                }


                                              });

                                              break;
                                            default:
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Under Development")));
                                          }
                                        },
                                        child: const Text(
                                          'Start\n',
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

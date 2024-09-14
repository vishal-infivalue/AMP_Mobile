import 'dart:convert';

import 'package:amp/providers_vm/generateOtp_provider.dart';
import 'package:amp/utils/global_values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../response/nc_response.dart';
import '../../routes/route_names.dart';
import '../../utils/CommonFunctions.dart';
import '../../utils/app_colors.dart';

class NonComplianceTable extends StatefulWidget {
  @override
  _NonComplianceTableState createState() => _NonComplianceTableState();
}


class _NonComplianceTableState extends State<NonComplianceTable> {
  GlobalVariables gb = GlobalVariables();
  List<Data> _ncAuditTable = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Try to load data from SharedPreferences
    String? storedData = prefs.getString('nc_audit_table');

    if (storedData != null) {
      // Data found in SharedPreferences, load it
      List<dynamic> jsonList = jsonDecode(storedData);
      setState(() {
        _ncAuditTable = jsonList.map((json) => Data.fromJson(json)).toList();
        _isLoading = false;
      });
      print("Data loaded from SharedPreferences: $_ncAuditTable");
    } else {
      // No data in SharedPreferences, fetch from API
      await _fetchDataFromAPI();
    }
  }


  Future<void> _fetchDataFromAPI() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Fetch data from the API
      var response = await Provider.of<APIProvider>(context, listen: false).getNCData(context);

      if (response != null && response.data != null) {
        // Ensure the response data is of the correct type
        List<Data> dataList = response.data as List<Data>;

        // Update local variable
        setState(() {
          _ncAuditTable = dataList;
        });

        // Store the data in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String jsonData = jsonEncode(_ncAuditTable.map((data) => data.toJson()).toList());
        await prefs.setString('nc_audit_table', jsonData);

        print("Data fetched from API and stored in SharedPreferences: $_ncAuditTable");
      } else {
        print("No data received from API");
      }
    } catch (e) {
      print("Error fetching data from API: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  void _openFilterDrawer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        DateTime? selectedFromDate;
        DateTime? selectedToDate;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Filter',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: AppColors.meruBlack,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),

                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Station Name',
                        border: OutlineInputBorder(),
                      ),
                      items: <String>[
                        "Kasangula", "Katuba", "Chongwe", "Rufunsa", "SOS", "Libala",
                        "Leopard Hills", "Kamwala", "Long Acres", "Ring Road", "Commonwealth"
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.meruBlack,
                              fontSize: 12.0,
                            ),),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        // Handle dropdown value change
                      },
                    ),
                    SizedBox(height: 16.0),

                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Audit Type',
                        border: OutlineInputBorder(),
                      ),
                      items: <String>["ERB CONA", "ERB TECH", "HSE"]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: AppColors.meruBlack,
                                fontSize: 12.0,
                              )),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        // Handle dropdown value change
                      },
                    ),
                    SizedBox(height: 16.0),

                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'NC Type',
                        border: OutlineInputBorder(),
                      ),
                      items: <String>['Minor', 'Major']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AppColors.meruBlack,
                            fontSize: 12.0,
                          )),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        // Handle dropdown value change
                      },
                    ),
                    SizedBox(height: 16.0),

                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'NC Status',
                        border: OutlineInputBorder(),
                      ),
                      items: <String>['In Progress', 'Submitted', 'Closed']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AppColors.meruBlack,
                            fontSize: 12.0,
                          )),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        // Handle dropdown value change
                      },
                    ),
                    SizedBox(height: 16.0),

                    // From Date Picker
                    SizedBox(
                      width: 300,
                      height: 60,
                      child: GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedFromDate ?? DateTime.now(),
                            firstDate: DateTime(2000), // Allow past dates
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              selectedFromDate = pickedDate;
                              if (selectedToDate != null && selectedToDate!.isBefore(selectedFromDate!)) {
                                selectedToDate = null; // Reset To Date if invalid
                              }
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            selectedFromDate != null
                                ? 'From: ${selectedFromDate!.toLocal().toString().split(' ')[0]}'
                                : 'From',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.meruBlack,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),

                    // To Date Picker
                    SizedBox(
                      width: 300,
                      height: 60,
                      child: GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedToDate ?? (selectedFromDate ?? DateTime.now()),
                            firstDate: selectedFromDate ?? DateTime.now(), // Ensure it's after From date
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              selectedToDate = pickedDate;
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            selectedToDate != null
                                ? 'To: ${selectedToDate!.toLocal().toString().split(' ')[0]}'
                                : 'To',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.meruBlack,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),

                    Spacer(), // Pushes the buttons to the bottom

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: AppColors.meruWhite,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              ),
                              minimumSize: Size(18, 40.0),
                            ),
                            label: Text(
                              "Search",
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
                                CommonFunctions.showMessageDialog(
                                    context: context,
                                    message:
                                    "No results with your filters. Try removing the filters.",
                                    onYesPressed: () {
                                      print('Cancel pressed');
                                    }); // Close the CircularProgressIndicator dialog
                              });

                            },
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: AppColors.meruWhite,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              ),
                              minimumSize: Size(18, 40.0),
                            ),
                            label: Text(
                              "Cancel",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal,
                                color: AppColors.meruWhite,
                                fontSize: 8.0,
                              ),
                            ),
                            onPressed: () {

                            },
                          ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Non Compliance Aging',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: AppColors.meruRed,
            fontSize: 14.0,
          ),
        ),
        backgroundColor: AppColors.meruWhite,
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_sharp, color: AppColors.meruRed),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _openFilterDrawer,
            child: Text(
              'Filter',
              style: TextStyle(
                color: AppColors.meruRed,
                fontSize: 14.0,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _ncAuditTable.isEmpty
          ? Center(child: Text('No data available.'))
          : SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 17.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Number of open NCs by age',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: AppColors.meruBlack,
                    fontSize: 12.0,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                    _buildTableHeader(),
                    ..._ncAuditTable.map((audit) => _buildTableRow(audit)).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(color: AppColors.meruRed),
      children: [
        _buildTableCell('Station Name', true),
        _buildTableCell('Audit Type', true),
        _buildTableCell('NC Section', true),
        _buildTableCell('NC Age', true),
        _buildTableCell('NC Type', true),
        _buildTableCell('View NCs', true),
      ],
    );
  }

  TableRow _buildTableRow(Data audit) {
    return TableRow(
      children: [
        _buildTableCell(audit.station?.stationname ?? 'N/A'),
        _buildTableCell(audit.audit?.type ?? 'N/A'),
        _buildTableCell(audit.status?.toString() ?? 'N/A'),
        _buildTableCell(audit.station?.clusterid?.toString() ?? 'N/A'),
        _buildTableCell('Pending'),
        _buildTableCellWithAction(),
      ],
    );
  }

  Widget _buildTableCell(String text, [bool isHeader = false]) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Montserrat',
          color: isHeader ? AppColors.meruWhite : AppColors.meruBlack,
          fontSize: 12.0,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTableCellWithAction() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 30,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset('assets/images/icon_start.png'),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routenames.ncDetailPage);
            },
            child: const Text(
              'Go',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.blue,
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}




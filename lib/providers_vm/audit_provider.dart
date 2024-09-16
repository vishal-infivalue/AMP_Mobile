import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../response/upcoming_audits.dart';
import '../utils/constant_strings.dart';
import '../utils/shared_preference_helper.dart';

class AuditProvider with ChangeNotifier {

  String baseUrl =
      "http://103.235.106.117:8080/audit_management_system-0.0.31-SNAPSHOT";
  final SharedPreferenceHelper _sharedPrefs = SharedPreferenceHelper();


/*  Future<void> fetchAudits(String loginUserId) async {
    final url = Uri.parse('http://103.235.106.117:8080/audit_management_system-0.0.23-SNAPSHOT/api/auditmaster/getallupcomingaudits');

    final response = await http.get(url, headers: {'loginUserId': loginUserId});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final AuditResponse auditResponse = AuditResponse.fromJson(data);
      _audits = auditResponse.tableData;
      notifyListeners();
    } else {
      throw Exception('Failed to load audits');
    }
  }*/


  List<Audit> _audits = [];

  List<Audit> get audits => _audits;

  List<Map> _stockAuditsTypeListFuel = [];
  List<Map> _stockAuditsTypeListLube = [];
  List<Map> _stockAuditsTypeListLpg = [];
  Map _stockAuditsFuelPMSNozzleUSTDetails = {};
  Map _stockAuditsHeaderDetails = {};
  String _isStockAuditCompleted = "No";

  String get isStockAuditCompleted => _isStockAuditCompleted;

  set isStockAuditCompleted(String value) {
    _isStockAuditCompleted = value;
  }

  Map<String, dynamic> _nozzelsUstsTextControllers = {};
  Map<String, dynamic> _ustTextControllers = {};
  Map<String, dynamic> _ustQnQTextControllers = {};
  Map<String, dynamic> _ddrrTextControllers = {};

  Map<String, dynamic> _lubeProductsTextControllers = {};
  Map<String, dynamic> _lpgProductsTextControllers = {};

  Map<String, dynamic> get lpgProductsTextControllers =>
      _lpgProductsTextControllers;

  set lpgProductsTextControllers(Map<String, dynamic> value) {
    _lpgProductsTextControllers = value;
  }

  Map<String, dynamic> get lubeProductsTextControllers =>
      _lubeProductsTextControllers;

  set lubeProductsTextControllers(Map<String, dynamic> value) {
    _lubeProductsTextControllers = value;
  }

  Map<String, dynamic> get ustQnQTextControllers => _ustQnQTextControllers;

  set ustQnQTextControllers(Map<String, dynamic> value) {
    _ustQnQTextControllers = value;
  }

  Map<String, dynamic> get ddrrTextControllers => _ddrrTextControllers;

  set ddrrTextControllers(Map<String, dynamic> value) {
    _ddrrTextControllers = value;
  }

  Map<String, dynamic> get ustTextControllers => _ustTextControllers;

  set ustTextControllers(Map<String, dynamic> value) {
    _ustTextControllers = value;
  }

  Map<String, dynamic> get nozzelsUstsTextControllers =>
      _nozzelsUstsTextControllers;

  set nozzelsUstsTextControllers(Map<String, dynamic> value) {
    _nozzelsUstsTextControllers = value;
  }

  Map get stockAuditsFuelPMSNozzleUSTDetails =>
      _stockAuditsFuelPMSNozzleUSTDetails;

  set stockAuditsFuelPMSNozzleUSTDetails(Map value) {
    _stockAuditsFuelPMSNozzleUSTDetails = value;
  }

  List<Map> get stockAuditsTypeListFuel => _stockAuditsTypeListFuel;

  set stockAuditsTypeListFuel(List<Map> value) {
    _stockAuditsTypeListFuel = value;
  }

  List<Map> get stockAuditsTypeListLpg => _stockAuditsTypeListLpg;

  set stockAuditsTypeListLpg(List<Map> value) {
    _stockAuditsTypeListLpg = value;
  }

  List<Map> get stockAuditsTypeListLube => _stockAuditsTypeListLube;

  set stockAuditsTypeListLube(List<Map> value) {
    _stockAuditsTypeListLube = value;
  }

  Map get stockAuditsHeaderDetails => _stockAuditsHeaderDetails;

  Future<void> fetchAudits(String loginUserId) async {
    final url = Uri.parse(
        baseUrl+'/api/auditmaster/getallupcomingaudits');

    final response = await http.get(url, headers: {'loginUserId': loginUserId});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final AuditResponse auditResponse = AuditResponse.fromJson(data);
      _audits = auditResponse.tableData;
      notifyListeners();
    } else {
      throw Exception('Failed to load audits');
    }
  }

  Future<void> fetchStockAuditsList(String type) async {
    var auditId =
        '3108202401'; // temporary static variable, Need to fetch from Shared Preference

    final url = Uri.parse(
        baseUrl+'/api/v1/audit/fuelstock/get-product-by-category?category=$type&auditId=$auditId');

    String loginUserId = '16031592';
    final response = await http.get(url, headers: {'loginUserId': loginUserId});

    if (response.statusCode == 200) {
      final resData = json.decode(response.body) as Map<String, dynamic>;

      if (resData['status'] == "200" && resData['result'] == 'Successful') {
        _isStockAuditCompleted = resData['data']['isAuditCompleted'];

        if (type == 'Fuel') {
          _stockAuditsTypeListFuel = [];
          resData['data']['productResponses'].forEach((eachData) {
            _stockAuditsTypeListFuel.add(eachData);
          });
        } else if (type == 'Lube') {
          _stockAuditsTypeListLube = [];
          resData['data']['productResponses'].forEach((eachData) {
            _stockAuditsTypeListLube.add(eachData);
          });
        } else if (type == 'Lpg') {
          _stockAuditsTypeListLpg = [];
          resData['data']['productResponses'].forEach((eachData) {
            _stockAuditsTypeListLpg.add(eachData);
          });
        }
      }
      notifyListeners();
    } else {
      throw Exception('Failed to load Stock audit list: $type');
    }
  }

  Future<void> fetchStockAuditsHeaderDetails(String auditId) async {
    auditId = '250720240001'; // temporary static variable

    final url = Uri.parse(
        baseUrl+'/api/v1/audit/fuelstock/get-header-details?auditId=$auditId');

    String loginUserId = '16031592'; // temporary static variable

    final response = await http.get(url, headers: {'loginUserId': loginUserId});

    if (response.statusCode == 200) {
      final resData = json.decode(response.body) as Map<String, dynamic>;
      if (resData['status'] == "200" && resData['result'] == 'Successful') {
        _stockAuditsHeaderDetails = resData['data'];
      }
      notifyListeners();
    } else {
      throw Exception('Failed to load fetchStockAuditsHeaderDetails');
    }
  }

  // Fuel
  Future<void> fetchStockAuditsNozzelsUSTDetails(
      {String? auditId, String? type}) async {
    auditId = '280820240001'; // temporary static variable

    final url = Uri.parse(
        baseUrl+'/api/v1/audit/fuelstock/get-stock-reconciliation-details?auditId=$auditId&category=FUEL&subCategory=$type');

    // String loginUserId = '16031592'; // temporary static variable
    String? userIdLoggedIn = await _sharedPrefs.getString(ConstantStrings.userIdLoggedIn);
    final response = await http.get(url, headers: {'loginUserId': userIdLoggedIn!});

    if (response.statusCode == 200) {
      final resData = json.decode(response.body) as Map<String, dynamic>;
      if (resData['status'] == "200" && resData['result'] == 'Successful') {
        if ("$type" == "PMS") {
          _nozzelsUstsTextControllers = {};
          _ustTextControllers = {};
          _ustQnQTextControllers = {};
          _ddrrTextControllers = {};
          resData['data']['NOZZLE'].forEach((eachData) {
            var tempData = {
              'nozzle_id': eachData['id'],
              'textControllers': [
                TextEditingController(),
                TextEditingController(
                    text: '${eachData['previousClosedReading']}' == 'null'
                        ? ''
                        : '${eachData['previousClosedReading']}'),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
              ],
            };
            var tempDataDDRR = {
              'nozzle_id': eachData['id'],
              'textControllers': [
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
              ],
            };
            _nozzelsUstsTextControllers["${eachData['productName']}"] =
                tempData;
            _ddrrTextControllers["${eachData['productName']}"] = tempDataDDRR;
          });
          resData['data']['UST'].forEach((eachData) {
            var tempData = {
              'ust_id': eachData['id'],
              'textControllers': [
                TextEditingController(),
                TextEditingController(
                    text: '${eachData['previousClosedReading']}' == 'null'
                        ? ''
                        : '${eachData['previousClosedReading']}'),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
              ],
            };
            var tempDataQnQ = {
              'ust_id': eachData['id'],
              'textControllers': [
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
              ],
            };
            _ustTextControllers["${eachData['productName']}"] = tempData;
            _ustQnQTextControllers["${eachData['productName']}"] = tempDataQnQ;
          });
        }

        if ("$type" == "LSD") {
          _nozzelsUstsTextControllers = {};
          _ustTextControllers = {};
          _ustQnQTextControllers = {};
          _ddrrTextControllers = {};
          resData['data']['NOZZLE'].forEach((eachData) {
            var tempData = {
              'nozzle_id': eachData['id'],
              'textControllers': [
                TextEditingController(),
                TextEditingController(
                    text: '${eachData['previousClosedReading']}' == 'null'
                        ? ''
                        : '${eachData['previousClosedReading']}'),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
              ],
            };
            var tempDataDDRR = {
              'nozzle_id': eachData['id'],
              'textControllers': [
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
              ],
            };
            _nozzelsUstsTextControllers["${eachData['productName']}"] =
                tempData;
            _ddrrTextControllers["${eachData['productName']}"] = tempDataDDRR;
          });
          resData['data']['UST'].forEach((eachData) {
            var tempData = {
              'ust_id': eachData['id'],
              'textControllers': [
                TextEditingController(),
                TextEditingController(
                    text: '${eachData['previousClosedReading']}' == 'null'
                        ? ''
                        : '${eachData['previousClosedReading']}'),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
              ],
            };
            var tempDataQnQ = {
              'ust_id': eachData['id'],
              'textControllers': [
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
              ],
            };
            _ustTextControllers["${eachData['productName']}"] = tempData;
            _ustQnQTextControllers["${eachData['productName']}"] = tempDataQnQ;
          });
        }

        if ("$type" == "DK") {
          _nozzelsUstsTextControllers = {};
          _ustTextControllers = {};
          _ustQnQTextControllers = {};
          _ddrrTextControllers = {};
          resData['data']['NOZZLE'].forEach((eachData) {
            var tempData = {
              'nozzle_id': eachData['id'],
              'textControllers': [
                TextEditingController(),
                TextEditingController(
                    text: '${eachData['previousClosedReading']}' == 'null'
                        ? ''
                        : '${eachData['previousClosedReading']}'),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
              ],
            };
            var tempDataDDRR = {
              'nozzle_id': eachData['id'],
              'textControllers': [
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
              ],
            };
            _nozzelsUstsTextControllers["${eachData['productName']}"] =
                tempData;
            _ddrrTextControllers["${eachData['productName']}"] = tempDataDDRR;
          });
          resData['data']['UST'].forEach((eachData) {
            var tempData = {
              'ust_id': eachData['id'],
              'textControllers': [
                TextEditingController(),
                TextEditingController(
                    text: '${eachData['previousClosedReading']}' == 'null'
                        ? ''
                        : '${eachData['previousClosedReading']}'),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
              ],
            };
            var tempDataQnQ = {
              'ust_id': eachData['id'],
              'textControllers': [
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
              ],
            };
            _ustTextControllers["${eachData['productName']}"] = tempData;
            _ustQnQTextControllers["${eachData['productName']}"] = tempDataQnQ;
          });
        }
        _stockAuditsFuelPMSNozzleUSTDetails = resData['data'];
      }
      notifyListeners();
    } else {
      throw Exception('Failed to load fetchStockAuditsNozzelsUSTDetails');
    }
  }

  // for Lube-LPG
  Future<void> fetchStockAuditsLubeLPGDetails(
      {String? auditId, String? type}) async {
    auditId = '280820240001'; // temporary static variable

    final url = Uri.parse(
        baseUrl+'/api/v1/audit/fuelstock/get-stock-reconciliation-details?auditId=$auditId&category=$type');

    String loginUserId = '16031592'; // temporary static variable
    final response = await http.get(url, headers: {'loginUserId': loginUserId});

    if (response.statusCode == 200) {
      final resData = json.decode(response.body) as Map<String, dynamic>;
      if (resData['status'] == "200" && resData['result'] == 'Successful') {
        if ("$type" == "LUBE") {
          _nozzelsUstsTextControllers = {};
          resData['data']['LUBE'].forEach((eachData) {
            var tempData = {
              "product_name": "${eachData['productName']}",
              "product_shortCode": "${eachData['productShortCode']}",
              "textControllers": [
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
              ]
            };
            _lubeProductsTextControllers["${eachData['id']}"] = tempData;
          });
        }
        if ("$type" == "LPG") {
          _lpgProductsTextControllers = {};
          resData['data']['LPG'].forEach((eachData) {
            var tempData = {
              "product_name": "${eachData['productName']}",
              "product_shortCode": "${eachData['productShortCode']}",
              "productPrice": "${eachData['productPrice']}",
              "textControllers": [
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
              ]
            };
            _lpgProductsTextControllers["${eachData['id']}"] = tempData;
          });
        }
      }
      notifyListeners();
    } else {
      throw Exception('Failed to load fetchStockAuditsLubeLPGDetails');
    }
  }

  Future<String> saveStockAuditData({Map? stockAuditData}) async {
    var auditId = '280820240001'; // temporary static variable

    final url = Uri.parse(
        '/api/v1/audit/fuelstock/create-stock-audit');

    String? userIdLoggedIn = await _sharedPrefs.getString(ConstantStrings.userIdLoggedIn);

    // String loginUserId = '16031592'; // temporary static variable

    final response = await http.post(
      url,
      headers: {"loginUserId": userIdLoggedIn!, "Content-Type": "application/json"},
      body: jsonEncode(stockAuditData),
    );

    final resData = json.decode(response.body) as Map<String, dynamic>;

    print(" saveStockAuditData  resData--> $resData");

    if (response.statusCode == 200) {
      return '${resData['result']}';
    } else if (response.statusCode == 201) {
      return 'Audit Data Saved Successfully';
    } else {
      print('Failed to load fetchStockAuditsNozzelsUSTDetails');
      return "Sorry!!!. Please try after sometime";
    }
  }

  Future<String> stock_audit_submit_to_station({String? auditId}) async {
    final url = Uri.parse(
        baseUrl+'/api/auditmaster/submitaudit');

    String loginUserId = '16031592'; // temporary static variable

    final response = await http.post(
      url,
      headers: {"loginUserId": loginUserId, "Content-Type": "application/json"},
      body: jsonEncode({"id": "$auditId"}),
    );

    final resData = json.decode(response.body) as Map<String, dynamic>;

    print(" stock_audit_submit_to_station  resData--> $resData");

    if (resData['state'] == 'Submitted') {
      return 'Audit Submitted Successfully: ${resData['id']}';
    } else {
      return 'Audit Submit Failed: ${resData['id']}';
    }
  }


}

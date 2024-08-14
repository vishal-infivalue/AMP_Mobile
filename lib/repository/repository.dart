import 'package:amp/utils/constant_strings.dart';
import 'package:flutter/cupertino.dart';

import '../response/ERB_CustomerCheck_ListResponse.dart';
import '../services/network_services.dart';
import '../utils/shared_preference_helper.dart';

class AppRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  final SharedPreferenceHelper _sharedPrefs = SharedPreferenceHelper();

  String baseUrl =
      "http://103.235.106.117:8080/audit_management_system-0.0.9-SNAPSHOT";



  //average cluster score
  Future<dynamic> getclusteravgscore() async {
    String? userIdLoggedIn = await _sharedPrefs.getString(ConstantStrings.userIdLoggedIn);
    try {

      var response = await _apiServices.getApiWithHeader(
          "$baseUrl/api/dashboard/audit/getclusteravgscore",userIdLoggedIn!);
      return response;
    } catch (e) {
      return null;
    }
  }

  //top performing stations
  Future<dynamic> getperformingstations() async {
    String? userIdLoggedIn = await _sharedPrefs.getString(ConstantStrings.userIdLoggedIn);
    try {

      var response = await _apiServices.getApiWithHeader(
          "$baseUrl/api/dashboard/audit/getperformingstations?sort=Top",userIdLoggedIn!);
      return response;
    } catch (e) {
      return null;
    }
  }

  //bottom performing stations
  Future<dynamic> getperformingstationsBottom() async {
    String? userIdLoggedIn = await _sharedPrefs.getString(ConstantStrings.userIdLoggedIn);
    try {

      var response = await _apiServices.getApiWithHeader(
          "$baseUrl/api/dashboard/audit/getperformingstations?sort=Bottom",userIdLoggedIn!);
      return response;
    } catch (e) {
      return null;
    }
  }


  //prevalidate
  Future<dynamic> prevalidateUser(dynamic data) async {
    try {
      var response = await _apiServices.postApi(
          "$baseUrl/api/login/prevalidateuser", data);
      return response;
    } catch (e) {
      return null;
    }
  }




  //generate otp
  Future<dynamic> generateOTP(dynamic data) async {
    try {
      var response = await _apiServices.postApi("$baseUrl/api/login/generateotp", data);
      return response;
    } catch (e) {
      return null;
    }
  }


  //validate OTP
  Future<dynamic> validateUserOtp(dynamic data) async {
    try {
      var response = await _apiServices.postApi(
          "$baseUrl/api/login/validateuserotp", data);
      return response;
    } catch (e) {
      return null;
    }
  }


  //getAll Pending Audits
  Future<dynamic> getAllPendingAudits() async {

    String? userIdLoggedIn = await _sharedPrefs.getString(ConstantStrings.userIdLoggedIn);

    try {
      var response = await _apiServices.postWithHeaderUserId(
          "$baseUrl/api/auditmaster/getallupcomingaudits",userIdLoggedIn!);
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getAllDashBoard() async {

    String? userIdLoggedIn = await _sharedPrefs.getString(ConstantStrings.userIdLoggedIn);

    try {
      var response = await _apiServices.postWithHeaderUserId(
          "$baseUrl/api/dashboard/getdashboarddetails",userIdLoggedIn!);
      return response;
    } catch (e) {
      return null;
    }
  }

/*  Future<ERBCustomerCheckListResponse?> getERBCustomerCheckList(Map<String, dynamic> data) async {
    // Simulating a network call
    await Future.delayed(Duration(seconds: 2));

    // This should be replaced with actual API call
    return ERBCustomerCheckListResponse(questions: [
      {'description': 'Question 1', 'subheader': '', 'additionalnotes': '', 'question': ''},
      {'description': 'Question 2', 'subheader': 'Subheader 2', 'additionalnotes': 'Notes 2', 'question': 'Question 2'},
      {'description': 'Question 3', 'subheader': '', 'additionalnotes': '', 'question': 'Question 3'},
    ], auditDetails: null);
  }*/

  /*Future<void> getERBCusomerCheckLIst(String jsonData, BuildContext context) async {
    setLoading(true);

    Map<String, dynamic> data = jsonDecode(jsonData);

    var response = await _appRepository.getERBCusomerCheckLIst(data);
    setLoading(false);

    if (response != null) {
      print("Successful $response");
      setResponse(response);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successful $response")));
    } else {
      print("Error fetching data");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error")));
    }
  }*/

  //getERB Consumer Checklist
  Future<dynamic> getERBCusomerCheckLIst(dynamic data) async {

    String? userIdLoggedIn = await _sharedPrefs.getString(ConstantStrings.userIdLoggedIn);

    try {
      var response = await _apiServices.postWithHeaderUserIdData(
          "$baseUrl/api/erbaudit/loaddata",userIdLoggedIn!,data);
      return response;
    } catch (e) {
      return null;
    }
  }

  //post audit data
  Future<dynamic> postAuditData(dynamic data) async {

    String? userIdLoggedIn = await _sharedPrefs.getString(ConstantStrings.userIdLoggedIn);

    try {
      var response = await _apiServices.postWithHeaderUserIdData(
          "$baseUrl/api/erbaudit/createerbaudit",userIdLoggedIn!,data);
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getAuditScreenData(dynamic data) async {

    String? userIdLoggedIn = await _sharedPrefs.getString(ConstantStrings.userIdLoggedIn);

    try {
      var response = await _apiServices.postWithHeaderUserIdData(
          "$baseUrl/api/erbaudit/loaddata",userIdLoggedIn!,data);
      return response;
    } catch (e) {
      return null;
    }
  }


  //postERB ScoreCard
  Future<dynamic> getScoreCard(dynamic data) async {

    String? userIdLoggedIn = await _sharedPrefs.getString(ConstantStrings.userIdLoggedIn);

    try {
      var response = await _apiServices.postWithHeaderUserIdData(
          "$baseUrl/api/erbaudit/geterbscorecard",userIdLoggedIn!,data);
      return response;
    } catch (e) {
      return null;
    }
  }

}

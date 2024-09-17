import 'package:amp/utils/constant_strings.dart';

import '../services/network_services.dart';
import '../utils/shared_preference_helper.dart';

class AppRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  final SharedPreferenceHelper _sharedPrefs = SharedPreferenceHelper();

  String baseUrl =
      "http://103.235.106.117:8080/audit_management_system-0.0.31-SNAPSHOT";

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

  //start Audit
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

  //hold the audit
  Future<dynamic> holdAudit(dynamic data) async {

    String? userIdLoggedIn = await _sharedPrefs.getString(ConstantStrings.userIdLoggedIn);

    try {
      var response = await _apiServices.postWithHeaderUserIdData(
          "$baseUrl/api/auditmaster/holdaudit",userIdLoggedIn!,data);
      return response;
    } catch (e) {
      return null;
    }
  }

  //submit the audit
  Future<dynamic> submitAudit(dynamic data) async {

    String? userIdLoggedIn = await _sharedPrefs.getString(ConstantStrings.userIdLoggedIn);

    try {
      var response = await _apiServices.postWithHeaderUserIdData(
          "$baseUrl/api/auditmaster/submitaudit",userIdLoggedIn!,data);
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


  //get ALL NC Data
  Future<dynamic> getNCData() async {
    String? userIdLoggedIn = await _sharedPrefs.getString(ConstantStrings.userIdLoggedIn);

    try {
      var response = await _apiServices.getApiWithHeader(
          "$baseUrl/api/nc/search",userIdLoggedIn!);
      return response;
    } catch (e) {
      return null;
    }
  }

  //get  ALL Stations
  Future<dynamic> getAllStations() async {
    String? userIdLoggedIn = await _sharedPrefs.getString(ConstantStrings.userIdLoggedIn);

    try {
      var response = await _apiServices.postWithHeaderUserId(
          "$baseUrl/api/stations/getallstations",userIdLoggedIn!);
      return response;
    } catch (e) {
      return null;
    }
  }

  //post NC Updates
  Future<dynamic> postNCUpdate(dynamic data) async {

    String? userIdLoggedIn = await _sharedPrefs.getString(ConstantStrings.userIdLoggedIn);

    try {
      var response = await _apiServices.postWithHeaderUserIdData(
          "$baseUrl/api/nc/update",userIdLoggedIn!,data);
      return response;
    } catch (e) {
      return null;
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'app_exception.dart';

class AppRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  // String baseUrl = "http://103.235.106.117:8080/audit_management_system-0.0.2-SNAPSHOT";
  String baseUrl =
      "http://103.235.106.117:8080/audit_management_system-0.0.3-SNAPSHOT";

  Future<dynamic> generateOTPTest(dynamic data) async {
    try {
      var response =
          await _apiServices.postApi("$baseUrl/api/login/generateotp", data);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

class ApiServices {
  Future<dynamic> postApi(String url, dynamic data) async {
    // Dummy implementation
    return Future.delayed(Duration(seconds: 2), () => {"status": "success"});
  }
}

abstract class BaseApiServices {
  Future<dynamic> postApi(String url, dynamic data);

  Future<dynamic> postWithHeaderUserId(String url, String loginUserId);

  Future<dynamic> postWithHeaderUserIdData(
      String url, String loginUserId, dynamic data);

  Future<dynamic> getApiWithHeader(String url, String loginUserId);

  Future<dynamic> getApi(String url);
}

class NetworkApiServices extends BaseApiServices {
  dynamic apiResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw UnAuthorizedException(message: response.body.toString());
      case 401:
        throw UnAuthorizedException(message: response.body.toString());
      case 415:
        throw UnAuthorizedException(message: "SOME ERROR");
      case 500:
        throw UnAuthorizedException(message: "INTERNAL SERVER ERROR");
      default:
        throw FetchDataException(message: "Error during communication");
    }
  }

  @override
  Future postApi(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final headers = {"Content-Type": "application/json"};
      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data), // Ensure the body is JSON encoded
      );
      responseJson = apiResponse(response);
    } catch (e) {
      print(e.toString());
    }
    return responseJson;
  }

  Future<dynamic> postWithHeaderUserId(String url, String loginUserId) async {
    dynamic responseJson;
    try {
      final headers = {
        "Content-Type": "application/json",
        "loginUserId": loginUserId, // Add the loginUserId header
      };
      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
      );
      responseJson = apiResponse(response);
    } catch (e) {
      print(e.toString());
    }
    return responseJson;
  }

  Future<dynamic> postWithHeaderUserIdData(
      String url, String loginUserId, dynamic data) async {
    dynamic responseJson;
    try {
      final headers = {
        "Content-Type": "application/json",
        "loginUserId": loginUserId,
      };
      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );
      responseJson = apiResponse(response);
    } catch (e) {
      print(e.toString());
    }
    return responseJson;
  }

  @override
  Future getApiWithHeader(String url, String loginUserId) async {
    dynamic responseJson;
    try {
      final headers = {
        "Content-Type": "application/json",
        "loginUserId": loginUserId, // Add the loginUserId header
      };
      http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      responseJson = apiResponse(response);
    } catch (e) {
      print(e.toString());
    }
    return responseJson;
  }

  Future getApi(String url) async {
    dynamic responseJson;
    try {
      final headers = {
        "Content-Type": "application/json", // Add the loginUserId header
      };
      http.Response response = await http.get(Uri.parse(url));
      responseJson = apiResponse(response);
    } catch (e) {
      print(e.toString());
    }
    return responseJson;
  }
}

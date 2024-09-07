import 'dart:convert';

import 'package:amp/response/all_dashboard_response.dart';
import 'package:amp/response/averageScoreResponse.dart';
import 'package:amp/response/prevalidate_response.dart';
import 'package:amp/utils/constant_strings.dart';
import 'package:amp/utils/global_values.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/repository.dart';
import '../response/ERBResponse.dart';
import '../response/performing_stations.dart';
import '../response/score_card_response.dart';
import '../response/upcoming_audits.dart';
import '../response/validateUserOtp.dart';
import '../routes/route_names.dart';

class APIProvider with ChangeNotifier {
  final _appRepository = AppRepository();
  GlobalVariables gb = GlobalVariables();

  bool _loading = false;
  bool get loading => _loading;

  List<AuditDetails> _erbCustomerCheckListResponse = [];
  List<AuditDetails> get erbCustomerCheckListResponse => _erbCustomerCheckListResponse;



  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }


  //AuditResponse
  List<Audit> _pendingAudits = [];
  List<Audit> get pendingAudits => _pendingAudits;


  List<TableData>  _pendingAuditTable = [];
  List<TableData> get pendingAuditTable => _pendingAuditTable;




  bool _isLoading = false;

  ///api/dashboard/audit/getclusteravgscore

  String _avgMessage = '0';
  String get avgMessage => _avgMessage;

  double _avgScore = 0.0;
  double get avgScore => _avgScore;

  String _grade = '0';
  String get grade => _grade;

  String _gradeValue = '0';
  String get gradeValue => _gradeValue;


  Future<void> getclusteravgscore(BuildContext context) async {
    setLoading(true);

    try {
      var response = await _appRepository.getclusteravgscore();

      setLoading(false);

      if (response != null) {
        var auditResponse = AuditScoreAverageResponse.fromJson(response);
        _avgMessage = auditResponse.message;
        _avgScore = auditResponse.avgScore;
        _grade = auditResponse.grade;
        _gradeValue = auditResponse.gradeValue;
        print("API Response: $response");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(ConstantStrings.avergaeClusterScore, jsonEncode(response));
      } else {
        print("Error pre-validating user");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error in average cluster")));
      }
    } catch (e) {
      setLoading(false);
      print("Error in audit data: $e");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error in average cluster")));
    }
  }

  ///api/dashboard/audit/getperformingstations?sort=Top
  List<Station> _stationList = [];
  List<Station> get stationList => _stationList;

  Future<void> getperformingstations(BuildContext context) async {
    setLoading(true);

    try {
      var response = await _appRepository.getperformingstations();
      setLoading(false);

      if (response != null) {
        var topStationsResponse = PerformingStationResponse.fromJson(response);

        _stationList = topStationsResponse.body;
        gb.topStationList = topStationsResponse.body;


      } else {
        print("Error pre-validating user");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error in top performing")));
      }
    } catch (e) {
      setLoading(false);
      print("Error in audit data: $e");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error in top performing")));
    }
  }

  //api/dashboard/audit/getperformingstations?sort=Bottom
  List<Station> _stationListBottom = [];
  List<Station> get stationListBottom => _stationListBottom;
  Future<void> getperformingstationsBottom(BuildContext context) async {
    setLoading(true);

    try {
      var response = await _appRepository.getperformingstationsBottom();
      setLoading(false);

      if (response != null) {
        var bottomStationsResponse = PerformingStationResponse.fromJson(response);
        _stationListBottom = bottomStationsResponse.body;
        gb.bottomStationList = bottomStationsResponse.body;


      } else {
        print("Error pre-validating user");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error Bottom Performing")));
      }
    } catch (e) {
      setLoading(false);
      print("Error in audit data: $e");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error Bottom Performing")));
    }
  }





  //prevalidate
  String _statusOfUser = '0';
  String get statusOfUser => _statusOfUser;
  List<User> _statusResponse = [];
  List<User> get statusResponse => _statusResponse;
  bool _isButtonEnabled = false;
  bool get isButtonEnabled => _isButtonEnabled;

  // Future<void> prevalidateUser(String jsonData, BuildContext context) async {
  //   setLoading(true);
  //
  //   Map<String, dynamic> data = jsonDecode(jsonData);
  //
  //   try {
  //     var response = await _appRepository.prevalidateUser(data);
  //     setLoading(false);
  //
  //     if (response != null) {
  //       print("User pre-validated successfully: $response");
  //       _isButtonEnabled = true;
  //       notifyListeners(); // Notify listeners about the state change
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text("User pre-validated successfully"))
  //       );
  //     } else {
  //       print("Error pre-validating user");
  //       _isButtonEnabled = false;
  //       notifyListeners(); // Notify listeners about the state change
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text("Error pre-validating user"))
  //       );
  //     }
  //   } catch (e) {
  //     setLoading(false);
  //     print("Error pre-validating user: $e");
  //
  //     _isButtonEnabled = false;
  //     notifyListeners(); // Notify listeners about the state change
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Error pre-validating user"))
  //     );
  //   }
  // }

  Future<void> prevalidateUser(String jsonData, BuildContext context) async {
    setLoading(true);

    Map<String, dynamic> data = jsonDecode(jsonData);

    try {
      var response = await _appRepository.prevalidateUser(data);
      setLoading(false);

      if (response != null) {

        gb.isButtonEnabled_gb = true;
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User pre-validated ")));
      } else {
        print("Error pre-validating user");

        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error pre-validating user")));
      }
    } catch (e) {
      setLoading(false);
      print("Error pre-validating user: $e");

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error pre-validating user")));
    }
  }

  //generateOTP
  Future<void> generateOtp(String jsonData, BuildContext context) async {
    setLoading(true);
    gb.isButtonEnabled_gb = false;

    Map<String, dynamic> data = jsonDecode(jsonData);

    try {
      var response = await _appRepository.generateOTP(data);
      setLoading(false);

      if (response != null) {
        print("User pre-validated successfully: $response");
        gb.isButtonEnabled_gb = true;

        Fluttertoast.showToast(
          msg: "OTP generated and sent to the User Registered Phone Number.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
        );

        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("OTP generated and sent to the User Registered Phone Number.")));
      } else {
        gb.isButtonEnabled_gb = false;
        print("Error pre-validating user");


        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid OTP")));
      }
    } catch (e) {
      setLoading(false);


      print("Error pre-validating user: $e");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error pre-validating user")));
    }
  }

  //validateOTP
  Future<void> validateUserOtp(String jsonData, BuildContext context) async {
    setLoading(true);

    Map<String, dynamic> data = jsonDecode(jsonData);

    var response = await _appRepository.validateUserOtp(data);
    setLoading(false);

    if (response != null) {

      var auditResponse = UserResponse.fromJson(response);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(ConstantStrings.userDetails, jsonEncode(auditResponse));
      Fluttertoast.showToast(
        msg: "Login Successful.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
      );

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User OTP validated successfully")));
      Navigator.pushNamed(context, Routenames.dmDashboardScreen);
    } else {
      Fluttertoast.showToast(
        msg: "Invalid OTP",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
      );
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error validating user OTP")));
    }
  }


  //fetch pending audits
  String _pendingAuditsCount = '0';
  String get pendingAuditsCount => _pendingAuditsCount;
  String _numberOfAudits = '0';
  String get numberOfAudits => _numberOfAudits;
  Future<void> fetchPendingAudits(BuildContext context) async {
    setLoading(true);
    var response = await _appRepository.getAllPendingAudits();
    setLoading(false);

    if (response != null) {
      var auditResponse = AuditResponse.fromJson(response);
      _pendingAudits = auditResponse.tableData;
      _pendingAuditsCount = auditResponse.pendingAudits;
      _numberOfAudits = auditResponse.numberOfAudits;
      notifyListeners();
      print("Successful $response");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successful")));


    } else {
      print("Error fetching data");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error")));
    }
  }


  String _upcomingAuditMessage = 'Loading..';
  String get upcomingAuditMessage => _upcomingAuditMessage;

  String _numberOfAuditsUpcoming = 'Loading..';
  String get numberOfAuditsUpcoming => _numberOfAuditsUpcoming;

  String _avgMessageDB = '0';
  String get avgMessageDB => _avgMessageDB;

  double _avgScoreDB = 0.0;
  double get avgScoreDB => _avgScoreDB;

  String _gradeDB = '0';
  String get gradeDB => _gradeDB;

  String _gradeValueDB = '0';
  String get gradeValueDB => _gradeValueDB;

  String _completedaudits = '0';
  String get completedaudits => _completedaudits;
  String _numberofaudits = '0';
  String get numberofaudits => _numberofaudits;
  String _numberofERBCONAaudits = '0';
  String get numberofERBCONAaudits => _numberofERBCONAaudits;
  String _numberofERBTECHaudits = '0';
  String get numberofERBTECHaudits => _numberofERBTECHaudits;
  String _numberofHSEaudits = '0';
  String get numberofHSEaudits => _numberofHSEaudits;
  String _numberofFUELaudits = '0';
  String get numberofFUELaudits => _numberofFUELaudits;

  List<CompletedAudit> _completedAuditList = [];
  List<CompletedAudit> get completedAuditList => _completedAuditList;



  Future<void> getAllDashBoard(BuildContext context) async {
    setLoading(true);
    var response = await _appRepository.getAllDashBoard();
    setLoading(false);

    if (response != null) {
      var dashboardAllResponse = DashboardAllResponse.fromJson(response);
      _avgScoreDB = dashboardAllResponse.auditScoreSummary.avgScore;
      _gradeDB = dashboardAllResponse.auditScoreSummary.gradeValue;
      _avgMessageDB = dashboardAllResponse.auditScoreSummary.message;
      _gradeValueDB = dashboardAllResponse.auditScoreSummary.gradeValue;

      _completedAuditList = dashboardAllResponse.completedAuditResponse.completedAuditList;
      _completedaudits = dashboardAllResponse.completedAuditResponse.completedaudits;
      _numberofaudits = dashboardAllResponse.completedAuditResponse.numberofaudits;

      gb.completedaudits_gb = dashboardAllResponse.completedAuditResponse.completedaudits;
      gb.numberofERBCONAaudits_gb = dashboardAllResponse.completedAuditResponse.numberofERBCONAaudits;
      gb.numberofERBTECHaudits_gb = dashboardAllResponse.completedAuditResponse.numberofERBTECHaudits;
      gb.numberofHSEaudits_gb =  dashboardAllResponse.completedAuditResponse.numberofHSEaudits;
      gb.numberofFUELaudits_gb =  dashboardAllResponse.completedAuditResponse.numberofFUELaudits;
      gb.numberOfAuditsCompleted_gb = dashboardAllResponse.completedAuditResponse.numberofaudits;

      _completedAuditList = dashboardAllResponse.completedAuditResponse.completedAuditList;



      _pendingAuditTable = dashboardAllResponse.upcomingAuditsResponse.tabledata;
      _upcomingAuditMessage = dashboardAllResponse.upcomingAuditsResponse.pendingaudits.toString();
      _numberOfAuditsUpcoming = dashboardAllResponse.upcomingAuditsResponse.numberofaudits.toString();


      notifyListeners();
      print("Successful $response");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successful")));


    } else {
      print("Error fetching data");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error")));
    }
  }

  //fetch consumer audit


/*
  Future<void> getERBCustomerCheckList(String jsonData, BuildContext context) async {
    setLoading(true);

    Map<String, dynamic> data = jsonDecode(jsonData);

    try {
      var response = await _appRepository.getERBCusomerCheckLIst(data);



      setLoading(false);



      if (response != null) {

        var auditResponse = AuditResponses.fromJson(response);
        _questions = auditResponse.questions ?? [];
        _selection_audit = auditResponse.selection ?? [];


        print("API Response VISHAL3: $response\n $_questions");
      } else {
        print("Error pre-validating VISHAL3");
      }
    } catch (e) {
      setLoading(false);
      print("Error in audit data VISHAL3: $e");
    }
  }*/

  //getScoreCard
  String _heading = '0';
  String get heading => _heading;

  String _evolscoresummary = '0';
  String get evolscoresummary => _evolscoresummary;

  String _cumusummary = '0';
  String get cumusummary => _cumusummary;

  String _stationname = '0';
  String get stationname => _stationname;

  String _stationcode = '0';
  String get stationcode => _stationcode;

  String _stationtype = '0';
  String get stationtype => _stationtype;

  String _staymanagername = '0';
  String get staymanagername => _staymanagername;

  String _clustermanagername = '0';
  String get clustermanagername => _clustermanagername;

  String _auditorname = '0';
  String get auditorname => _auditorname;

  String _auditstarttime = '0';
  String get auditstarttime => _auditstarttime;


  String _auditendtime = '0';
  String get auditendtime => _auditendtime;


  String _overallgrade = '0';
  String get overallgrade => _overallgrade;

  String _remarks = '0';
  String get remarks => _remarks;


  List<Section> _header = [];
  List<Section> get header => _header;

  List<Section> _subheader = [];
  List<Section> get subheader => _subheader;

  List<PreviousScore> _previousScore = [];
  List<PreviousScore> get previousScore => _previousScore;

  Future<void> getScoreCard(String jsonData, BuildContext context) async {
    setLoading(true);

    Map<String, dynamic> data = jsonDecode(jsonData);

    try {
      var response = await _appRepository.getScoreCard(data);
      setLoading(false);

      if (response != null) {
        gb.loaded = true;

        var scoreCardResponse = ScoreCardResponse.fromJson(response);
        _heading = scoreCardResponse.heading.toString();
        _evolscoresummary = scoreCardResponse.evolScoreSummary;
        _cumusummary = scoreCardResponse.cumuSummary;
        _stationname = scoreCardResponse.stationName;
        _stationcode = scoreCardResponse.stationCode;
        _stationcode = scoreCardResponse.stationCode;
        _stationtype = scoreCardResponse.stationType;
        _staymanagername = scoreCardResponse.stayManagerName;
        _clustermanagername = scoreCardResponse.clusterManagerName;
        _auditorname = scoreCardResponse.clusterManagerName;
        _auditstarttime = scoreCardResponse.auditStartTime;
        _auditendtime = scoreCardResponse.auditEndTime!;
        _overallgrade = scoreCardResponse.overallGrade;

        _header = scoreCardResponse.header;
        _subheader = scoreCardResponse.subHeader;

        _previousScore = scoreCardResponse.previousScores;


        print("Success ScoreCard");
      } else {
        print("Error ScoreCard");
      }
    } catch (e) {
      setLoading(false);
      print("Error ScoreCard");
    }
  }


  List<Question> _questions = [];
  List<Question> get questions => _questions;

  List<Selection> _selection_audit = [];
  List<Selection> get selection_audit => _selection_audit;

  String _type = "Loading..";
  String get type => _type;


  Future<void> getAuditScreenData(String jsonData, BuildContext context) async {
    setLoading(true);

    Map<String, dynamic> data = jsonDecode(jsonData);

    var response = await _appRepository.getAuditScreenData(data);

    if(response!= null){

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(ConstantStrings.ERBCustomerCheckListResponse, jsonEncode(response));

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$response")));


    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please reload the page")));
    }

  }

  Future<void> holdAudit(String jsonData, BuildContext context) async {
    setLoading(true);

    Map<String, dynamic> data = jsonDecode(jsonData);

    var response = await _appRepository.holdAudit(data);

    if(response!= null){


      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The audit details entered so far has been successfully saved in the On Hold state.")));

    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please reload the page.")));
    }

  }

  Future<void> submitAudit(String jsonData, BuildContext context) async {
    setLoading(true);

    Map<String, dynamic> data = jsonDecode(jsonData);

    var response = await _appRepository.submitAudit(data);

    if(response!= null){

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The audit details has been submitted to the station successfully.")));

    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please reload the page")));
    }

  }

  Future<void> postAuditData(String jsonData, BuildContext context) async {
    setLoading(true);

    Map<String, dynamic> data = jsonDecode(jsonData);


      var response = await _appRepository.postAuditData(data);
      setLoading(false);

      if (response != null) {
        // print("User pre-validated successfully: $response");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("OTP Validation successful.")));
      } else {
        // print("Error pre-validating user");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error pre-validating user")));
      }
  }


  // Future<void> postAuditData(String jsonData, BuildContext context) async {
  //   setLoading(true);
  //
  //   Map<String, dynamic> data = jsonDecode(jsonData);
  //
  //   try {
  //     var response = await _appRepository.postAuditData(data);
  //     setLoading(false);
  //
  //     if (response != null) {
  //       print("VISHAL888 Data send: $response");
  //       gb.isButtonEnabled_gb = true;
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("VISHAL888 Data send ")));
  //     } else {
  //       print("VISHAL888 Error pre-validating user");
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("VISHAL888 Error sending data")));
  //     }
  //   } catch (e) {
  //     setLoading(false);
  //     print("VISHAL888 Error pre-validating user: $e");
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("VISHAL888 Error sending data")));
  //   }
  // }




}

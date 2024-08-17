import '../response/ERBResponse.dart';
import '../response/all_dashboard_response.dart';
import '../response/performing_stations.dart';

class GlobalVariables {
  // Private constructor
  GlobalVariables._privateConstructor();

  // The single instance of the class
  static final GlobalVariables _instance = GlobalVariables._privateConstructor();

  // Factory constructor to return the same instance every time
  factory GlobalVariables() {
    return _instance;
  }

  // Define global variables
  String globalString = "Hello, World!";
  bool globalBoolean = true;
  bool loaded = false;
  bool isButtonEnabled_gb = false;
  int globalInteger = 42;
  double globalDouble = 3.14;

  // Define a global list variable
  List<Station> topStationList = [];
  List<Station> bottomStationList = [];

  int savedScore_gb = 0;

  Map<String, List<Map<String, dynamic>>>? selection_audit_gb;

  List<TableData>  pendingAuditTable_gb = [];
  List<CompletedAudit> completedAuditList_gb = [];
  String numberOfAuditsCompleted_gb = "";

  String upcomingAuditMessage_gb = "";
  String numberOfAuditsUpcoming_gb = "";

  String auditId_gb = "";
  String completed_auditId_gb = "";

  String numberofERBCONAaudits_gb ="";
  String completedaudits_gb ="";
  String numberofERBTECHaudits_gb = "";
  String numberofHSEaudits_gb = "";
  String numberofFUELaudits_gb = "";

  List<int> globalIntList = [1, 2, 3, 4, 5];

// Add other global variables and methods as needed
}
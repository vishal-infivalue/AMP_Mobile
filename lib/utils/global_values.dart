import '../response/all_dashboard_response.dart';
import '../response/com_audit_list.dart';
import '../response/nc_response.dart';
import '../response/performing_stations.dart';
import '../response/submitted_auditResponse.dart';

class GlobalVariables {
  GlobalVariables._privateConstructor();
  static final GlobalVariables _instance = GlobalVariables._privateConstructor();
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
  List<SubmittedAuditBody>  submittedAuditTable_gb = [];
  List<Data>  ncAuditTable_gb = [];

  int index = 0;
  int ncAudit = 0;

  List<CompletedAudit> completedAuditList_gb = [];
  String numberOfAuditsCompleted_gb = "";
  String upcomingAuditMessage_gb = "";
  String numberOfAuditsUpcoming_gb = "";
  String numberOfAuditsSubmitted_gb = "";

  String schedulableAuditsCount_gb = "";
  List<AuditBody>? schedulableAuditsList_gb = [];

  String auditId_gb = "";
  String completed_auditId_gb = "";
  String completedaudits_gb ="";

  int numberofERBCONAaudits_gb = 0;
  int numberofERBTECHaudits_gb= 0;
  int numberofHSEaudits_gb= 0;
  int numberofFUELaudits_gb=0;


  List<int> globalIntList = [1, 2, 3, 4, 5];
}


// lib/utils/strings.dart
class AppStrings {
  // General
  static const String appName = 'My Flutter App';
  static const String res1 = '''{
  "counter": 2,
  "createdts": "2024-07-05T14:17:45.000+00:00",
  "updatedts": null,
  "createdby": 1002,
  "updatedby": 0,
  "id": 10001,
  "role": 1002,
  "firstname": "gadi",
  "middlename": "G",
  "lastname": "Ranga",
  "email": "gadi.ranga@gmail.com",
  "phone1": "9986078242",
  "phone2": "9513188242",
  "designation": "Cluster Manager",
  "status": "Active"
}''';
  static const String res2 = '''{
    "counter": 1,
    "createdts": "2024-07-05T14:19:13.000+00:00",
    "updatedts": null,
    "createdby": 1002,
    "updatedby": 0,
    "id": 10002,
    "role": 1001,
    "firstname": "Ganesh",
    "middlename": "",
    "lastname": "N",
    "email": "ganesh.n@gmail.com",
    "phone1": "1111222233",
    "phone2": "3333444455",
    "designation": "Station Manager",
    "status": "Active"
}''';
  static const String res3 = '''{
    "timestamp": "2024-07-22T17:23:27.286+00:00",
    "status": 500,
    "error": "Internal Server Error",
    "path": "/audit_management_system-0.0.2-SNAPSHOT/api/login/prevalidateUser"
}''';


  // Profile Screen
  static const String profileScreenTitle = 'Profile Card';
  static const String defaultWelcomeMessage = 'Welcome to Our App!';
  static const String defaultName = 'John Doe';
  static const String defaultDesignation = 'Software Developer';

  // Error Messages
  static const String networkError = 'Failed to load image. Please try again.';

  //dashboardTitles
  static const String auditScore = 'Audit Score & Grade';
  static const String pendingAudit = 'Pending Audits';
  static const String upcomingAudits = 'Upcoming Audits';
  static const String PerformingStation = 'Station Performance';
  static const String StaticPerformingStation = 'Performance of Stations in last 45 days';
  static const String TopPerformAudits = 'Top Performing Stations';
  static const String BottomPerformAudits = 'Under Performing Stations';
  static const String completedAudits = 'Completed Audits';
  static const String ncAgeing = 'Non Compliance Ageing';


  static const String welcomeMessage = 'Welcome to Meru Audit Management Platform';
  static const String profileName = 'Esau Phiri';
  static const String empCode = 'CM4531';
  static const String position = 'Cluster Manager';


  static const String clickUpcomingAudits = 'Click to create a new AdHoc Audit';
  static const String clickCompletedAudits = 'Click to see more details about Audits Conducted';


  static const String auditNote = 'Note : The site must be marked "No" if fails any one of these';


  static const String txtAverage = 'Average of 3 Months';
  static const String txtAverageTop = 'Click to view 3 top performing stations';
  static const String txtAverageBottom = 'Click to view 3 under performing stations';

  static const String txtUpcomingAudits = 'Audits Coming in next 20 days';
  static const String txtCompletedAudits = 'Summary of Audits Completed in Last 15 days';

  static const String clickNCText = 'Click on the bar to see detailed Non Compliance Ageing status';
  static const String titleNCText = 'Number of open NCs';
  static const String ncText = 'NC Aging';

  static const String clickAuditScore = 'Tap to view details';
  static const String auditScoreText = 'Overall Audit Score for your cluster over last 60 days';

}

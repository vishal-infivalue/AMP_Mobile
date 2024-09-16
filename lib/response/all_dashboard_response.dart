
class DashboardAllResponse {
  CompletedAuditResponse completedAuditResponse;
  UpcomingAuditsResponse upcomingAuditsResponse;
  AuditScoreSummary auditScoreSummary;

  DashboardAllResponse({
    required this.completedAuditResponse,
    required this.upcomingAuditsResponse,
    required this.auditScoreSummary,
  });

  factory DashboardAllResponse.fromJson(Map<String, dynamic> json) {
    return DashboardAllResponse(
      completedAuditResponse: CompletedAuditResponse.fromJson(json['completedAuditResponse']),
      upcomingAuditsResponse: UpcomingAuditsResponse.fromJson(json['upcomingAuditsResponse']),
      auditScoreSummary: AuditScoreSummary.fromJson(json['auditScoreSummary']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'completedAuditResponse': completedAuditResponse.toJson(),
      'upcomingAuditsResponse': upcomingAuditsResponse.toJson(),
      'auditScoreSummary': auditScoreSummary.toJson(),
    };
  }
}

class CompletedAuditResponse {
  String completedaudits;
  String numberofaudits;
  String numberofERBCONAaudits;
  String numberofERBTECHaudits;
  String numberofHSEaudits;
  String numberofFUELaudits;
  int userId;
  List<CompletedAudit> completedAuditList;

  CompletedAuditResponse({
    required this.completedaudits,
    required this.numberofaudits,
    required this.numberofERBCONAaudits,
    required this.numberofERBTECHaudits,
    required this.numberofHSEaudits,
    required this.numberofFUELaudits,
    required this.userId,
    required this.completedAuditList,
  });

  factory CompletedAuditResponse.fromJson(Map<String, dynamic> json) {
    return CompletedAuditResponse(
      completedaudits: json['completedaudits'],
      numberofaudits: json['numberofaudits'],
      numberofERBCONAaudits: json['numberofERBCONAaudits'],
      numberofERBTECHaudits: json['numberofERBTECHaudits'],
      numberofHSEaudits: json['numberofHSEaudits'],
      numberofFUELaudits: json['numberofFUELaudits'],
      userId: json['userId'],
      completedAuditList: (json['completedAuditList'] as List)
          .map((i) => CompletedAudit.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'completedaudits': completedaudits,
      'numberofaudits': numberofaudits,
      'numberofERBCONAaudits': numberofERBCONAaudits,
      'numberofERBTECHaudits': numberofERBTECHaudits,
      'numberofHSEaudits': numberofHSEaudits,
      'numberofFUELaudits': numberofFUELaudits,
      'userId': userId,
      'completedAuditList': completedAuditList.map((i) => i.toJson()).toList(),
    };
  }
}

class CompletedAudit {
  String auditid;
  String stationname;
  String audittype;
  String auditname;
  String duedate;
  String lastauditdate;
  String starttime;
  String stationcode;

  CompletedAudit({
    required this.auditid,
    required this.stationname,
    required this.audittype,
    required this.auditname,
    required this.duedate,
    required this.lastauditdate,
    required this.starttime,
    required this.stationcode,
  });

  factory CompletedAudit.fromJson(Map<String, dynamic> json) {
    return CompletedAudit(
      auditid: json['auditid'],
      stationname: json['stationname'],
      audittype: json['audittype'],
      auditname: json['auditname'],
      duedate: json['duedate'],
      lastauditdate: json['lastauditdate'],
      starttime: json['starttime'],
      stationcode: json['stationcode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'auditid': auditid,
      'stationname': stationname,
      'audittype': audittype,
      'auditname': auditname,
      'duedate': duedate,
      'lastauditdate': lastauditdate,
      'starttime': starttime,
      'stationcode': stationcode,
    };
  }
}

class UpcomingAuditsResponse {
  String pendingaudits;
  String numberofaudits;
  List<TableData> tabledata;
  List<ListUpcomingAuditsTableDTO> listUpcomingAuditsTableDTO;

  UpcomingAuditsResponse({
    required this.pendingaudits,
    required this.numberofaudits,
    required this.tabledata,
    required this.listUpcomingAuditsTableDTO,
  });

  factory UpcomingAuditsResponse.fromJson(Map<String, dynamic> json) {
    return UpcomingAuditsResponse(
      pendingaudits: json['pendingaudits'],
      numberofaudits: json['numberofaudits'],
      tabledata: (json['tabledata'] as List)
          .map((i) => TableData.fromJson(i))
          .toList(),
      listUpcomingAuditsTableDTO: (json['listUpcomingAuditsTableDTO'] as List)
          .map((i) => ListUpcomingAuditsTableDTO.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pendingaudits': pendingaudits,
      'numberofaudits': numberofaudits,
      'tabledata': tabledata.map((i) => i.toJson()).toList(),
      'listUpcomingAuditsTableDTO':
      listUpcomingAuditsTableDTO.map((i) => i.toJson()).toList(),
    };
  }
}

class TableData {
  String auditid;
  String stationname;
  String audittype;
  String auditname;
  String duedate;
  String lastauditdate;

  TableData({
    required this.auditid,
    required this.stationname,
    required this.audittype,
    required this.auditname,
    required this.duedate,
    required this.lastauditdate,
  });

  factory TableData.fromJson(Map<String, dynamic> json) {
    return TableData(
      auditid: json['auditid'],
      stationname: json['stationname'],
      audittype: json['audittype'],
      auditname: json['auditname'],
      duedate: json['duedate'],
      lastauditdate: json['lastauditdate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'auditid': auditid,
      'stationname': stationname,
      'audittype': audittype,
      'auditname': auditname,
      'duedate': duedate,
      'lastauditdate': lastauditdate,
    };
  }
}

class ListUpcomingAuditsTableDTO {
  String auditid;
  String stationname;
  String audittype;
  String auditname;
  String duedate;
  String lastauditdate;

  ListUpcomingAuditsTableDTO({
    required this.auditid,
    required this.stationname,
    required this.audittype,
    required this.auditname,
    required this.duedate,
    required this.lastauditdate,
  });

  factory ListUpcomingAuditsTableDTO.fromJson(Map<String, dynamic> json) {
    return ListUpcomingAuditsTableDTO(
      auditid: json['auditid'],
      stationname: json['stationname'],
      audittype: json['audittype'],
      auditname: json['auditname'],
      duedate: json['duedate'],
      lastauditdate: json['lastauditdate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'auditid': auditid,
      'stationname': stationname,
      'audittype': audittype,
      'auditname': auditname,
      'duedate': duedate,
      'lastauditdate': lastauditdate,
    };
  }
}

class AuditScoreSummary {
  final String message;
  final int loginUserId;
  final int totalNC;
  final double avgScore;
  final String grade;
  final String gradeValue;

  // double totalScore;
  // String scoreSummary;

  AuditScoreSummary({
    required this.message,
    required this.loginUserId,
    required this.totalNC,
    required this.avgScore,
    required this.grade,
    required this.gradeValue,
    // required this.totalScore,
    // required this.scoreSummary,
  });

  factory AuditScoreSummary.fromJson(Map<String, dynamic> json) {
    return AuditScoreSummary(
      message: json['message'],
      loginUserId: json['loginUserId'],
      totalNC: json['totalNC'],
      avgScore: json['avgScore'],
      grade: json['grade'],
      gradeValue: json['gradeValue'],
      /*totalScore: json['totalScore'],
      scoreSummary: json['scoreSummary'],*/
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'loginUserId': loginUserId,
      'totalNC': totalNC,
      'avgScore': avgScore,
      'grade': grade,
      'gradeValue': gradeValue,
      // 'totalScore': totalScore,
      // 'scoreSummary': scoreSummary,
    };
  }
}


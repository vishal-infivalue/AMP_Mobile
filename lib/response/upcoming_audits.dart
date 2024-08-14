class Audit {
  final String auditId;
  final String stationName;
  final String auditType;
  final String auditName;
  final String dueDate;
  final String lastAuditDate;

  Audit({
    required this.auditId,
    required this.stationName,
    required this.auditType,
    required this.auditName,
    required this.dueDate,
    required this.lastAuditDate,
  });

  factory Audit.fromJson(Map<String, dynamic> json) {
    return Audit(
      auditId: json['auditid'],
      stationName: json['stationname'],
      auditType: json['audittype'],
      auditName: json['auditname'],
      dueDate: json['duedate'],
      lastAuditDate: json['lastauditdate'],
    );
  }
}

class AuditResponse {
  final String pendingAudits;
  final String numberOfAudits;
  final List<Audit> tableData;

  AuditResponse({
    required this.pendingAudits,
    required this.numberOfAudits,
    required this.tableData,
  });

  factory AuditResponse.fromJson(Map<String, dynamic> json) {
    var list = json['tabledata'] as List;
    List<Audit> audits = list.map((i) => Audit.fromJson(i)).toList();

    return AuditResponse(
      pendingAudits: json['pendingaudits'],
      numberOfAudits: json['numberofaudits'],
      tableData: audits,
    );
  }
}

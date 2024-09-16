class ScoreCardResponse {
  final String heading;
  final String evolScoreSummary;
  final String cumuSummary;
  final String auditId;
  final String stationCode;
  final String stationName;
  final String stationType;
  final String stationManagerId;
  final String stayManagerName;
  final String regionHeadId;
  final String regionHeadName;
  final String auditDate;
  final String clusterManagerId;
  final String clusterManagerName;
  final String auditorId;
  final String? auditorName;
  final String auditStartTime;
  final String? auditEndTime;
  final String overallGrade;
  final String? remarks;
  final List<Section> header;
  final List<Section> subHeader;
  final List<PreviousScore> previousScores;

  ScoreCardResponse({
    required this.heading,
    required this.evolScoreSummary,
    required this.cumuSummary,
    required this.auditId,
    required this.stationCode,
    required this.stationName,
    required this.stationType,
    required this.stationManagerId,
    required this.stayManagerName,
    required this.regionHeadId,
    required this.regionHeadName,
    required this.auditDate,
    required this.clusterManagerId,
    required this.clusterManagerName,
    required this.auditorId,
    this.auditorName,
    required this.auditStartTime,
    this.auditEndTime,
    required this.overallGrade,
    this.remarks,
    required this.header,
    required this.subHeader,
    required this.previousScores,
  });

  factory ScoreCardResponse.fromJson(Map<String, dynamic> json) {
    return ScoreCardResponse(
      heading: json['heading'],
      evolScoreSummary: json['evolscoresummary'],
      cumuSummary: json['cumusummary'],
      auditId: json['audit_id'],
      stationCode: json['stationcode'],
      stationName: json['stationname'],
      stationType: json['stationtype'],
      stationManagerId: json['stationmanagerid'],
      stayManagerName: json['staymanagername'],
      regionHeadId: json['regionheadid'],
      regionHeadName: json['regionheadname'],
      auditDate: json['auditdate'],
      clusterManagerId: json['clustermanagerid'],
      clusterManagerName: json['clustermanagername'],
      auditorId: json['auditorid'],
      auditorName: json['auditorname'],
      auditStartTime: json['auditstarttime'],
      auditEndTime: json['auditendtime'],
      overallGrade: json['overallgrade'],
      remarks: json['remarks'],
      header: List<Section>.from(
          json['header'].map((item) => Section.fromJson(item))),
      subHeader: List<Section>.from(
          json['subheader'].map((item) => Section.fromJson(item))),
      previousScores: List<PreviousScore>.from(
          json['previousscores'].map((item) => PreviousScore.fromJson(item))),
    );
  }
}

class Section {
  final String sectionType;
  final String? sectionName;
  final String ncTotal;
  final String ncPercent;
  final String maxScore;
  final String obtainedScore;
  final String obtainedPercent;
  final String grade;

  Section({
    required this.sectionType,
    this.sectionName,
    required this.ncTotal,
    required this.ncPercent,
    required this.maxScore,
    required this.obtainedScore,
    required this.obtainedPercent,
    required this.grade,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      sectionType: json['sectiontype'],
      sectionName: json['sectionname'],
      ncTotal: json['nctotal'],
      ncPercent: json['ncpercent'],
      maxScore: json['maxscore'],
      obtainedScore: json['obtainedscore'],
      obtainedPercent: json['obtainedpercent'],
      grade: json['grade'],
    );
  }
}

class PreviousScore {
  final String sectionType;
  final String sectionName;
  final String ncTotal;
  final String ncPercent;
  final String? maxScore;
  final String obtainedScore;
  final String obtainedPercent;
  final String grade;

  PreviousScore({
    required this.sectionType,
    required this.sectionName,
    required this.ncTotal,
    required this.ncPercent,
    this.maxScore,
    required this.obtainedScore,
    required this.obtainedPercent,
    required this.grade,
  });

  factory PreviousScore.fromJson(Map<String, dynamic> json) {
    return PreviousScore(
      sectionType: json['sectiontype'],
      sectionName: json['sectionname'],
      ncTotal: json['nctotal'],
      ncPercent: json['ncpercent'],
      maxScore: json['maxscore'],
      obtainedScore: json['obtainedscore'],
      obtainedPercent: json['obtainedpercent'],
      grade: json['grade'],
    );
  }
}

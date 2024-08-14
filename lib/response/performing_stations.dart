class PerformingStationResponse {
  int code;
  String message;
  List<Station> body;

  PerformingStationResponse({required this.code, required this.message, required this.body});

  factory PerformingStationResponse.fromJson(Map<String, dynamic> json) {
    var list = json['body'] as List;
    List<Station> bodyList = list.map((i) => Station.fromJson(i)).toList();

    return PerformingStationResponse(
      code: json['code'],
      message: json['message'],
      body: bodyList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'body': body.map((e) => e.toJson()).toList(),
    };
  }
}

class Station {
  String stationCode;
  double avgScore;
  String grade;
  String gradeValue;
  String managername;

  Station({
    required this.stationCode,
    required this.avgScore,
    required this.grade,
    required this.gradeValue,
    required this.managername,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      stationCode: json['stationCode'],
      avgScore: json['avgScore'],
      grade: json['grade'],
      gradeValue: json['gradeValue'],
      managername: json['managername'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stationCode': stationCode,
      'avgScore': avgScore,
      'grade': grade,
      'gradeValue': gradeValue,
      'managername': managername,
    };
  }
}

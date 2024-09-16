class AuditScoreAverageResponse {
  final String message;
  final int loginUserId;
  final int totalNC;
  final double avgScore;
  final String grade;
  final String gradeValue;

  AuditScoreAverageResponse({
    required this.message,
    required this.loginUserId,
    required this.totalNC,
    required this.avgScore,
    required this.grade,
    required this.gradeValue,
  });

  factory AuditScoreAverageResponse.fromJson(Map<String, dynamic> json) {
    return AuditScoreAverageResponse(
      message: json['message'],
      loginUserId: json['loginUserId'],
      totalNC: json['totalNC'],
      avgScore: json['avgScore'],
      grade: json['grade'],
      gradeValue: json['gradeValue'],
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
    };
  }
}

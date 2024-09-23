class NcDashResponse {
  final String? status;
  final String? result;
  final String? error;
  final AuditData? data;

  NcDashResponse({
    required this.status,
    required this.result,
    required this.error,
    required this.data,
  });

  // Factory constructor for creating an NcDashResponse instance from JSON
  factory NcDashResponse.fromJson(Map<String, dynamic> json) {
    return NcDashResponse(
      status: json['status'] as String?,
      result: json['result'] as String?,
      error: json['error'] as String?,
      data: json['data'] != null ? AuditData.fromJson(json['data']) : null,
    );
  }
}

class AuditData {
  final int? lessThan30;
  final int? lessThan90;
  final int? lessThan180;
  final int? moreThan188;

  AuditData({
    required this.lessThan30,
    required this.lessThan90,
    required this.lessThan180,
    required this.moreThan188,
  });

  // Factory constructor for creating an AuditData instance from JSON
  factory AuditData.fromJson(Map<String, dynamic> json) {
    return AuditData(
      lessThan30: json['lessThan30'] ?? 0,
      lessThan90: json['lessThan90'] ?? 0,
      lessThan180: json['lessThan180'] ?? 0,
      moreThan188: json['morethan188'] ?? 0,
    );
  }
}

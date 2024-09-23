import 'dart:convert';

// Main response class
class ComplianceManagerAuditResponse {
  final int? code;
  final String? message;
  final List<AuditBody>? body;

  ComplianceManagerAuditResponse({
    this.code,
    this.message,
    this.body,
  });

  // Factory method to create an instance of ComplianceManagerAuditResponse from a JSON map
  factory ComplianceManagerAuditResponse.fromJson(Map<String, dynamic> json) {
    return ComplianceManagerAuditResponse(
      code: json['code'] as int?,
      message: json['message'] as String?,
      body: (json['body'] as List<dynamic>?)
          ?.map((item) => AuditBody.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  // Method to convert ComplianceManagerAuditResponse to JSON map
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'body': body?.map((item) => item.toJson()).toList(),
    };
  }
}

// AuditBody class for individual audits
class AuditBody {
  final int? counter;
  final DateTime? createdTs;
  final DateTime? updatedTs;
  final int? createdBy;
  final int? updatedBy;
  final String? stationCode;
  final int? id;
  final String? type;
  final String? state;
  final int? auditor;
  final int? witness;
  final String? status;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? auditorSignature;
  final String? witnessSignature;
  final String? remarks;
  final String? docSubmittedFileName;
  final String? docSubmittedFilePath;
  final String? docUploadedFileName;
  final String? docUploadedFilePath;
  final DateTime? scheduledDate;
  final String? group;
  final DateTime? dueDate;

  AuditBody({
    this.counter,
    this.createdTs,
    this.updatedTs,
    this.createdBy,
    this.updatedBy,
    this.stationCode,
    this.id,
    this.type,
    this.state,
    this.auditor,
    this.witness,
    this.status,
    this.startTime,
    this.endTime,
    this.auditorSignature,
    this.witnessSignature,
    this.remarks,
    this.docSubmittedFileName,
    this.docSubmittedFilePath,
    this.docUploadedFileName,
    this.docUploadedFilePath,
    this.scheduledDate,
    this.group,
    this.dueDate,
  });

  // Factory method to create an instance of AuditBody from a JSON map
  factory AuditBody.fromJson(Map<String, dynamic> json) {
    return AuditBody(
      counter: json['counter'] as int?,
      createdTs: json['createdts'] != null ? DateTime.parse(json['createdts']) : null,
      updatedTs: json['updatedts'] != null ? DateTime.parse(json['updatedts']) : null,
      createdBy: json['createdby'] as int?,
      updatedBy: json['updatedby'] as int?,
      stationCode: json['stationcode'] as String?,
      id: json['id'] as int?,
      type: json['type'] as String?,
      state: json['state'] as String?,
      auditor: json['auditor'] as int?,
      witness: json['witness'] as int?,
      status: json['status'] as String?,
      startTime: json['starttime'] != null ? DateTime.parse(json['starttime']) : null,
      endTime: json['endtime'] != null ? DateTime.parse(json['endtime']) : null,
      auditorSignature: json['auditor_signature'] as String?,
      witnessSignature: json['witness_signature'] as String?,
      remarks: json['remarks'] as String?,
      docSubmittedFileName: json['doc_submitted_filename'] as String?,
      docSubmittedFilePath: json['doc_submitted_filepath'] as String?,
      docUploadedFileName: json['doc_uploaded_filename'] as String?,
      docUploadedFilePath: json['doc_uploaded_filepath'] as String?,
      scheduledDate: json['scheduled_date'] != null ? DateTime.parse(json['scheduled_date']) : null,
      group: json['group'] as String?,
      dueDate: json['due_Date'] != null ? DateTime.parse(json['due_Date']) : null,
    );
  }

  // Method to convert AuditBody to JSON map
  Map<String, dynamic> toJson() {
    return {
      'counter': counter,
      'createdts': createdTs?.toIso8601String(),
      'updatedts': updatedTs?.toIso8601String(),
      'createdby': createdBy,
      'updatedby': updatedBy,
      'stationcode': stationCode,
      'id': id,
      'type': type,
      'state': state,
      'auditor': auditor,
      'witness': witness,
      'status': status,
      'starttime': startTime?.toIso8601String(),
      'endtime': endTime?.toIso8601String(),
      'auditor_signature': auditorSignature,
      'witness_signature': witnessSignature,
      'remarks': remarks,
      'doc_submitted_filename': docSubmittedFileName,
      'doc_submitted_filepath': docSubmittedFilePath,
      'doc_uploaded_filename': docUploadedFileName,
      'doc_uploaded_filepath': docUploadedFilePath,
      'scheduled_date': scheduledDate?.toIso8601String(),
      'group': group,
      'due_Date': dueDate?.toIso8601String(),
    };
  }
}

// Example to convert JSON string to Dart object
void main() {
  String jsonResponse = '''{
    "code": 200,
    "message": "success",
    "body": [
      {
        "counter": 0,
        "createdts": "2024-09-15T04:13:23.304+00:00",
        "updatedts": null,
        "createdby": 0,
        "updatedby": 0,
        "stationcode": "ZP23",
        "id": 0,
        "type": "ERBCONA",
        "state": null,
        "auditor": 0,
        "witness": 0,
        "status": null,
        "starttime": null,
        "endtime": "2024-08-21T04:09:36.000+00:00",
        "auditor_signature": null,
        "witness_signature": null,
        "remarks": null,
        "doc_submitted_filename": null,
        "doc_submitted_filepath": null,
        "doc_uploaded_filename": null,
        "doc_uploaded_filepath": null,
        "scheduled_date": "2024-09-14T18:30:00.000+00:00",
        "group": "Compliance",
        "due_Date": "2024-10-29T18:30:00.000+00:00"
      },
      {
        "counter": 0,
        "createdts": "2024-09-15T04:13:23.304+00:00",
        "updatedts": null,
        "createdby": 0,
        "updatedby": 0,
        "stationcode": "ZP23",
        "id": 0,
        "type": "ERBTECH",
        "state": null,
        "auditor": 0,
        "witness": 0,
        "status": null,
        "starttime": null,
        "endtime": "2024-08-21T04:09:36.000+00:00",
        "auditor_signature": null,
        "witness_signature": null,
        "remarks": null,
        "doc_submitted_filename": null,
        "doc_submitted_filepath": null,
        "doc_uploaded_filename": null,
        "doc_uploaded_filepath": null,
        "scheduled_date": "2024-09-14T18:30:00.000+00:00",
        "group": "Compliance",
        "due_Date": "2024-10-29T18:30:00.000+00:00"
      }
    ]
  }''';

  // Parse the JSON string
  final auditResponse = ComplianceManagerAuditResponse.fromJson(json.decode(jsonResponse));

  // Access and print the values
  print('Code: ${auditResponse.code}');
  print('Message: ${auditResponse.message}');
  print('First audit type: ${auditResponse.body?[0].type}');
}

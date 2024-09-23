class SubmittedAuditResponse {
  final int code;
  final String message;
  final List<SubmittedAuditBody> body;

  SubmittedAuditResponse({
    required this.code,
    required this.message,
    required this.body,
  });

  factory SubmittedAuditResponse.fromJson(Map<String, dynamic> json) {
    return SubmittedAuditResponse(
      code: json['code'],
      message: json['message'],
      body: List<SubmittedAuditBody>.from(json['body'].map((x) => SubmittedAuditBody.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'body': List<dynamic>.from(body.map((x) => x.toJson())),
    };
  }
}

class SubmittedAuditBody {
  final int counter;
  final String createdts;
  final String updatedts;
  final int createdby;
  final int updatedby;
  final String stationcode;
  final int id;
  final String type;
  final String state;
  final int auditor;
  final int witness;
  final String status;
  final String? starttime;
  final String? endtime;
  final String? auditorSignature;
  final String? witnessSignature;
  final String remarks;
  final String docSubmittedFilename;
  final String docSubmittedFilepath;
  final String docUploadedFilename;
  final String docUploadedFilepath;
  final String scheduledDate;
  final String group;
  final String? dueDate;

  SubmittedAuditBody({
    required this.counter,
    required this.createdts,
    required this.updatedts,
    required this.createdby,
    required this.updatedby,
    required this.stationcode,
    required this.id,
    required this.type,
    required this.state,
    required this.auditor,
    required this.witness,
    required this.status,
    this.starttime,
    this.endtime,
    this.auditorSignature,
    this.witnessSignature,
    required this.remarks,
    required this.docSubmittedFilename,
    required this.docSubmittedFilepath,
    required this.docUploadedFilename,
    required this.docUploadedFilepath,
    required this.scheduledDate,
    required this.group,
    this.dueDate,
  });

  factory SubmittedAuditBody.fromJson(Map<String, dynamic> json) {
    return SubmittedAuditBody(
      counter: json['counter'],
      createdts: json['createdts'],
      updatedts: json['updatedts'],
      createdby: json['createdby'],
      updatedby: json['updatedby'],
      stationcode: json['stationcode'],
      id: json['id'],
      type: json['type'],
      state: json['state'],
      auditor: json['auditor'],
      witness: json['witness'],
      status: json['status'],
      starttime: json['starttime'],
      endtime: json['endtime'],
      auditorSignature: json['auditor_signature'],
      witnessSignature: json['witness_signature'],
      remarks: json['remarks'] ?? '',
      docSubmittedFilename: json['doc_submitted_filename'] ?? '',
      docSubmittedFilepath: json['doc_submitted_filepath'] ?? '',
      docUploadedFilename: json['doc_uploaded_filename'] ?? '',
      docUploadedFilepath: json['doc_uploaded_filepath'] ?? '',
      scheduledDate: json['scheduled_date'],
      group: json['group'] ?? '',
      dueDate: json['due_Date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'counter': counter,
      'createdts': createdts,
      'updatedts': updatedts,
      'createdby': createdby,
      'updatedby': updatedby,
      'stationcode': stationcode,
      'id': id,
      'type': type,
      'state': state,
      'auditor': auditor,
      'witness': witness,
      'status': status,
      'starttime': starttime,
      'endtime': endtime,
      'auditor_signature': auditorSignature,
      'witness_signature': witnessSignature,
      'remarks': remarks,
      'doc_submitted_filename': docSubmittedFilename,
      'doc_submitted_filepath': docSubmittedFilepath,
      'doc_uploaded_filename': docUploadedFilename,
      'doc_uploaded_filepath': docUploadedFilepath,
      'scheduled_date': scheduledDate,
      'group': group,
      'due_Date': dueDate,
    };
  }
}

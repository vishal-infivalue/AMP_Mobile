

class AuditDetailsResponse {
  final AuditDetails auditdetails;
  final List<Question> questions;
  final List<Selection> selection;
  final String latitude;
  final String longitude;
  final String transaction;

  AuditDetailsResponse({
    required this.auditdetails,
    required this.questions,
    required this.selection,
    required this.latitude,
    required this.longitude,
    required this.transaction,
  });

  factory AuditDetailsResponse.fromJson(Map<String, dynamic> json) {
    return AuditDetailsResponse(
      auditdetails: AuditDetails.fromJson(json['auditdetails'] ?? {}),
      questions: (json['questions'] as List?)
              ?.map((i) => Question.fromJson(i))
              .toList() ??
          [],
      selection: (json['selection'] as List?)
              ?.map((i) => Selection.fromJson(i))
              .toList() ??
          [],
      latitude: json['latitude']?.toString() ?? '',
      longitude: json['longitude']?.toString() ?? '',
      transaction: json['transaction']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'auditdetails': auditdetails.toJson(),
      'questions': questions.map((i) => i.toJson()).toList(),
      'selection': selection.map((i) => i.toJson()).toList(),
      'latitude': latitude,
      'longitude': longitude,
      'transaction': transaction,
    };
  }
}

class AuditDetails {
  final int counter;
  final String createdts;
  final String? updatedts;
  final int createdby;
  final int updatedby;
  final String stationcode;
  final int id;
  final String type;
  final String state;
  final int auditor;
  final int witness;
  final String status;
  final String starttime;
  final String endtime;
  final String? auditorSignature;
  final String? witnessSignature;
  final String? remarks;
  final String? docSubmittedFilename;
  final String? docSubmittedFilepath;
  final String? docUploadedFilename;
  final String? docUploadedFilepath;
  final String scheduledDate;
  final String group;

  AuditDetails({
    required this.counter,
    required this.createdts,
    this.updatedts,
    required this.createdby,
    required this.updatedby,
    required this.stationcode,
    required this.id,
    required this.type,
    required this.state,
    required this.auditor,
    required this.witness,
    required this.status,
    required this.starttime,
    required this.endtime,
    this.auditorSignature,
    this.witnessSignature,
    this.remarks,
    this.docSubmittedFilename,
    this.docSubmittedFilepath,
    this.docUploadedFilename,
    this.docUploadedFilepath,
    required this.scheduledDate,
    required this.group,
  });

  factory AuditDetails.fromJson(Map<String, dynamic> json) {
    return AuditDetails(
      counter: json['counter'] ?? 0,
      // Default value for counter
      createdts: json['createdts'] ?? '',
      updatedts: json['updatedts'],
      createdby: json['createdby'] ?? 0,
      // Default value for createdby
      updatedby: json['updatedby'] ?? 0,
      // Default value for updatedby
      stationcode: json['stationcode'] ?? '',
      id: json['id'] ?? 0,
      // Default value for id
      type: json['type'] ?? '',
      state: json['state'] ?? '',
      auditor: json['auditor'] ?? 0,
      // Default value for auditor
      witness: json['witness'] ?? 0,
      // Default value for witness
      status: json['status'] ?? '',
      starttime: json['starttime'] ?? '',
      endtime: json['endtime'] ?? '',
      auditorSignature: json['auditor_signature'],
      witnessSignature: json['witness_signature'],
      remarks: json['remarks'],
      docSubmittedFilename: json['doc_submitted_filename'],
      docSubmittedFilepath: json['doc_submitted_filepath'],
      docUploadedFilename: json['doc_uploaded_filename'],
      docUploadedFilepath: json['doc_uploaded_filepath'],
      scheduledDate: json['scheduled_date'] ?? '',
      group: json['group'] ?? '',
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
    };
  }
}

class Question {
  final int counter;
  final int createdby;
  final String audittype;
  final int header;
  final int subheader;
  final int additionalnotes;
  final int question;
  final String description;
  final int points;
  final String? savedscore;
  final String? savedremark;
  final String? savedcomment;

  Question({
    required this.counter,
    required this.createdby,
    required this.audittype,
    required this.header,
    required this.subheader,
    required this.additionalnotes,
    required this.question,
    required this.description,
    required this.points,
    this.savedscore,
    this.savedremark,
    this.savedcomment,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      counter: json['counter'] ?? 0,
      // Default value for counter
      createdby: json['createdby'] ?? 0,
      // Default value for createdby
      audittype: json['audittype'] ?? '',
      header: json['header'] ?? 0,
      // Default value for header
      subheader: json['subheader'] ?? 0,
      // Default value for subheader
      additionalnotes: json['additionalnotes'] ?? 0,
      // Default value for additionalnotes
      question: json['question'] ?? 0,
      // Default value for question
      description: json['description'] ?? '',
      points: json['points'] ?? 0,
      // Default value for points
      savedscore: json['savedscore'] as String?,
      savedremark: json['savedremark'] as String?,
      savedcomment: json['savedcomment'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'counter': counter,
      'createdby': createdby,
      'audittype': audittype,
      'header': header,
      'subheader': subheader,
      'additionalnotes': additionalnotes,
      'question': question,
      'description': description,
      'points': points,
      'savedscore': savedscore,
      'savedremark': savedremark,
      'savedcomment': savedcomment,
    };
  }
}

class Selection {
  final int counter;
  final int createdby;
  final String type;
  final String value;
  final int? placeholder_1;
  final int? placeholder_2;
  final int? placeholder_3;

  Selection({
    required this.counter,
    required this.createdby,
    required this.type,
    required this.value,
    this.placeholder_1,
    this.placeholder_2,
    this.placeholder_3,
  });

  factory Selection.fromJson(Map<String, dynamic> json) {
    return Selection(
      counter: json['counter'] ?? 0,
      // Default value for counter
      createdby: json['createdby'] ?? 0,
      // Default value for createdby
      type: json['type'] ?? '',
      value: json['value'] ?? '',
      placeholder_1:
          json['placeholder_1'] != null ? json['placeholder_1'] as int? : null,
      placeholder_2:
          json['placeholder_2'] != null ? json['placeholder_2'] as int? : null,
      placeholder_3:
          json['placeholder_3'] != null ? json['placeholder_3'] as int? : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'counter': counter,
      'createdby': createdby,
      'type': type,
      'value': value,
      'placeholder_1': placeholder_1,
      'placeholder_2': placeholder_2,
      'placeholder_3': placeholder_3,
    };
  }
}

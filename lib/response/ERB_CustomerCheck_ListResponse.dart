/*
class ERBCustomerCheckListResponse {
  ERBCustomerCheckListResponse({
    required this.auditDetails,
    required this.questions,
    required this.selection,
    required this.latitude,
    required this.longitude,
    required this.listERBAuditMappingDTO,
    required this.oAuditMasterDTO,
    required this.listUtilDTO,
  });

  late final AuditDetails auditDetails;
  late final List<Questions> questions;
  late final List<Selection> selection;
  late final String latitude;
  late final String longitude;
  late final List<ListERBAuditMappingDTO> listERBAuditMappingDTO;
  late final OAuditMasterDTO oAuditMasterDTO;
  late final List<ListUtilDTO> listUtilDTO;

  ERBCustomerCheckListResponse.fromJson(Map<String, dynamic> json) {
    auditDetails = AuditDetails.fromJson(json['auditDetails']);
    questions = List.from(json['questions']).map((e) => Questions.fromJson(e)).toList();
    selection = List.from(json['selection']).map((e) => Selection.fromJson(e)).toList();
    latitude = json['latitude'];
    longitude = json['longitude'];
    listERBAuditMappingDTO = List.from(json['listERBAuditMappingDTO']).map((e) => ListERBAuditMappingDTO.fromJson(e)).toList();
    oAuditMasterDTO = OAuditMasterDTO.fromJson(json['oAuditMasterDTO']);
    listUtilDTO = List.from(json['listUtilDTO']).map((e) => ListUtilDTO.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['auditDetails'] = auditDetails.toJson();
    data['questions'] = questions.map((e) => e.toJson()).toList();
    data['selection'] = selection.map((e) => e.toJson()).toList();
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['listERBAuditMappingDTO'] = listERBAuditMappingDTO.map((e) => e.toJson()).toList();
    data['oAuditMasterDTO'] = oAuditMasterDTO.toJson();
    data['listUtilDTO'] = listUtilDTO.map((e) => e.toJson()).toList();
    return data;
  }
}

class AuditDetails {
  AuditDetails({
    required this.counter,
    required this.createdTs,
    this.updatedTs,
    required this.createdBy,
    required this.updatedBy,
    required this.stationCode,
    required this.id,
    required this.type,
    required this.state,
    required this.auditor,
    required this.witness,
    required this.status,
    required this.startTime,
    this.endTime,
    this.auditorSignature,
    this.witnessSignature,
    this.remarks,
    this.docSubmittedFileName,
    this.docSubmittedFilePath,
    this.docUploadedFileName,
    this.docUploadedFilePath,
    required this.scheduledDate,
    required this.group,
  });

  late final int counter;
  late final String createdTs;
  late final String? updatedTs;
  late final int createdBy;
  late final int updatedBy;
  late final String stationCode;
  late final int id;
  late final String type;
  late final String state;
  late final int auditor;
  late final int witness;
  late final String status;
  late final String startTime;
  late final String? endTime;
  late final String? auditorSignature;
  late final String? witnessSignature;
  late final String? remarks;
  late final String? docSubmittedFileName;
  late final String? docSubmittedFilePath;
  late final String? docUploadedFileName;
  late final String? docUploadedFilePath;
  late final String scheduledDate;
  late final String group;

  AuditDetails.fromJson(Map<String, dynamic> json) {
    counter = json['counter'];
    createdTs = json['createdTs'];
    updatedTs = json['updatedTs'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    stationCode = json['stationCode'];
    id = json['id'];
    type = json['type'];
    state = json['state'];
    auditor = json['auditor'];
    witness = json['witness'];
    status = json['status'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    auditorSignature = json['auditorSignature'];
    witnessSignature = json['witnessSignature'];
    remarks = json['remarks'];
    docSubmittedFileName = json['docSubmittedFileName'];
    docSubmittedFilePath = json['docSubmittedFilePath'];
    docUploadedFileName = json['docUploadedFileName'];
    docUploadedFilePath = json['docUploadedFilePath'];
    scheduledDate = json['scheduledDate'];
    group = json['group'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['counter'] = counter;
    data['createdTs'] = createdTs;
    data['updatedTs'] = updatedTs;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['stationCode'] = stationCode;
    data['id'] = id;
    data['type'] = type;
    data['state'] = state;
    data['auditor'] = auditor;
    data['witness'] = witness;
    data['status'] = status;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['auditorSignature'] = auditorSignature;
    data['witnessSignature'] = witnessSignature;
    data['remarks'] = remarks;
    data['docSubmittedFileName'] = docSubmittedFileName;
    data['docSubmittedFilePath'] = docSubmittedFilePath;
    data['docUploadedFileName'] = docUploadedFileName;
    data['docUploadedFilePath'] = docUploadedFilePath;
    data['scheduledDate'] = scheduledDate;
    data['group'] = group;
    return data;
  }
}

class Questions {
  Questions({
    required this.counter,
    required this.createdBy,
    required this.auditType,
    required this.header,
    required this.subheader,
    required this.additionalNotes,
    required this.question,
    required this.description,
    required this.points,
  });

  late final int counter;
  late final int createdBy;
  late final String auditType;
  late final int header;
  late final int subheader;
  late final int additionalNotes;
  late final int question;
  late final String description;
  late final int points;

  Questions.fromJson(Map<String, dynamic> json) {
    counter = json['counter'];
    createdBy = json['createdBy'];
    auditType = json['auditType'];
    header = json['header'];
    subheader = json['subheader'];
    additionalNotes = json['additionalNotes'];
    question = json['question'];
    description = json['description'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['counter'] = counter;
    data['createdBy'] = createdBy;
    data['auditType'] = auditType;
    data['header'] = header;
    data['subheader'] = subheader;
    data['additionalNotes'] = additionalNotes;
    data['question'] = question;
    data['description'] = description;
    data['points'] = points;
    return data;
  }
}

class Selection {
  Selection({
    required this.counter,
    required this.createdBy,
    required this.type,
    required this.value,
    required this.placeholder1,
    this.placeholder2,
    this.placeholder3,
  });

  late final int counter;
  late final int createdBy;
  late final String type;
  late final String value;
  late final String placeholder1;
  late final String? placeholder2;
  late final String? placeholder3;

  Selection.fromJson(Map<String, dynamic> json) {
    counter = json['counter'];
    createdBy = json['createdBy'];
    type = json['type'];
    value = json['value'];
    placeholder1 = json['placeholder1'];
    placeholder2 = json['placeholder2'];
    placeholder3 = json['placeholder3'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['counter'] = counter;
    data['createdBy'] = createdBy;
    data['type'] = type;
    data['value'] = value;
    data['placeholder1'] = placeholder1;
    data['placeholder2'] = placeholder2;
    data['placeholder3'] = placeholder3;
    return data;
  }
}

class ListERBAuditMappingDTO {
  ListERBAuditMappingDTO({
    required this.counter,
    required this.createdBy,
    required this.auditType,
    required this.header,
    required this.subheader,
    required this.additionalNotes,
    required this.question,
    required this.description,
    required this.points,
  });

  late final int counter;
  late final int createdBy;
  late final String auditType;
  late final int header;
  late final int subheader;
  late final int additionalNotes;
  late final int question;
  late final String description;
  late final int points;

  ListERBAuditMappingDTO.fromJson(Map<String, dynamic> json) {
    counter = json['counter'];
    createdBy = json['createdBy'];
    auditType = json['auditType'];
    header = json['header'];
    subheader = json['subheader'];
    additionalNotes = json['additionalNotes'];
    question = json['question'];
    description = json['description'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['counter'] = counter;
    data['createdBy'] = createdBy;
    data['auditType'] = auditType;
    data['header'] = header;
    data['subheader'] = subheader;
    data['additionalNotes'] = additionalNotes;
    data['question'] = question;
    data['description'] = description;
    data['points'] = points;
    return data;
  }
}

class OAuditMasterDTO {
  OAuditMasterDTO({
    required this.counter,
    required this.createdTs,
    this.updatedTs,
    required this.createdBy,
    required this.updatedBy,
    required this.stationCode,
    required this.id,
    required this.type,
    required this.state,
    required this.auditor,
    required this.witness,
    required this.status,
    required this.startTime,
    this.endTime,
    this.auditorSignature,
    this.witnessSignature,
    this.remarks,
    this.docSubmittedFileName,
    this.docSubmittedFilePath,
    this.docUploadedFileName,
    this.docUploadedFilePath,
    required this.scheduledDate,
    required this.group,
  });

  late final int counter;
  late final String createdTs;
  late final String? updatedTs;
  late final int createdBy;
  late final int updatedBy;
  late final String stationCode;
  late final int id;
  late final String type;
  late final String state;
  late final int auditor;
  late final int witness;
  late final String status;
  late final String startTime;
  late final String? endTime;
  late final String? auditorSignature;
  late final String? witnessSignature;
  late final String? remarks;
  late final String? docSubmittedFileName;
  late final String? docSubmittedFilePath;
  late final String? docUploadedFileName;
  late final String? docUploadedFilePath;
  late final String scheduledDate;
  late final String group;

  OAuditMasterDTO.fromJson(Map<String, dynamic> json) {
    counter = json['counter'];
    createdTs = json['createdTs'];
    updatedTs = json['updatedTs'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    stationCode = json['stationCode'];
    id = json['id'];
    type = json['type'];
    state = json['state'];
    auditor = json['auditor'];
    witness = json['witness'];
    status = json['status'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    auditorSignature = json['auditorSignature'];
    witnessSignature = json['witnessSignature'];
    remarks = json['remarks'];
    docSubmittedFileName = json['docSubmittedFileName'];
    docSubmittedFilePath = json['docSubmittedFilePath'];
    docUploadedFileName = json['docUploadedFileName'];
    docUploadedFilePath = json['docUploadedFilePath'];
    scheduledDate = json['scheduledDate'];
    group = json['group'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['counter'] = counter;
    data['createdTs'] = createdTs;
    data['updatedTs'] = updatedTs;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['stationCode'] = stationCode;
    data['id'] = id;
    data['type'] = type;
    data['state'] = state;
    data['auditor'] = auditor;
    data['witness'] = witness;
    data['status'] = status;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['auditorSignature'] = auditorSignature;
    data['witnessSignature'] = witnessSignature;
    data['remarks'] = remarks;
    data['docSubmittedFileName'] = docSubmittedFileName;
    data['docSubmittedFilePath'] = docSubmittedFilePath;
    data['docUploadedFileName'] = docUploadedFileName;
    data['docUploadedFilePath'] = docUploadedFilePath;
    data['scheduledDate'] = scheduledDate;
    data['group'] = group;
    return data;
  }
}

class ListUtilDTO {
  ListUtilDTO({
    required this.counter,
    required this.createdBy,
    required this.type,
    required this.value,
    required this.placeholder1,
    this.placeholder2,
    this.placeholder3,
  });

  late final int counter;
  late final int createdBy;
  late final String type;
  late final String value;
  late final String placeholder1;
  late final String? placeholder2;
  late final String? placeholder3;

  ListUtilDTO.fromJson(Map<String, dynamic> json) {
    counter = json['counter'];
    createdBy = json['createdBy'];
    type = json['type'];
    value = json['value'];
    placeholder1 = json['placeholder1'];
    placeholder2 = json['placeholder2'];
    placeholder3 = json['placeholder3'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['counter'] = counter;
    data['createdBy'] = createdBy;
    data['type'] = type;
    data['value'] = value;
    data['placeholder1'] = placeholder1;
    data['placeholder2'] = placeholder2;
    data['placeholder3'] = placeholder3;
    return data;
  }
}
*/

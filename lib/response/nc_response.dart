class NcResponse {
  String? status;
  String? result;
  String? error;
  List<Data>? data;

  NcResponse({this.status, this.result, this.error, this.data});

  NcResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = json['result'];
    error = json['error'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['result'] = this.result;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? status;
  String? type;
  AssignedTo? assignedTo;
  Audits? audit;
  Stations? station;
  Cluster? cluster;
  AssignedTo? auditor;
  AssignedTo? clusterManager;
  AssignedTo? stationManager;
  String? comments;
  String? image;
  Zoho? zoho;
  Info? info;
  String? createdTS;
  String? updatedTS;
  int? updatedBy;
  int? createdBy;

  Data(
      {this.id,
        this.status,
        this.type,
        this.assignedTo,
        this.audit,
        this.station,
        this.cluster,
        this.auditor,
        this.clusterManager,
        this.stationManager,
        this.comments,
        this.image,
        this.zoho,
        this.info,
        this.createdTS,
        this.updatedTS,
        this.updatedBy,
        this.createdBy});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    type = json['type'];
    assignedTo = json['assignedTo'] != null
        ? new AssignedTo.fromJson(json['assignedTo'])
        : null;
    audit = json['audit'] != null ? new Audits.fromJson(json['audit']) : null;
    station =
    json['station'] != null ? new Stations.fromJson(json['station']) : null;
    cluster =
    json['cluster'] != null ? new Cluster.fromJson(json['cluster']) : null;
    auditor = json['auditor'] != null
        ? new AssignedTo.fromJson(json['auditor'])
        : null;
    clusterManager = json['clusterManager'] != null
        ? new AssignedTo.fromJson(json['clusterManager'])
        : null;
    stationManager = json['stationManager'] != null
        ? new AssignedTo.fromJson(json['stationManager'])
        : null;
    comments = json['comments'];
    image = json['image'];
    zoho = json['zoho'] != null ? new Zoho.fromJson(json['zoho']) : null;
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    createdTS = json['createdTS'];
    updatedTS = json['updatedTS'];
    updatedBy = json['updatedBy'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['type'] = this.type;
    if (this.assignedTo != null) {
      data['assignedTo'] = this.assignedTo!.toJson();
    }
    if (this.audit != null) {
      data['audit'] = this.audit!.toJson();
    }
    if (this.station != null) {
      data['station'] = this.station!.toJson();
    }
    if (this.cluster != null) {
      data['cluster'] = this.cluster!.toJson();
    }
    if (this.auditor != null) {
      data['auditor'] = this.auditor!.toJson();
    }
    if (this.clusterManager != null) {
      data['clusterManager'] = this.clusterManager!.toJson();
    }
    if (this.stationManager != null) {
      data['stationManager'] = this.stationManager!.toJson();
    }
    data['comments'] = this.comments;
    data['image'] = this.image;
    if (this.zoho != null) {
      data['zoho'] = this.zoho!.toJson();
    }
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    data['createdTS'] = this.createdTS;
    data['updatedTS'] = this.updatedTS;
    data['updatedBy'] = this.updatedBy;
    data['createdBy'] = this.createdBy;
    return data;
  }
}

class AssignedTo {
  int? counter;
  String? createdts;
  String? updatedts;
  int? createdby;
  int? updatedby;
  int? id;
  int? role;
  String? firstname;
  String? middlename;
  String? lastname;
  String? email;
  String? phone1;
  String? phone2;
  String? designation;
  String? status;

  AssignedTo(
      {this.counter,
        this.createdts,
        this.updatedts,
        this.createdby,
        this.updatedby,
        this.id,
        this.role,
        this.firstname,
        this.middlename,
        this.lastname,
        this.email,
        this.phone1,
        this.phone2,
        this.designation,
        this.status});

  AssignedTo.fromJson(Map<String, dynamic> json) {
    counter = json['counter'];
    createdts = json['createdts'];
    updatedts = json['updatedts'];
    createdby = json['createdby'];
    updatedby = json['updatedby'];
    id = json['id'];
    role = json['role'];
    firstname = json['firstname'];
    middlename = json['middlename'];
    lastname = json['lastname'];
    email = json['email'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    designation = json['designation'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counter'] = this.counter;
    data['createdts'] = this.createdts;
    data['updatedts'] = this.updatedts;
    data['createdby'] = this.createdby;
    data['updatedby'] = this.updatedby;
    data['id'] = this.id;
    data['role'] = this.role;
    data['firstname'] = this.firstname;
    data['middlename'] = this.middlename;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['phone1'] = this.phone1;
    data['phone2'] = this.phone2;
    data['designation'] = this.designation;
    data['status'] = this.status;
    return data;
  }
}

class Audits {
  int? counter;
  String? createdts;
  String? updatedts;
  int? createdby;
  int? updatedby;
  String? stationcode;
  int? id;
  String? type;
  String? state;
  int? auditor;
  int? witness;
  String? status;
  String? starttime;
  String? endtime;
  String? auditorSignature;
  String? witnessSignature;
  String? remarks;
  String? docSubmittedFilename;
  String? docSubmittedFilepath;
  String? docUploadedFilename;
  String? docUploadedFilepath;
  String? scheduledDate;
  String? group;

  Audits(
      {this.counter,
        this.createdts,
        this.updatedts,
        this.createdby,
        this.updatedby,
        this.stationcode,
        this.id,
        this.type,
        this.state,
        this.auditor,
        this.witness,
        this.status,
        this.starttime,
        this.endtime,
        this.auditorSignature,
        this.witnessSignature,
        this.remarks,
        this.docSubmittedFilename,
        this.docSubmittedFilepath,
        this.docUploadedFilename,
        this.docUploadedFilepath,
        this.scheduledDate,
        this.group});

  Audits.fromJson(Map<String, dynamic> json) {
    counter = json['counter'];
    createdts = json['createdts'];
    updatedts = json['updatedts'];
    createdby = json['createdby'];
    updatedby = json['updatedby'];
    stationcode = json['stationcode'];
    id = json['id'];
    type = json['type'];
    state = json['state'];
    auditor = json['auditor'];
    witness = json['witness'];
    status = json['status'];
    starttime = json['starttime'];
    endtime = json['endtime'];
    auditorSignature = json['auditor_signature'];
    witnessSignature = json['witness_signature'];
    remarks = json['remarks'];
    docSubmittedFilename = json['doc_submitted_filename'];
    docSubmittedFilepath = json['doc_submitted_filepath'];
    docUploadedFilename = json['doc_uploaded_filename'];
    docUploadedFilepath = json['doc_uploaded_filepath'];
    scheduledDate = json['scheduled_date'];
    group = json['group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counter'] = this.counter;
    data['createdts'] = this.createdts;
    data['updatedts'] = this.updatedts;
    data['createdby'] = this.createdby;
    data['updatedby'] = this.updatedby;
    data['stationcode'] = this.stationcode;
    data['id'] = this.id;
    data['type'] = this.type;
    data['state'] = this.state;
    data['auditor'] = this.auditor;
    data['witness'] = this.witness;
    data['status'] = this.status;
    data['starttime'] = this.starttime;
    data['endtime'] = this.endtime;
    data['auditor_signature'] = this.auditorSignature;
    data['witness_signature'] = this.witnessSignature;
    data['remarks'] = this.remarks;
    data['doc_submitted_filename'] = this.docSubmittedFilename;
    data['doc_submitted_filepath'] = this.docSubmittedFilepath;
    data['doc_uploaded_filename'] = this.docUploadedFilename;
    data['doc_uploaded_filepath'] = this.docUploadedFilepath;
    data['scheduled_date'] = this.scheduledDate;
    data['group'] = this.group;
    return data;
  }
}

class Stations {
  int? counter;
  String? createdts;
  String? updatedts;
  int? createdby;
  int? updatedby;
  String? stationcode;
  String? stationname;
  String? stationtype;
  String? province;
  String? email1;
  String? email2;
  String? phone1;
  String? phone2;
  String? managerId;
  String? lati;
  String? longi;
  String? geofence;
  int? clusterid;
  String? status;

  Stations(
      {this.counter,
        this.createdts,
        this.updatedts,
        this.createdby,
        this.updatedby,
        this.stationcode,
        this.stationname,
        this.stationtype,
        this.province,
        this.email1,
        this.email2,
        this.phone1,
        this.phone2,
        this.managerId,
        this.lati,
        this.longi,
        this.geofence,
        this.clusterid,
        this.status});

  Stations.fromJson(Map<String, dynamic> json) {
    counter = json['counter'];
    createdts = json['createdts'];
    updatedts = json['updatedts'];
    createdby = json['createdby'];
    updatedby = json['updatedby'];
    stationcode = json['stationcode'];
    stationname = json['stationname'];
    stationtype = json['stationtype'];
    province = json['province'];
    email1 = json['email1'];
    email2 = json['email2'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    managerId = json['manager_id'];
    lati = json['lati'];
    longi = json['longi'];
    geofence = json['geofence'];
    clusterid = json['clusterid'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counter'] = this.counter;
    data['createdts'] = this.createdts;
    data['updatedts'] = this.updatedts;
    data['createdby'] = this.createdby;
    data['updatedby'] = this.updatedby;
    data['stationcode'] = this.stationcode;
    data['stationname'] = this.stationname;
    data['stationtype'] = this.stationtype;
    data['province'] = this.province;
    data['email1'] = this.email1;
    data['email2'] = this.email2;
    data['phone1'] = this.phone1;
    data['phone2'] = this.phone2;
    data['manager_id'] = this.managerId;
    data['lati'] = this.lati;
    data['longi'] = this.longi;
    data['geofence'] = this.geofence;
    data['clusterid'] = this.clusterid;
    data['status'] = this.status;
    return data;
  }
}

class Cluster {
  int? counter;
  String? createdts;
  String? updatedts;
  int? createdby;
  int? updatedby;
  int? id;
  String? name;
  String? shortname;
  String? managerid;
  String? status;
  String? regioncode;

  Cluster(
      {this.counter,
        this.createdts,
        this.updatedts,
        this.createdby,
        this.updatedby,
        this.id,
        this.name,
        this.shortname,
        this.managerid,
        this.status,
        this.regioncode});

  Cluster.fromJson(Map<String, dynamic> json) {
    counter = json['counter'];
    createdts = json['createdts'];
    updatedts = json['updatedts'];
    createdby = json['createdby'];
    updatedby = json['updatedby'];
    id = json['id'];
    name = json['name'];
    shortname = json['shortname'];
    managerid = json['managerid'];
    status = json['status'];
    regioncode = json['regioncode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counter'] = this.counter;
    data['createdts'] = this.createdts;
    data['updatedts'] = this.updatedts;
    data['createdby'] = this.createdby;
    data['updatedby'] = this.updatedby;
    data['id'] = this.id;
    data['name'] = this.name;
    data['shortname'] = this.shortname;
    data['managerid'] = this.managerid;
    data['status'] = this.status;
    data['regioncode'] = this.regioncode;
    return data;
  }
}

class Zoho {
  String? ticketId;
  String? status;
  String? assignedTo;

  Zoho({this.ticketId, this.status, this.assignedTo});

  Zoho.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticketId'];
    status = json['status'];
    assignedTo = json['assignedTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticketId'] = this.ticketId;
    data['status'] = this.status;
    data['assignedTo'] = this.assignedTo;
    return data;
  }
}

class Info {
  int? counter;
  String? createdts;
  String? updatedts;
  int? createdby;
  int? updatedby;
  int? auditId;
  int? totalscore;
  int? header;
  int? subheader;
  int? additionalnotes;
  int? question;
  int? obtainedScore;
  String? remarks;
  String? comments;
  String? picSubmittedFilename;
  String? picSubmittedFilepath;
  String? image;

  Info(
      {this.counter,
        this.createdts,
        this.updatedts,
        this.createdby,
        this.updatedby,
        this.auditId,
        this.totalscore,
        this.header,
        this.subheader,
        this.additionalnotes,
        this.question,
        this.obtainedScore,
        this.remarks,
        this.comments,
        this.picSubmittedFilename,
        this.picSubmittedFilepath,
        this.image});

  Info.fromJson(Map<String, dynamic> json) {
    counter = json['counter'];
    createdts = json['createdts'];
    updatedts = json['updatedts'];
    createdby = json['createdby'];
    updatedby = json['updatedby'];
    auditId = json['audit_id'];
    totalscore = json['totalscore'];
    header = json['header'];
    subheader = json['subheader'];
    additionalnotes = json['additionalnotes'];
    question = json['question'];
    obtainedScore = json['obtained_score'];
    remarks = json['remarks'];
    comments = json['comments'];
    picSubmittedFilename = json['pic_submitted_filename'];
    picSubmittedFilepath = json['pic_submitted_filepath'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counter'] = this.counter;
    data['createdts'] = this.createdts;
    data['updatedts'] = this.updatedts;
    data['createdby'] = this.createdby;
    data['updatedby'] = this.updatedby;
    data['audit_id'] = this.auditId;
    data['totalscore'] = this.totalscore;
    data['header'] = this.header;
    data['subheader'] = this.subheader;
    data['additionalnotes'] = this.additionalnotes;
    data['question'] = this.question;
    data['obtained_score'] = this.obtainedScore;
    data['remarks'] = this.remarks;
    data['comments'] = this.comments;
    data['pic_submitted_filename'] = this.picSubmittedFilename;
    data['pic_submitted_filepath'] = this.picSubmittedFilepath;
    data['image'] = this.image;
    return data;
  }
}
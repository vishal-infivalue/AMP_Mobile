class AllAuditors {
  String? status;
  String? result;
  String? error;
  List<Auditor>? data;

  AllAuditors({this.status, this.result, this.error, this.data});

  factory AllAuditors.fromJson(Map<String, dynamic> json) {
    return AllAuditors(
      status: json['status'],
      result: json['result'],
      error: json['error'],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => Auditor.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'result': result,
      'error': error,
      'data': data?.map((auditor) => auditor.toJson()).toList(),
    };
  }
}

class Auditor {
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
  String? countrycode;
  String? roleName;
  String? roleShortName;

  Auditor({
    this.counter,
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
    this.status,
    this.countrycode,
    this.roleName,
    this.roleShortName,
  });

  factory Auditor.fromJson(Map<String, dynamic> json) {
    return Auditor(
      counter: json['counter'],
      createdts: json['createdts'],
      updatedts: json['updatedts'],
      createdby: json['createdby'],
      updatedby: json['updatedby'],
      id: json['id'],
      role: json['role'],
      firstname: json['firstname'],
      middlename: json['middlename'],
      lastname: json['lastname'],
      email: json['email'],
      phone1: json['phone1'],
      phone2: json['phone2'],
      designation: json['designation'],
      status: json['status'],
      countrycode: json['countrycode'],
      roleName: json['roleName'],
      roleShortName: json['roleShortName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'counter': counter,
      'createdts': createdts,
      'updatedts': updatedts,
      'createdby': createdby,
      'updatedby': updatedby,
      'id': id,
      'role': role,
      'firstname': firstname,
      'middlename': middlename,
      'lastname': lastname,
      'email': email,
      'phone1': phone1,
      'phone2': phone2,
      'designation': designation,
      'status': status,
      'countrycode': countrycode,
      'roleName': roleName,
      'roleShortName': roleShortName,
    };
  }
}

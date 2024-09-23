import 'dart:convert';

class UserResponse {
  int counter;
  DateTime createdTs;
  DateTime? updatedTs;
  int createdBy;
  int updatedBy;
  int id;
  int role;
  String firstName;
  String middleName;
  String lastName;
  String email;
  String phone1;
  String phone2;
  String designation;
  String status;

  UserResponse({
    required this.counter,
    required this.createdTs,
    this.updatedTs,
    required this.createdBy,
    required this.updatedBy,
    required this.id,
    required this.role,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.phone1,
    required this.phone2,
    required this.designation,
    required this.status,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      counter: json['counter'],
      createdTs: DateTime.parse(json['createdts']),
      updatedTs: json['updatedts'] != null ? DateTime.parse(json['updatedts']) : null,
      createdBy: json['createdby'],
      updatedBy: json['updatedby'],
      id: json['id'],
      role: json['role'],
      firstName: json['firstname'] ??"",
      middleName: json['middlename']??"",
      lastName: json['lastname']??"",
      email: json['email']??"",
      phone1: json['phone1']??"",
      phone2: json['phone2']??"",
      designation: json['designation'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'counter': counter,
      'createdts': createdTs.toIso8601String(),
      'updatedts': updatedTs?.toIso8601String(),
      'createdby': createdBy,
      'updatedby': updatedBy,
      'id': id,
      'role': role,
      'firstname': firstName,
      'middlename': middleName,
      'lastname': lastName,
      'email': email,
      'phone1': phone1,
      'phone2': phone2,
      'designation': designation,
      'status': status,
    };
  }
}

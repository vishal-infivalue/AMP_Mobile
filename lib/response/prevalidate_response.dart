import 'dart:convert';

class User {
  int counter;
  DateTime createdts;
  DateTime? updatedts;
  int createdby;
  int updatedby;
  int id;
  int role;
  String firstname;
  String middlename;
  String lastname;
  String email;
  String phone1;
  String phone2;
  String designation;
  String status;

  User({
    required this.counter,
    required this.createdts,
    this.updatedts,
    required this.createdby,
    required this.updatedby,
    required this.id,
    required this.role,
    required this.firstname,
    required this.middlename,
    required this.lastname,
    required this.email,
    required this.phone1,
    required this.phone2,
    required this.designation,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      counter: json['counter'],
      createdts: DateTime.parse(json['createdts']),
      updatedts: json['updatedts'] != null ? DateTime.parse(json['updatedts']) : null,
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'counter': counter,
      'createdts': createdts.toIso8601String(),
      'updatedts': updatedts?.toIso8601String(),
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
    };
  }
}

void main() {
  String jsonString = '''
  {
    "counter": 1,
    "createdts": "2024-07-25T00:13:12.000+00:00",
    "updatedts": null,
    "createdby": 1009,
    "updatedby": 0,
    "id": 16031592,
    "role": 1002,
    "firstname": "Esau",
    "middlename": "",
    "lastname": "Phiri",
    "email": "xxx.xxx@xxx.com",
    "phone1": "9999988888",
    "phone2": "1111122222",
    "designation": "Cluster Manager",
    "status": "Active"
  }
  ''';

  Map<String, dynamic> userMap = jsonDecode(jsonString);
  User user = User.fromJson(userMap);


  String userJson = jsonEncode(user.toJson());

}

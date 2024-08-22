import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../response/upcoming_audits.dart';

class AuditProvider with ChangeNotifier {
  List<Audit> _audits = [];

  List<Audit> get audits => _audits;

  Future<void> fetchAudits(String loginUserId) async {
    final url = Uri.parse('http://103.235.106.117:8080/audit_management_system-0.0.10-SNAPSHOT/api/auditmaster/getallupcomingaudits');

    final response = await http.get(url, headers: {'loginUserId': loginUserId});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final AuditResponse auditResponse = AuditResponse.fromJson(data);
      _audits = auditResponse.tableData;
      notifyListeners();
    } else {
      throw Exception('Failed to load audits');
    }
  }
}

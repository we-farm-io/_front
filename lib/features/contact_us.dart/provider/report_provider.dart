import 'package:flutter/material.dart';
import 'package:smart_farm/features/contact_us.dart/model/report_model.dart';

class ReportProvider with ChangeNotifier {
  Report? _report;

  Report? get report => _report;

  void createReport({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String message,
  }) {
    _report = Report(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      message: message,
    );
    notifyListeners();
  }
}

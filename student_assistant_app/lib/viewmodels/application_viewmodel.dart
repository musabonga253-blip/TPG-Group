/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 */

import 'package:flutter/material.dart';
import 'package:student_assistant_app/models/student_application.dart';

class ApplicationViewModel extends ChangeNotifier {
  //Student application data
  StudentApplication studentApplication = StudentApplication(
    id: 001,
    studentName: "John Doe",
    yearOfStudy: "3rd year",
    module1: "SOD316C",
    module2: "TPG316C",
    status: "Pending",
  );

  //getters
  int get id => studentApplication.id;
  String get studentName => studentApplication.studentName;
  String get yearOfStudy => studentApplication.yearOfStudy;
  String get module1 => studentApplication.module1;
  String? get module2 => studentApplication.module2;
  String get status => studentApplication.status;

  // Method to update the application status
  void updateStatus(String newStatus) {
    studentApplication = studentApplication.copyWith(status: newStatus);
    notifyListeners();
  }
}

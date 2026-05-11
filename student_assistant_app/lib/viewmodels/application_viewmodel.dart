/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 */

import 'package:flutter/material.dart';
import 'package:student_assistant_app/models/student_application.dart';

class ApplicationViewModel extends ChangeNotifier {

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // LIST OF APPLICATIONS
  List<StudentApplication> _applications = [

    StudentApplication(
      id: 1,
      studentName: "John Doe",
      yearOfStudy: "3rd year",
      module1: "SOD316C",
      module2: "TPG316C",
      status: "Pending",
    ),

    StudentApplication(
      id: 2,
      studentName: "Jane Smith",
      yearOfStudy: "2nd year",
      module1: "PRG262",
      module2: "DBD261",
      status: "Approved",
    ),
  ];

  // GET APPLICATIONS
  List<StudentApplication> get applications => _applications;

  // FETCH APPLICATIONS
  Future<void> fetchApplications() async {

    _isLoading = true;
    notifyListeners();

    await Future.delayed(
      const Duration(seconds: 1),
    );

    _isLoading = false;
    notifyListeners();
  }

  // UPDATE STATUS
  void updateStatus(int id, String newStatus) {

    final index = _applications.indexWhere(
      (app) => app.id == id,
    );

    if (index != -1) {

      _applications[index] =
          _applications[index].copyWith(
        status: newStatus,
      );

      notifyListeners();
    }
  }

  // DELETE APPLICATION
  void deleteApplication(int id) {

    _applications.removeWhere(
      (app) => app.id == id,
    );

    notifyListeners();
  }
}
/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 * Question       : Application ViewModel
 */

import 'package:flutter/material.dart';
import 'package:student_assistant_app/models/student_application.dart';

class ApplicationViewModel extends ChangeNotifier {

  bool _isLoading = false;
  String? _errorMessage; // Added

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage; // Added

  // LIST OF APPLICATIONS
  final List<StudentApplication> _applications = [
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
      module1: "SOD216C",
      module2: "TPG216C",
      status: "Approved",
    ),
  ];

  // GET APPLICATIONS
  List<StudentApplication> get applications => _applications;

  // FETCH APPLICATIONS
  Future<void> fetchApplications() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _isLoading = false;
    notifyListeners();
  }

  // SUBMIT APPLICATION - Added
  Future<bool> submitApplication(StudentApplication application) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    // Check if student already submitted an application
    final alreadyExists = _applications.any(
      (app) => app.studentName == application.studentName,
    );

    if (alreadyExists) {
      _errorMessage = 'You have already submitted an application.';
      _isLoading = false;
      notifyListeners();
      return false;
    }

    _applications.add(application);
    _isLoading = false;
    notifyListeners();
    return true;
  }

  // UPDATE STATUS
  void updateStatus(int id, String newStatus) {
    final index = _applications.indexWhere((app) => app.id == id);

    if (index != -1) {
      _applications[index] = _applications[index].copyWith(status: newStatus);
      notifyListeners();
    }
  }

  // UPDATE APPLICATION
  Future<bool> updateApplication(StudentApplication updated) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    final index = _applications.indexWhere((app) => app.id == updated.id);
    if (index == -1) {
      _errorMessage = 'Application not found.';
      _isLoading = false;
      notifyListeners();
      return false;
    }

    _applications[index] = updated;
    _isLoading = false;
    notifyListeners();
    return true;
  }


  // DELETE APPLICATION
  void deleteApplication(int id) {
    _applications.removeWhere((app) => app.id == id);
    notifyListeners();
  }
}
/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 * Question       : Application ViewModel
 */

import 'package:flutter/material.dart';
import 'package:student_assistant_app/models/student_application.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApplicationViewModel extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  List<StudentApplication> _applications = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<StudentApplication> get applications => _applications;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // FETCH — isAdmin=true fetches all applications, false fetches only the logged-in user's
  Future<void> fetchApplications({bool isAdmin = false}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final query = isAdmin
          ? await _supabase
                .from('applications')
                .select() // admin sees all
          : await _supabase
                .from('applications')
                .select()
                .eq(
                  'user_id',
                  _supabase.auth.currentUser!.id,
                ); // student sees own

      _applications = (query as List)
          .map((row) => StudentApplication.fromMap(row))
          .toList();
    } catch (e) {
      _errorMessage = 'Failed to fetch applications: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // INSERT — submits a new application linked to the logged-in user
  Future<bool> submitApplication(StudentApplication application) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final userId = _supabase.auth.currentUser!.id;

      // Check if student already has an application
      final existing = await _supabase
          .from('applications')
          .select()
          .eq('user_id', userId);

      if ((existing as List).isNotEmpty) {
        _errorMessage = 'You have already submitted an application.';
        return false;
      }

      await _supabase.from('applications').insert(application.toMap(userId));

      await fetchApplications(); // refresh the list after insert
      return true;
    } catch (e) {
      _errorMessage = 'Failed to submit application: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // UPDATE — changes the status of an application (admin use)
  Future<void> updateStatus(int id, String newStatus) async {
    _errorMessage = null;

    try {
      await _supabase
          .from('applications')
          .update({'status': newStatus})
          .eq('id', id);

      // Update locally so UI reflects immediately without a full re-fetch
      final index = _applications.indexWhere((app) => app.id == id);
      if (index != -1) {
        _applications[index] = _applications[index].copyWith(status: newStatus);
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Failed to update status: $e';
      notifyListeners();
    }
  }

  // UPDATE — updates an entire application (student editing)
  Future<bool> updateApplication(StudentApplication application) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final userId = _supabase.auth.currentUser!.id;

      await _supabase
          .from('applications')
          .update(application.toMap(userId))
          .eq('id', application.id);

      await fetchApplications(); // refresh the list after update
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update application: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // DELETE — removes an application by id
  Future<void> deleteApplication(int id) async {
    _errorMessage = null;

    try {
      await _supabase.from('applications').delete().eq('id', id);

      // Remove locally so UI reflects immediately without a full re-fetch
      _applications.removeWhere((app) => app.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to delete application: $e';
      notifyListeners();
    }
  }
}

/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 */
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthViewModel extends ChangeNotifier {
  //TODO: viewmodel must communicate with authService not supabase
  final SupabaseClient _supabase = Supabase.instance.client;

  //State variables to track loading, errors, and user role
  bool _isAdmin = false;
  bool _isLoading = false;
  String? _errorMessage;

  //Getters to expose state to the UI
  bool get isAdmin => _isAdmin;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _supabase.auth.currentSession != null;
  String? get currentUserEmail => _supabase.auth.currentUser?.email;
  String? get currentUserId => _supabase.auth.currentUser?.id;

  // Fetches the user's role from the profiles table and updates _isAdmin
  Future<void> fetchUserRole() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    try {
      final response = await _supabase
          .from('profiles')
          .select('role')
          .eq('id', userId)
          .single();

      _isAdmin = response['role'] == 'admin';
    } catch (e) {
      _isAdmin = false; // default to student if fetch fails
    }

    notifyListeners();
  }

  //Method to handle user sign up
  Future<bool> signUpWithEmail(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    //attempt to sign up the user with Supabase auth
    try {
      final response = await _supabase.auth.signUp(
        email: email.trim(),
        password: password,
      );
      return response.user != null;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //Sign In
  Future<bool> signInWithEmailPassword(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );

      //This fetches the role after login
      if (response.user != null) {
        await fetchUserRole();
        return true;
      }
      return false;

    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //Signs out the current user
  Future<void> signOut() async {
    await _supabase.auth.signOut();
    notifyListeners();
  }

}

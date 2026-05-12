/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 */
import 'package:flutter/material.dart';
import '../service layer/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isAdmin = false;
  bool _isLoading = false;
  String? _errorMessage;

  bool get isAdmin => _isAdmin;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _authService.signIn(email, password);

    _isLoading = false;

    if (!result.success) {
      _errorMessage = result.message;
      notifyListeners();
      return false;
    }

    _isAdmin = result.isAdmin;
    _errorMessage = null;

    notifyListeners();
    return true;
  }
}

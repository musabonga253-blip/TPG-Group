/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 */
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  bool isAdmin = false;
  String? errorMessage;

  Future<bool> login(String username, String password) async {
    if (username == "admin" && password == "admin123") {
      isAdmin = true;
      return true;
    } else if (username == "student" && password == "student123") {
      isAdmin = false;
      return true;
    } else {
      errorMessage = "Invalid credentials";
      notifyListeners();
      return false;
    }
  }
}

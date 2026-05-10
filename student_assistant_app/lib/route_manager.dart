/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 */

import 'package:flutter/material.dart';
 
import 'views/login_screen.dart';
import 'views/home_screen.dart';
import 'views/application_form_screen.dart';
import 'views/application_detail_screen.dart';
import 'views/admin_dashboard_screen.dart';

class RouteManager {
  static const String login = '/login';
  static const String home = '/home';
  static const String applicationForm = '/applicationForm';
  static const String applicationDetail = '/applicationDetail';
  static const String adminDashboard = '/adminDashboard';
 
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
 
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
 
      case applicationForm:
        return MaterialPageRoute(
          builder: (_) => const ApplicationFormScreen(),
          settings: settings,
        );
 
      case applicationDetail:
        return MaterialPageRoute(
          builder: (_) => const ApplicationDetailScreen(),
          settings: settings,
        );
 
      case adminDashboard:
        return MaterialPageRoute(
          builder: (_) => const AdminDashboardScreen(),
          settings: settings,
        );
 
      // If a route name is not found, go back to login.
      default:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
    }
  }
}


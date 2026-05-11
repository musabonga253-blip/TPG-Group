/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 */
import 'package:flutter/material.dart';
/*import '../models/student_application.dart'; */
import '../views/login_screen.dart';
import '../views/home_screen.dart';
import '../views/admin_dashboard_screen.dart';
import '../views/application_form_screen.dart';
import '../views/application_details_screen.dart';

class RouteManager {
  static const String login = '/login';
  static const String home = '/home';
  static const String adminDashboard = '/adminDashboard';
  static const String applicationForm = '/applicationForm';
  static const String applicationDetails = '/applicationDetails';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case adminDashboard:
        return MaterialPageRoute(builder: (_) => const AdminDashboardScreen());
      case applicationForm:
        return MaterialPageRoute(builder: (_) => const ApplicationFormScreen());
      case applicationDetails:
        return MaterialPageRoute(
          builder: (_) => const ApplicationDetailsScreen(),
            settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Route not found")),
          ),
        );
    }
  }
}

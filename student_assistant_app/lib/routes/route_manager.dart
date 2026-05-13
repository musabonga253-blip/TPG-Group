/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 */
import 'package:flutter/material.dart';
import 'package:student_assistant_app/models/student_application.dart';
import 'package:student_assistant_app/views/signup_screen.dart';
/*import '../models/student_application.dart'; */
import '../views/login_screen.dart';
import '../views/home_screen.dart';
import '../views/admin_dashboard_screen.dart';
import '../views/application_form_screen.dart';
import '../views/application_details_screen.dart';

class RouteManager {
  static const String signUp = '/signUp';
  static const String login = '/login';
  static const String home = '/home';
  static const String adminDashboard = '/adminDashboard';
  static const String applicationForm = '/applicationForm';
  static const String applicationDetails = '/applicationDetails';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case adminDashboard:
        return MaterialPageRoute(builder: (_) => const AdminDashboardScreen());
      case applicationForm:
        final application =
            settings.arguments
                as StudentApplication?; // Optional argument for editing
        return MaterialPageRoute(
          builder: (_) =>
              ApplicationFormScreen(existingApplication: application),
        );
      case RouteManager.applicationDetails:
        final application = settings.arguments as StudentApplication; //
        return MaterialPageRoute(
          builder: (_) => ApplicationDetailsScreen(application: application),
        );
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}

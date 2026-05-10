import 'package:flutter/material.dart';
import '../views/admin_dashboard_screen.dart';
import '../views/application_details_screen.dart';
import '../views/application_form_screen.dart';
import '../views/home_screen.dart';

class RouteManager {
  static const String authenticationRoute = '/';
  static const String homeRoute = '/home';
  static const String applicationFormRoute = '/application-form';
  static const String applicationDetailsRoute = '/Details';
  static const String adminDashboardRoute = '/admin-dashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case authenticationRoute:
        return MaterialPageRoute(builder: (_) => const AuthenticationScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case applicationFormRoute:
        return MaterialPageRoute(builder: (_) => const ApplicationFormScreen());
      case applicationDetailsRoute:
        final message = settings.arguments as String; //dynamic route
        return MaterialPageRoute(builder: (_) => ApplicationDetailsScreen(message: message));
      case adminDashboardRoute:
        return MaterialPageRoute(builder: (_) => const AdminDashboardScreen());
      default:
        return throw Exception('Route not found: ${settings.name}');  
    }
  }
}
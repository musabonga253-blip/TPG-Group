/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 */

class RouteManager {
  static const String authenticationRoute = '/';
  static const String homeRoute = '/home';
  static const String applicationFormRoute = '/application-form';
  static const String applicationDetailsRoute = '/Details';
  static const String adminDashboardRoute = '/admin-dashboard';

  /* static Route<dynamic> generateRoute(RouteSettings settings) {
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
  }*/
}

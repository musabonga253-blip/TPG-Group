

/**
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 223086046, 224107046, 220025661, 224090026
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/application_viewmodel.dart';
import '../route_manager.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ApplicationViewModel(),
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Assistant App',
      initialRoute: RouteManager.login,
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}

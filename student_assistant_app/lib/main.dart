import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/application_viewmodel.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'routes/route_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://mblkysjgiflxdcutparr.supabase.co',
    anonKey: 'sb_publishable_vDGlhTm66v0Urhztvi-zmw_vOaHUPlN',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApplicationViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
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
      debugShowCheckedModeBanner: false,
      initialRoute: RouteManager.login,
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}

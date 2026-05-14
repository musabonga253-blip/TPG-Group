/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 */

//Continueously Stalks(listens) for auth state schanges

//Not authenticated, navigate to login screen
//Authenticated, navigate to home screen

import 'package:flutter/material.dart';
import 'package:student_assistant_app/views/home_screen.dart';
import 'package:student_assistant_app/views/views.auth/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthStalker extends StatelessWidget {
  const AuthStalker({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      //DO the stalking(listening for auth state changes)
      stream: Supabase.instance.client.auth.onAuthStateChange,

      //Build the UI based on the auth state
      builder: (context, snapshot) {
        //loading...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        //Check if there is a valid session currently
        final session = snapshot.hasData ? snapshot.data!.session : null;
        if (session != null) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}

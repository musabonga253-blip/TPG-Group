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
import 'package:provider/provider.dart';
import 'package:student_assistant_app/viewmodels/auth_viewmodel.dart';
import 'package:student_assistant_app/views/admin_dashboard_screen.dart';
import 'package:student_assistant_app/views/home_screen.dart';
import 'package:student_assistant_app/views/views.auth/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthStalker extends StatelessWidget {
  const AuthStalker({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        // Still connecting to the auth stream
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final session = snapshot.hasData ? snapshot.data!.session : null;

        // No session — send to login
        if (session == null) {
          return const LoginScreen();
        }

        // Session exists — check role then route accordingly
        return Consumer<AuthViewModel>(
          builder: (context, authViewModel, child) {
            // Fetch the role if not loaded yet
            if (!authViewModel.isLoading && !authViewModel.roleFetched) {
              // Use addPostFrameCallback to avoid calling during build
              WidgetsBinding.instance.addPostFrameCallback((_) {
                authViewModel.fetchUserRole();
              });
            }

            // Show loading while role is being fetched
            if (authViewModel.isLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            // Route based on role
            if (authViewModel.isAdmin) {
              return const AdminDashboardScreen();
            } else {
              return const HomeScreen();
            }
          },
        );
      },
    );
  }
}

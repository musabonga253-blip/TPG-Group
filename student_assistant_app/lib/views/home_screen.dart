/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_assistant_app/service%20layer/auth_service.dart';
import '../viewmodels/application_viewmodel.dart';
import '../routes/route_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<ApplicationViewModel>().fetchApplications();
    });
  }

  final authService = AuthService();
  void logout() async {
    await authService.signOut();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, RouteManager.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Home"),

        //logout button
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteManager.applicationForm);
        },
        child: const Icon(Icons.add),
      ),

      body: Consumer<ApplicationViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (vm.applications.isEmpty) {
            return const Center(child: Text("No applications submitted"));
          }
          return ListView.builder(
            itemCount: vm.applications.length,
            itemBuilder: (context, index) {
              final app = vm.applications[index];
              return Card(
                child: ListTile(
                  title: Text(app.module1),
                  subtitle: Text("Status: ${app.status}"),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteManager.applicationDetails,
                      arguments: app,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

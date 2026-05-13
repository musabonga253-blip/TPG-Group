/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/application_viewmodel.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../routes/route_manager.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      // ignore: use_build_context_synchronously
      () => context.read<ApplicationViewModel>().fetchApplications(),
    );
  }

  void logOut() async {
    await AuthViewModel().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        automaticallyImplyLeading: false,
        actions: [
          // Logout button
          TextButton(
            onPressed: () {
              context.read<AuthViewModel>().signOut();
              Navigator.pushReplacementNamed(context, RouteManager.login);
            },
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Consumer<ApplicationViewModel>(
        builder: (context, appViewModel, child) {
          // No applications yet
          if (appViewModel.applications.isEmpty) {
            return const Center(child: Text('No applications submitted yet.'));
          }

          // List of all applications
          return ListView.builder(
            itemCount: appViewModel.applications.length,
            itemBuilder: (context, index) {
              final application = appViewModel.applications[index];

              return Column(
                children: [
                  // Application info
                  Text('Name: ${application.studentName}'),
                  Text('Year: ${application.yearOfStudy}'),
                  Text('Module 1: ${application.module1}'),
                  if (application.module2 != null)
                    Text('Module 2: ${application.module2}'),
                  Text('Status: ${application.status}'),

                  // Approve button
                  ElevatedButton(
                    onPressed: () {
                      appViewModel.updateStatus(application.id, 'Approved');
                    },
                    child: const Text('Approve'),
                  ),

                  // Reject button
                  ElevatedButton(
                    onPressed: () {
                      appViewModel.updateStatus(application.id, 'Rejected');
                    },
                    child: const Text('Reject'),
                  ),

                  // Remove button
                  ElevatedButton(
                    onPressed: () {
                      appViewModel.deleteApplication(application.id);
                    },
                    child: const Text('Remove'),
                  ),

                  const Divider(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

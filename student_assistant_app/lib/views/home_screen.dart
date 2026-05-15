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
import '../theme/app_colours.dart';

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
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return const Color(0xFF16A34A);
      case 'rejected':
        return AppColours.urgentDark;
      default:
        return AppColours.rewardDark;
    }
  }

  Color _statusBg(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return const Color(0xFFF0FDF4);
      case 'rejected':
        return AppColours.urgentLight;
      default:
        return AppColours.rewardLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Applications'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Sign out',
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, RouteManager.applicationForm);
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('New application'),
      ),

      body: Consumer<ApplicationViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColours.primary),
            );
          }

          if (vm.applications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColours.primaryLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.inbox_rounded,
                      size: 36,
                      color: AppColours.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No applications yet',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColours.onSurface,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Tap the button below to submit your first application',
                    style: TextStyle(fontSize: 13, color: AppColours.muted),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            itemCount: vm.applications.length,
            itemBuilder: (context, index) {
              final app = vm.applications[index];
              return Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteManager.applicationDetails,
                      arguments: app,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Module icon
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColours.primaryLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.book_outlined,
                            color: AppColours.primary,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),

                        // Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                app.module1,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColours.onSurface,
                                ),
                              ),
                              if (app.module2 != null) ...[
                                const SizedBox(height: 2),
                                Text(
                                  app.module2!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColours.muted,
                                  ),
                                ),
                              ],
                              const SizedBox(height: 2),
                              Text(
                                'Year ${app.yearOfStudy}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColours.muted,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Status badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _statusBg(app.status),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            app.status,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: _statusColor(app.status),
                            ),
                          ),
                        ),

                        const SizedBox(width: 6),
                        const Icon(
                          Icons.chevron_right_rounded,
                          color: AppColours.muted,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

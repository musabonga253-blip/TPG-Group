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
import '../theme/app_colours.dart';

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
      () => context.read<ApplicationViewModel>().fetchApplications(isAdmin: true),
    );
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
        title: const Text('Admin Dashboard'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthViewModel>().signOut();
              Navigator.pushReplacementNamed(context, RouteManager.login);
            },
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Consumer<ApplicationViewModel>(
        builder: (context, appViewModel, child) {
          if (appViewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColours.primary),
            );
          }

          if (appViewModel.applications.isEmpty) {
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
                    'Student applications will appear here',
                    style: TextStyle(fontSize: 13, color: AppColours.muted),
                  ),
                ],
              ),
            );
          }

          // Summary counts
          final total = appViewModel.applications.length;
          final pending = appViewModel.applications
              .where((a) => a.status.toLowerCase() == 'pending')
              .length;
          final approved = appViewModel.applications
              .where((a) => a.status.toLowerCase() == 'approved')
              .length;

          return Column(
            children: [
              // Summary bar
              Container(
                color: AppColours.surface,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    _summaryChip(
                      '$total total',
                      AppColours.primaryLight,
                      AppColours.primaryDark,
                    ),
                    const SizedBox(width: 8),
                    _summaryChip(
                      '$pending pending',
                      AppColours.rewardLight,
                      AppColours.rewardDark,
                    ),
                    const SizedBox(width: 8),
                    _summaryChip(
                      '$approved approved',
                      const Color(0xFFF0FDF4),
                      const Color(0xFF166534),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),

              // Applications list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: appViewModel.applications.length,
                  itemBuilder: (context, index) {
                    final application = appViewModel.applications[index];

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header row
                            Row(
                              children: [
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: AppColours.primaryLight,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.person_outline_rounded,
                                    color: AppColours.primary,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        application.studentName,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColours.onSurface,
                                        ),
                                      ),
                                      Text(
                                        'Year ${application.yearOfStudy}',
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
                                    color: _statusBg(application.status),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    application.status,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: _statusColor(application.status),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Module info
                            Text(
                              application.module1,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColours.muted,
                              ),
                            ),
                            if (application.module2 != null)
                              Text(
                                application.module2!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColours.muted,
                                ),
                              ),

                            // View document button
                            if (application.documentUrl != null)
                              TextButton.icon(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      title: const Text('Supporting Document'),
                                      content: Image.network(
                                        application.documentUrl!,
                                        errorBuilder: (_, __, ___) =>
                                            const Text(
                                          'Failed to load document',
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Close'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.description_outlined,
                                  size: 16,
                                ),
                                label: const Text('View Document'),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  foregroundColor: AppColours.primary,
                                ),
                              ),

                            const SizedBox(height: 14),
                            const Divider(height: 1),
                            const SizedBox(height: 12),

                            // Action buttons
                            Row(
                              children: [
                                // Approve
                                Expanded(
                                  child: _actionButton(
                                    label: 'Approve',
                                    icon: Icons.check_rounded,
                                    color: const Color(0xFF16A34A),
                                    bgColor: const Color(0xFFF0FDF4),
                                    onTap: () => appViewModel.updateStatus(
                                      application.id,
                                      'Approved',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Reject
                                Expanded(
                                  child: _actionButton(
                                    label: 'Reject',
                                    icon: Icons.close_rounded,
                                    color: AppColours.urgentDark,
                                    bgColor: AppColours.urgentLight,
                                    onTap: () => appViewModel.updateStatus(
                                      application.id,
                                      'Rejected',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Remove with confirmation
                                _actionButton(
                                  label: 'Remove',
                                  icon: Icons.delete_outline_rounded,
                                  color: AppColours.muted,
                                  bgColor: AppColours.scaffoldBg,
                                  compact: true,
                                  onTap: () async {
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        title: const Text('Confirm Removal'),
                                        content: const Text(
                                          'Are you sure you want to remove this application?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(ctx, false),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(ctx, true),
                                            style: TextButton.styleFrom(
                                              foregroundColor:
                                                  AppColours.urgent,
                                            ),
                                            child: const Text('Remove'),
                                          ),
                                        ],
                                      ),
                                    );
                                    if (confirm == true) {
                                      appViewModel.deleteApplication(
                                        application.id,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _summaryChip(String label, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: fg,
        ),
      ),
    );
  }

  Widget _actionButton({
    required String label,
    required IconData icon,
    required Color color,
    required Color bgColor,
    required VoidCallback onTap,
    bool compact = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 12 : 0,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: compact
            ? Icon(icon, color: color, size: 18)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: color, size: 16),
                  const SizedBox(width: 5),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

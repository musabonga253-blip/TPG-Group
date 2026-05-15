/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/student_application.dart';
import '../routes/route_manager.dart';
import '../viewmodels/application_viewmodel.dart';
import '../theme/app_colours.dart';

class ApplicationDetailsScreen extends StatelessWidget {
  final StudentApplication application;

  const ApplicationDetailsScreen({super.key, required this.application});

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

  IconData _statusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Icons.check_circle_outline_rounded;
      case 'rejected':
        return Icons.cancel_outlined;
      default:
        return Icons.hourglass_top_rounded;
    }
  }

  Widget _detailRow(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, color: AppColours.muted),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColours.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Details'),
        actions: [
          // Delete button — always visible in AppBar
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            color: AppColours.urgent,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    title: const Text('Delete Application?'),
                    content: const Text('This action cannot be undone.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          final viewModel = Provider.of<ApplicationViewModel>(
                            ctx,
                            listen: false,
                          );
                          viewModel.deleteApplication(application.id);
                          Navigator.of(ctx).pop(); // close dialog
                          Navigator.of(context).pop(); // go back
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColours.urgent,
                        ),
                        child: const Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _statusBg(application.status),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _statusColor(application.status).withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _statusIcon(application.status),
                    color: _statusColor(application.status),
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Application status',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColours.muted,
                        ),
                      ),
                      Text(
                        application.status,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: _statusColor(application.status),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Avatar + name header
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColours.primaryLight,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: AppColours.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      application.studentName,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColours.onSurface,
                      ),
                    ),
                    Text(
                      'Year ${application.yearOfStudy}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColours.muted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Details card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppColours.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColours.divider),
              ),
              child: Column(
                children: [
                  _detailRow('Application ID', '#${application.id}'),
                  const Divider(height: 1),
                  _detailRow('Year of study', application.yearOfStudy),
                  const Divider(height: 1),
                  _detailRow('Module 1', application.module1),
                  if (application.module2 != null) ...[
                    const Divider(height: 1),
                    _detailRow('Module 2', application.module2),
                  ],
                ],
              ),
            ),

            // Supporting document
            if (application.documentUrl != null) ...[
              const SizedBox(height: 20),
              const Text(
                'Supporting Document',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColours.muted,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColours.divider),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.network(
                    application.documentUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Center(
                      child: Text(
                        'Failed to load document',
                        style: TextStyle(color: AppColours.muted),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 28),

            // Edit button — only shown when Pending
            if (application.status == 'Pending')
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RouteManager.applicationForm,
                    arguments: application,
                  );
                },
                icon: const Icon(Icons.edit_outlined, size: 18),
                label: const Text('Edit details'),
              ),

            const SizedBox(height: 12),

            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to applications'),
            ),
          ],
        ),
      ),
    );
  }
}

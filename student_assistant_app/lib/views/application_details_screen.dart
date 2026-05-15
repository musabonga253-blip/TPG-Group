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

class ApplicationDetailsScreen extends StatelessWidget {
  final StudentApplication application; //

  const ApplicationDetailsScreen({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Application Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirm Delete'),
                    content: Text(
                      'Are you sure you want to delete this application?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          final viewModel = Provider.of<ApplicationViewModel>(
                            context,
                            listen: false,
                          );
                          viewModel.deleteApplication(application.id);
                          Navigator.of(context).pop(); // close dialog
                          Navigator.of(
                            context,
                          ).pop(); // go back to previous screen
                        },
                        child: Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),

      body: Center(
        child: Column(
          children: [
            Icon(Icons.account_circle, size: 100, color: Colors.blueGrey),
            Text(''),
            Text('Application ID: ${application.id}'),
            Text('Name: ${application.studentName}'),
            Text('Year of Study: ${application.yearOfStudy}'),
            Text('Module 1: ${application.module1}'),
            Text('Module 2: ${application.module2}'),
            Text('Status: ${application.status}'),
            // ...
            Text(''),

            ElevatedButton(
              onPressed: application.status == "Pending"
                  ? () {
                    Navigator.pushNamed(
                      context,
                      RouteManager.applicationForm,
                      arguments: application,
                    );
                  }
             : null, // disables the button when not Pending
              child: Text(
                application.status == "Pending"
                    ? "Edit Details"
                    : "Edit Locked", // optional label change
              ),
            ),

            Text(''),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}

/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 */

import 'package:flutter/material.dart';
import '../models/student_application.dart';
import '../routes/route_manager.dart';

class ApplicationDetailsScreen extends StatelessWidget {
  final StudentApplication application; //

  const ApplicationDetailsScreen({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Application Details")),
      body: Center(
        child: Column(
          children: [
            Icon(Icons.account_circle, size: 100, color: Colors.blueGrey),
            Text(''),
            //Text('Application ID: ${application.id}'),
            Text('Name: ${application.studentName}'),
            Text('Year of Study: ${application.yearOfStudy}'),
            Text('Module 1: ${application.module1}'),
            Text('Module 2: ${application.module2}'),
            Text('Status: ${application.status}'),
            // ...
            Text(''),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteManager.applicationForm, arguments: application);
              },
              child: const Text("Edit Details"),
            ),
            Text(''),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Back")),
          ],
        ),
      ),
    );
  }
}

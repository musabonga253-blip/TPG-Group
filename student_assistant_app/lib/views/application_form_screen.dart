/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 */

import 'package:flutter/material.dart';

class ApplicationFormScreen extends StatefulWidget {
  const ApplicationFormScreen({super.key});

  @override
  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  final studentNumberController = TextEditingController();
  final courseController = TextEditingController();
  final yearOfStudyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Application Form')),

      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: yearOfStudyController,
              decoration: const InputDecoration(
                labelText: 'Current Year of Study',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Year of study is required';
                }
                return null;
              },
            ),

            SizedBox(height: 15),
            TextFormField(
              controller: courseController,
              decoration: const InputDecoration(
                labelText: 'Module with academic level',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Module with academic level is required';
                }
                return null;
              },
            ),
            SizedBox(height: 15),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                // Handle form submission
              },
              child: const Text('Submit Application'),
            ),
          ],
        ),
      ),
    );
  }
}

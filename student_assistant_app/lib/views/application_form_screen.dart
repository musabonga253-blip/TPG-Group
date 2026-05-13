/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 * Question       : Application Form Screen
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/application_viewmodel.dart';
import '../models/student_application.dart';
import '../routes/route_manager.dart';

class ApplicationFormScreen extends StatefulWidget {
  final StudentApplication? existingApplication; // Optional parameter for editing
  const ApplicationFormScreen({super.key, this.existingApplication});

  @override
  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  // His original controllers — kept exactly as he had them
  final studentNumberController = TextEditingController();
  final courseController = TextEditingController();
  final yearOfStudyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Added: second module controller
  final secondModuleController = TextEditingController();

  // Added: toggles for second module and eligibility
  bool _addSecondModule = false;
  bool _confirmedEligibility = false;

  @override //logic to pre-fill form if we're editing an existing application
void initState() {
  super.initState();
  final app = widget.existingApplication;
  if (app != null) {
    studentNumberController.text = app.studentName;
    yearOfStudyController.text = app.yearOfStudy;
    courseController.text = app.module1;
    if (app.module2 != null) {
      _addSecondModule = true;
      secondModuleController.text = app.module2!;
    }
    _confirmedEligibility = true; // Pre-confirm since it was already submitted
  }
}

  @override
  void dispose() {
    studentNumberController.dispose();
    courseController.dispose();
    yearOfStudyController.dispose();
    secondModuleController.dispose();
    super.dispose();
  }

  // Added: submit handler connected to ViewModel
  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_confirmedEligibility) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please confirm your eligibility.')),
      );
      return;
    }

    final appViewModel = context.read<ApplicationViewModel>();

    final newApplication = StudentApplication(
      id: DateTime.now().millisecondsSinceEpoch,
      studentName: studentNumberController.text.trim(),
      yearOfStudy: yearOfStudyController.text.trim(),
      module1: courseController.text.trim(),
      module2: _addSecondModule && secondModuleController.text.isNotEmpty
          ? secondModuleController.text.trim()
          : null,
    );

    final success = await appViewModel.submitApplication(newApplication);

    if (success) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Application submitted successfully!')),
      );
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, RouteManager.home);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(appViewModel.errorMessage ?? 'Submission failed.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Application Form')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              // His original year of study field
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
              const SizedBox(height: 15),

              // His original module field
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
              const SizedBox(height: 15),

              // His original student number field
              TextFormField(
                controller: studentNumberController,
                decoration: const InputDecoration(
                  labelText: 'Student Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Student number is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Added: second module toggle
              CheckboxListTile(
                value: _addSecondModule,
                title: const Text('Add a second module'),
                onChanged: (value) {
                  setState(() {
                    _addSecondModule = value ?? false;
                    if (!_addSecondModule) {
                      secondModuleController.clear();
                    }
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),

              // Added: second module field — only shows if checkbox is ticked
              if (_addSecondModule) ...[
                const SizedBox(height: 8),
                TextFormField(
                  controller: secondModuleController,
                  decoration: const InputDecoration(
                    labelText: 'Second Module with academic level',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (_addSecondModule &&
                        (value == null || value.isEmpty)) {
                      return 'Please enter the second module';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
              ],

              // Added: eligibility confirmation checkbox
              CheckboxListTile(
                value: _confirmedEligibility,
                title: const Text(
                  'I confirm that I meet the minimum requirements for the Student Assistant position.',
                ),
                onChanged: (value) {
                  setState(() => _confirmedEligibility = value ?? false);
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 15),

              // His original button — now connected to _handleSubmit
              ElevatedButton(
                onPressed: _handleSubmit,
                child: const Text('Submit Application'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
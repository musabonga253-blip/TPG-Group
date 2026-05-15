/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 * Question       : Application Form Screen
 */

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../viewmodels/application_viewmodel.dart';
import '../models/student_application.dart';
import '../routes/route_manager.dart';
import '../service layer/storage_service.dart';
import '../theme/app_colours.dart';

class ApplicationFormScreen extends StatefulWidget {
  final StudentApplication? existingApplication;
  const ApplicationFormScreen({super.key, this.existingApplication});

  @override
  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  final studentNumberController = TextEditingController();
  final courseController = TextEditingController();
  final yearOfStudyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  File? _pickedDocument;
  String? _uploadedDocumentUrl;

  Future<void> _pickDocument() async {
    final file = await StorageService.pickImage(ImageSource.gallery);
    if (file != null) {
      setState(() => _pickedDocument = file);
    }
  }

  final secondModuleController = TextEditingController();
  bool _addSecondModule = false;
  bool _confirmedEligibility = false;

  bool get _isEditing => widget.existingApplication != null;

  @override
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
      _confirmedEligibility = true;
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

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_confirmedEligibility) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please confirm your eligibility.')),
      );
      return;
    }

    // Upload document first if one was picked
    if (_pickedDocument != null) {
      final storageService = StorageService();
      final userId = Supabase.instance.client.auth.currentUser!.id;
      _uploadedDocumentUrl = await storageService.uploadProfilePicture(
        userId,
        _pickedDocument!,
      );
    }

    final appViewModel = context.read<ApplicationViewModel>();

    final newApplication = StudentApplication(
      id: _isEditing
          ? widget.existingApplication!.id
          : DateTime.now().millisecondsSinceEpoch,
      studentName: studentNumberController.text.trim(),
      yearOfStudy: yearOfStudyController.text.trim(),
      documentUrl: _uploadedDocumentUrl,
      module1: courseController.text.trim(),
      module2: _addSecondModule && secondModuleController.text.isNotEmpty
          ? secondModuleController.text.trim()
          : null,
      status: _isEditing ? widget.existingApplication!.status : 'Pending',
    );

    final bool success;
    if (_isEditing) {
      success = await appViewModel.updateApplication(newApplication);
    } else {
      success = await appViewModel.submitApplication(newApplication);
    }

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEditing
                ? 'Application updated successfully!'
                : 'Application submitted successfully!',
          ),
        ),
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

  Widget _fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColours.onSurface,
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColours.muted,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Application' : 'New Application'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColours.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.info_outline_rounded,
                      color: AppColours.primary,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Fill in your details to apply for a Student Assistant position.',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColours.primaryDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              _sectionHeader('STUDENT DETAILS'),

              _fieldLabel('Student number'),
              TextFormField(
                controller: studentNumberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'e.g. 224022456',
                  prefixIcon: Icon(Icons.badge_outlined, size: 20),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Student number is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              _fieldLabel('Current year of study'),
              TextFormField(
                controller: yearOfStudyController,
                decoration: const InputDecoration(
                  hintText: 'e.g. 3rd Year',
                  prefixIcon: Icon(Icons.school_outlined, size: 20),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Year of study is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              _sectionHeader('MODULES'),

              _fieldLabel('Module with academic level'),
              TextFormField(
                controller: courseController,
                decoration: const InputDecoration(
                  hintText: 'e.g. TPG316C — Technical Programming III',
                  prefixIcon: Icon(Icons.book_outlined, size: 20),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Module with academic level is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Second module toggle
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  setState(() {
                    _addSecondModule = !_addSecondModule;
                    if (!_addSecondModule) secondModuleController.clear();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColours.divider),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _addSecondModule
                            ? Icons.check_box_rounded
                            : Icons.check_box_outline_blank_rounded,
                        color: _addSecondModule
                            ? AppColours.primary
                            : AppColours.muted,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Add a second module',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColours.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (_addSecondModule) ...[
                const SizedBox(height: 12),
                _fieldLabel('Second module with academic level'),
                TextFormField(
                  controller: secondModuleController,
                  decoration: const InputDecoration(
                    hintText: 'e.g. INF214C — Information Systems II',
                    prefixIcon: Icon(Icons.book_outlined, size: 20),
                  ),
                  validator: (value) {
                    if (_addSecondModule && (value == null || value.isEmpty)) {
                      return 'Please enter the second module';
                    }
                    return null;
                  },
                ),
              ],
              const SizedBox(height: 24),

              _sectionHeader('SUPPORTING DOCUMENT'),

              // Document upload
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: _pickDocument,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _pickedDocument != null
                        ? AppColours.primaryLight
                        : AppColours.scaffoldBg,
                    border: Border.all(
                      color: _pickedDocument != null
                          ? AppColours.primary
                          : AppColours.divider,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _pickedDocument != null
                            ? Icons.check_circle_rounded
                            : Icons.upload_file_rounded,
                        color: _pickedDocument != null
                            ? AppColours.primary
                            : AppColours.muted,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _pickedDocument != null
                            ? 'Document selected'
                            : 'Upload supporting document',
                        style: TextStyle(
                          fontSize: 14,
                          color: _pickedDocument != null
                              ? AppColours.primaryDark
                              : AppColours.muted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              _sectionHeader('ELIGIBILITY'),

              // Eligibility confirmation
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  setState(() => _confirmedEligibility = !_confirmedEligibility);
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _confirmedEligibility
                        ? AppColours.primaryLight
                        : AppColours.scaffoldBg,
                    border: Border.all(
                      color: _confirmedEligibility
                          ? AppColours.primary
                          : AppColours.divider,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        _confirmedEligibility
                            ? Icons.check_circle_rounded
                            : Icons.radio_button_unchecked_rounded,
                        color: _confirmedEligibility
                            ? AppColours.primary
                            : AppColours.muted,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'I confirm that I meet the minimum requirements for the Student Assistant position.',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColours.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // Submit button
              Consumer<ApplicationViewModel>(
                builder: (context, vm, child) {
                  return ElevatedButton(
                    onPressed: vm.isLoading ? null : _handleSubmit,
                    child: vm.isLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            _isEditing
                                ? 'Update Application'
                                : 'Submit Application',
                          ),
                  );
                },
              ),
              const SizedBox(height: 12),

              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

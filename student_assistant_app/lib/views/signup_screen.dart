import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_assistant_app/routes/route_manager.dart' show RouteManager;
import '../viewmodels/auth_viewmodel.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  final SignupNameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final SignupPasswordController = TextEditingController();

  @override
  void dispose() {
    SignupNameController.dispose();
    SignupPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (_formKey.currentState?.validate() != true) return;

    final authViewModel = context.read<AuthViewModel>();

    final success = await authViewModel.signup(
      SignupNameController.text.trim(),
      SignupPasswordController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      if (authViewModel.isAdmin) {
        Navigator.pushReplacementNamed(
          context,
          RouteManager.adminDashboard,
        );
      } else {
        Navigator.pushReplacementNamed(
          context,
          RouteManager.home,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                TextFormField(
                  controller: SignupNameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: SignupPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }

                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                Consumer<AuthViewModel>(
                  builder: (context, auth, child) {
                    if (auth.errorMessage != null) {
                      return Text(
                        auth.errorMessage!,
                        style: const TextStyle(color: Colors.blue),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: _handleSignup,
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
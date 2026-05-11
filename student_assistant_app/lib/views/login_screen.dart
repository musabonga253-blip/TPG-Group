/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 * Question       : Login Screen
 */
 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../route_manager.dart';
 
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
 
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
 
class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final loginNameController = TextEditingController();
  final loginPasswordController = TextEditingController();
 
  @override
  void dispose() {
    loginNameController.dispose();
    loginPasswordController.dispose();
    super.dispose();
  }
 
Future<void> _handleLogin() async {
  if (_formKey.currentState?.validate() != true) return;

  final authViewModel = context.read<AuthViewModel>();

  final success = await authViewModel.login(
    loginNameController.text.trim(),
    loginPasswordController.text.trim(),
  );

  if (!mounted) return; 

  if (success) {
    if (authViewModel.isAdmin) {
      Navigator.pushReplacementNamed(context, RouteManager.adminDashboard);
    } else {
      Navigator.pushReplacementNamed(context, RouteManager.home);
    }
  }
}

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
 
              TextFormField(
                controller: loginNameController,
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
                controller: loginPasswordController,
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
 
              // Show error message from ViewModel if login fails
              Consumer<AuthViewModel>(
                builder: (context, auth, child) {
                  if (auth.errorMessage != null) {
                    return Text(
                      auth.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 16),
 
              ElevatedButton(
                onPressed: _handleLogin,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

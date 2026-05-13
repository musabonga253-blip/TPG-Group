/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 * Question       : Login Screen
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_assistant_app/service%20layer/auth_service.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../routes/route_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Retrieve AuthService instance
  final authService = AuthService();

  //text controllers
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false; //State variable to track password visibility

  //When login button is pressed
  void _handleLogin() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    //Attempt login
    try {
      await authService.signInWithEmailPassword(email, password);
      //Navigate to home screen on success
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      //If anything goes wrong, show error message
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Login failed: $e')));
      }
    }
  }

  //UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        automaticallyImplyLeading: false,
      ),

      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
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
              controller: _passwordController,
              obscureText: !_isPasswordVisible, //Hide password by default
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                //Icon button to toggle password visibility
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
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
              builder: (context, authViewModel, child) {
                return ElevatedButton(
                  onPressed: _handleLogin,
                  child: const Text('Login'),
                );
              },
            ),
            const SizedBox(height: 16),

            //supposed to take you to the sign up screen but It needs to be implemented first
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteManager.signUp);
              },
              child: const Text(
                'Don\'t have an account? Sign up',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

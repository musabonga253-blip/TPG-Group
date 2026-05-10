/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 */

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final loginNameController = TextEditingController();
  final loginPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: loginNameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),

            TextFormField(
              controller: loginPasswordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

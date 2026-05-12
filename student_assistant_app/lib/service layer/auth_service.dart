import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class AuthService {
  Future<AuthResult> signIn(String email, String password) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final userId = response.user?.id;

    if (userId == null) {
      return AuthResult(
        success: false,
        isAdmin: false,
        message: "Invalid credentials. Please try again.",
      );
    }

    final role = await fetchUserRole(userId);

    return AuthResult(success: true, isAdmin: role == 'admin');
  }

  Future<String> fetchUserRole(String userId) async {
    final data = await supabase
        .from('profiles')
        .select('role')
        .eq('id', userId)
        .single();

    return data['role'];
  }
}

class AuthResult {
  final bool success;
  final bool isAdmin;
  final String? message;

  AuthResult({required this.success, required this.isAdmin, this.message});
}

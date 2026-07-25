// Learn@123?..

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/todo_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    return await supabase.auth.signUp(password: password, email: email);
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await supabase.auth.signInWithPassword(
      password: password,
      email: email,
    );
  }
}

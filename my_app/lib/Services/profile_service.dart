import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final supabase = Supabase.instance.client;

  Future<void> createProfile({
    required String username,
    required String email,
    required String bio,
    required String college,
  }) async {
    final user = supabase.auth.currentUser;

    await supabase.from("profiles").upsert({
      "id": user!.id,
      "username": username,
      "college": college,
      "bio": bio,
      "email": email,
    });
  }

  Future<Map<String, dynamic>?> getProfile() async {
    final user = supabase.auth.currentUser;

    final response = await supabase
        .from("profiles")
        .select()
        .eq('id', user!.id)
        .maybeSingle();

    return response;
  }

  Future<void> updateProfile({
    required String username,
    required String email,
    required String bio,
    required String college,
  }) async {
    final user = supabase.auth.currentUser;

    await supabase
        .from("profiles")
        .update({
          "username": username,
          "email": email,
          "bio": bio,
          "college": college,
        })
        .eq('id', user!.id);
  }
}

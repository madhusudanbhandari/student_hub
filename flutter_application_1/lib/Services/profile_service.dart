import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final supabase = Supabase.instance.client;

  Future<void> addProfile({
    required String name,
    required String age,
    required String address,
    required String email,
  }) async {
    try {
      await supabase.from('profiles').insert({
        'name': name,
        'age': age,
        'address': address,
        'email': email,
      });
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}

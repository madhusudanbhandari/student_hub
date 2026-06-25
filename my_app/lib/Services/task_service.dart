import 'package:supabase_flutter/supabase_flutter.dart';

class TaskService {
  final supabase = Supabase.instance.client;

  Future<void> addTask({
    required String title,
    required String description,
  }) async {
    final user = supabase.auth.currentUser;

    await supabase.from("tasks").insert({
      "user_id": user!.id,
      "title": title,
      'description': description,
    });
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    final user = supabase.auth.currentUser;

    final respose = await supabase
        .from('tasks')
        .select()
        .eq('user_id', user!.id)
        .order('created_at');

    return List<Map<String, dynamic>>.from(respose);
  }

  Future<void> deleteTask(int id) async {
    await supabase.from('tasks').delete().eq('id', id);
  }

  Future<void> toggleTask(int id, bool currentValue) async {
    await supabase
        .from('tasks')
        .update({"completed": !currentValue})
        .eq('id', id);
  }
}

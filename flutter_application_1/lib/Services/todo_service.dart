import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/todo_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TodoService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> addTodo({
    required String title,
    required String description,
    required String deadline,
  }) async {
    try {
      await supabase.from('todos').insert({
        'title': title,
        'description': description,
        'deadline': deadline,
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Todo>> getTodos() async {
    final response = await supabase.from('todos').select();

    return response.map((todo) => Todo.fromJson(todo)).toList();
  }
}

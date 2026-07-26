import 'package:flutter_application_1/Models/todo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoNotifier extends Notifier<List<Todo>> {
  @override
  List<Todo> build() {
    return [];
  }
}

final todoProvider = NotifierProvider<TodoNotifier, List<Todo>>(
  TodoNotifier.new,
);

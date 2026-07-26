import 'package:flutter_application_1/Services/todo_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todoServiceProvider = Provider<TodoService>((ref) {
  return TodoService();
});

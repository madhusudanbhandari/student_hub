import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/todo_model.dart';
import 'package:flutter_application_1/Services/todo_service.dart';

class EditTodo extends StatefulWidget {
  final Todo todo;

  const EditTodo({super.key, required this.todo});

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  // TextEditingController titleController = TextEditingController();
  // TextEditingController descriptionController = TextEditingController();
  // TextEditingController deadlineController = TextEditingController();

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController deadlineController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.todo.title);

    descriptionController = TextEditingController(
      text: widget.todo.description,
    );

    deadlineController = TextEditingController(text: widget.todo.deadline);
  }

  final TodoService todoService = TodoService();

  Future<void> updateTodo() async {
    await todoService.updateTodos(
      widget.todo.id,

      titleController.text,

      descriptionController.text,

      deadlineController.text,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit todo")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: 'Description',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: deadlineController,
              decoration: InputDecoration(
                hintText: 'Deadline',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),

          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: updateTodo,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

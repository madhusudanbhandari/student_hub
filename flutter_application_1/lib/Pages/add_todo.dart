import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/todo_service.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _HomePageState();
}

class _HomePageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();

  final TodoService todoService = TodoService();

  Future<void> addTodo() async {
    if (titleController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty ||
        deadlineController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
    }

    try {
      await todoService.addTodo(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        deadline: deadlineController.text.trim(),
      );

      titleController.clear();
      descriptionController.clear();
      deadlineController.clear();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Todo added successfully')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 234, 242, 248),
      ),
      backgroundColor: const Color.fromARGB(255, 234, 242, 248),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),

          const SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text('Enter title:'),
          ),
          const SizedBox(height: 10),

          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(width: 2, color: Colors.blue),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text('Enter description:'),
          ),
          const SizedBox(height: 10),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text('Enter Deadline:'),
          ),
          const SizedBox(height: 10),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: deadlineController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(width: 2, color: Colors.blue),
                ),
                suffixIcon: IconButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      initialDate: DateTime.now(),
                    );
                    if (picked != null) {
                      deadlineController.text =
                          "${picked.day}/${picked.month}/${picked.year}";
                    }
                  },
                  icon: Icon(Icons.calendar_month),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),

            child: SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addTodo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text('Add todo'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

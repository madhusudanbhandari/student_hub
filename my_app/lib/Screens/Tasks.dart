import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final taskController = TextEditingController();

  List<String> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tasks")),
      body: Column(
        children: [
          TextField(controller: taskController),
          ElevatedButton(
            onPressed: () {
              setState(() {
                tasks.add(taskController.text);
              });
              taskController.clear();
            },
            child: const Text("Add task"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,

              itemBuilder: (_, index) {
                return ListTile(title: Text(tasks[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}

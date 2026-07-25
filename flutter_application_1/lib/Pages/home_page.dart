import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/todo_model.dart';
import 'package:flutter_application_1/Pages/add_todo.dart';
import 'package:flutter_application_1/Pages/profile_page.dart';
import 'package:flutter_application_1/Services/todo_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Widget> pages = [HomeScreen(), AddTodoPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome'), centerTitle: true),
      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TodoService todoService = TodoService();

  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    todos = await todoService.getTodos();

    print(todos.length);
    print(todos);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Todos',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
      ),

      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];

          return Card(
            child: ListTile(
              title: Text(todo.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(todo.description), Text(todo.deadline)],
              ),
            ),
          );
        },
      ),
    );
  }
}

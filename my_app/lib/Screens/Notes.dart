import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  List<String> notes = [];
  final noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(controller: noteController),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                notes.add(noteController.text);
              });
              noteController.clear();
            },
            child: const Text("Add note"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(notes[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}

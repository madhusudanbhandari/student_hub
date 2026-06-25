import 'package:flutter/material.dart';
import '../Services/note_service.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  bool isLoading = false;

  final noteService = NoteService();

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  Future<void> note() async {
    try {
      setState(() {
        isLoading = true;
      });
      await noteService.addNote(
        title: titleController.text.trim(),
        content: contentController.text.trim(),
      );
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Notes added Successfully")));
      titleController.clear();
      contentController.clear();
    } catch (err) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(err.toString())));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  List<Map<String, dynamic>> notes = [];

  Future<void> getNotes() async {
    final response = await noteService.getNotes();

    print("Notes Response");
    print(response);

    setState(() {
      notes = response;
    });
  }

  Future<void> editNote(int id, String oldTitle, String oldContent) async {
    final titleEditController = TextEditingController(text: oldTitle);
    final contentEditController = TextEditingController(text: oldContent);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit note"),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleEditController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: contentEditController,
                decoration: const InputDecoration(labelText: "Content"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("cancel"),
            ),

            ElevatedButton(
              onPressed: () async {
                await noteService.updateNote(
                  id: id,
                  title: titleEditController.text.trim(),
                  content: contentEditController.text.trim(),
                );
                Navigator.pop(context);
              },
              child: const Text("save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "title",
              ),
            ),
            SizedBox(height: 15),

            TextField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: "Enter content",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: isLoading ? null : note,
              child: Text(isLoading ? "Loading.." : "Add note"),
            ),
            SizedBox(height: 15),

            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(notes[index]['title']),
                    subtitle: Text(notes[index]['content']),

                    leading: IconButton(
                      onPressed: () {
                        editNote(
                          notes[index]['id'],
                          notes[index]['title'],
                          notes[index]['content'],
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        await noteService.deleteNote(notes[index]['id']);
                        await getNotes();
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

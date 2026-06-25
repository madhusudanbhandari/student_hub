// Student@hub123.
import 'package:my_app/screens/Login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'Notes.dart';
import 'Tasks.dart';
import 'Profile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Hub")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Notes()),
                  );
                },
                child: const Text("notes"),
              ),
            ),
            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TasksScreen()),
                  );
                },
                child: const Text("Tasks"),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  );
                },
                child: const Text("Profile"),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                await Supabase.instance.client.auth.signOut();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}

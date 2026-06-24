import 'package:flutter/material.dart';
import 'screens/Login.dart';

void main() {
  runApp(const StudentHub());
}

class StudentHub extends StatelessWidget {
  const StudentHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Student Hub",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
    );
  }
}

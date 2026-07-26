import 'package:flutter/material.dart';

class Todo {
  final String id;
  final String title;
  final String description;
  final String deadline;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.deadline,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      deadline: json['deadline'],
    );
  }
}

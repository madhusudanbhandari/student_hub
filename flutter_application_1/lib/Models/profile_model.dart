import 'package:flutter/material.dart';

class Profile {
  final String id;
  final String name;
  final String age;
  final String address;
  final String email;

  Profile({
    required this.id,
    required this.name,
    required this.age,
    required this.address,
    required this.email,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      address: json['address'],
      email: json['email'],
    );
  }
}

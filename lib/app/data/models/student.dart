import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String id;
  final String name;
  final String username;
  final String password;
  final String role;
  final String classes;
  final String address;
  final String nis;

  Student({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.role,
    required this.classes,
    required this.address,
    required this.nis,
  });

  factory Student.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Student(
      id: doc.id,
      name: data['name']?.toString().trim() ?? '',
      username: data['username'] ?? '',
      password: data['password'] ?? '',
      role: data['role'] ?? '',
      classes: data['classes'] ?? '',
      address: data['address'] ?? '',
      nis: data['nis'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'username': username,
      'password': password,
      'role': role,
      'classes': classes,
      'address': address,
      'nis': nis,
    };
  }
}

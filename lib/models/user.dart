import 'package:flutter/material.dart';

class User {
  final int id;
  final String name;
  final String phone;
  final String gender;
  final String status;
  final int age;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.gender,
    required this.status,
    required this.age,
  });
}

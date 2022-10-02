import 'package:flutter/material.dart';

class User {
  final int id;
  final String name;
  final String phone;
  final String gender;
  final String status;
  final int age;

  User({
    this.id=0,
    this.name="",
    this.phone="",
    this.gender="",
    this.status="",
    this.age=0,
  });
}

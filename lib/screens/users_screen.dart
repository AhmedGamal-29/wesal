import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marry_me/constants/const.dart';
import 'package:marry_me/components/default_useritem.dart';
import 'package:marry_me/models/user.dart';
import 'package:marry_me/screens/webview_screen.dart';
import 'dart:io';

List<Map<String, String>> users = [
  {
    "id": "1",
    "name": 'Mariam',
    "phone": '+201115342559',
    "gender": 'female',
    "status": 'single',
    "height": "165",
    "weight": "70",
    "smoky": "no",
    "age": "24",
    "location": "Mansoura, Egypt",
  },
  {
    "id": "2",
    "name": 'Ali',
    "phone": '+201115342559',
    "gender": 'male',
    "status": 'single',
    "height": "173",
    "weight": "75",
    "smoky": "no",
    "age": "24",
    "location": "Alex, Egypt",
  },
  {
    "id": "3",
    "name": 'Ahmed',
    "phone": '+201115342559',
    "gender": 'male',
    "status": 'relationship',
    "height": "175",
    "weight": "74",
    "smoky": "yes",
    "age": "24",
    "location": "Cairo, Egypt",
  },
  {
    "id": "4",
    "name": 'Aya',
    "phone": '+201115342559',
    "gender": 'female',
    "status": 'single',
    "height": "168",
    "weight": "65",
    "smoky": "no",
    "age": "20",
    "location": "Giza, Egypt",
  },
  {
    "id": "5",
    "name": 'Mona',
    "phone": '+201115342559',
    "gender": 'female',
    "status": 'single',
    "height": "173",
    "weight": "75",
    "smoky": "no",
    "age": "22",
    "location": "Cairo, Egypt",
  },
];

class UsersScreen extends StatefulWidget {
  static const id = "users_screen";
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Users'),
        ),
      ),
      backgroundColor: Colors.blue[50],
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) =>
                  defaultUserItem(users[index], context),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 20.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              itemCount: users.length,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marry_me/constants/const.dart';
import 'package:marry_me/components/default_useritem.dart';
import 'package:marry_me/models/user.dart';

List<User> users = [
  User(
    id: 1,
    name: 'Mariam',
    phone: '+201115342559',
    gender: 'female',
  ),
  User(
    id: 2,
    name: 'Amr',
    phone: '+201117842559',
    gender: 'male',
  ),
  User(
    id: 3,
    name: 'Ali',
    phone: '+2087856136',
    gender: 'male',
  ),
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: k4Color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: k2Color,
        title: const Text('Users'),
      ),
      backgroundColor: k1Color,
      body: ListView.separated(
        itemBuilder: (context, index) => defaultUserItem(users[index]),
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
    );
  }
}

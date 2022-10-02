import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marry_me/components/default_useritem.dart';
import 'package:marry_me/constants/const.dart';
import 'package:marry_me/screens/users_screen.dart';
import 'package:marry_me/services/api.dart';
import 'package:marry_me/services/globals.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'home_screen.dart';

class FriendsScreen extends StatefulWidget {
  static const id = "friends_screen";
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, HomeScreen.id);
            },
            icon: Icon(Icons.home_rounded)),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.person))],
        title: const Center(child: Text('Your Friends')),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => defaultUserItem(users[index], context),
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

  showFriends() async {
    http.Response response = await ApiCalls.getFriends();
    var response_json = json.decode(response.body);
    for (var u in response_json) {
      Map<String, dynamic> map = {
        "name": u['name'],
        "age": u['age'],
        "gender": u['gender'],
        "martial_status": u['martial_status']
      };
      friends.add(map);
    }
  }
}

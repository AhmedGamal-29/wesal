import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marry_me/components/default_useritem.dart';
import 'package:marry_me/constants/const.dart';
import 'package:marry_me/screens/users_screen.dart';
import 'package:marry_me/screens/viewuser_screen.dart';
import 'package:marry_me/services/api.dart';
import 'package:http/http.dart' as http;

import '../services/globals.dart';
import 'home_screen.dart';

class RequestsScreen extends StatefulWidget {
  static const id = "requests_screen";
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  @override
  void initState() {
    super.initState();

    showRequests().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.home_rounded,
            size: 25,
          ),
          onPressed: () {
            Navigator.pushNamed(context, HomeScreen.id);
          },
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.person))],
        title: const Center(child: Text('Your Requests')),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
      ),
      body: users.length > 0
          ? ListView.separated(
              itemBuilder: (context, index) =>
                  defaultrequestUserItem(users[index], context),
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
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  Future showRequests() async {
    requests_recieved.clear();
    http.Response response = await ApiCalls.getRequests();
    var response_json = json.decode(response.body);
    var req_recieved = response_json['requests_received'];

    for (var u in req_recieved) {
      await getUser(id: u['sender_id']).then((value) {
        print(value);
        requests_recieved.add(value);
      });
    }
  }

  Future<Map<String, dynamic>> getUser({required id}) async {
    http.Response response = await ApiCalls.getUser(id: id);
    var u = json.decode(response.body);
    Map<String, dynamic> map = {
      "name": u['name'],
      "age": u['age'],
      "gender": u['gender'],
      "martial_status": u['martial_status'],
      "smokey": u['smoky'],
      "profession": u['profession'],
      "nationality": u['nationality'],
      "height": u['height'],
      "weight": u['weight'],
      "religion": u['religion'],
      "phone": u['phone']
    };
    return map;

    /*for(var u in req_recieved){
      Map<String,dynamic> map={
        "name":u['name'],"age":u['age']
      };
      requests.add(map);

     }*/
  }
}

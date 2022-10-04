import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:marry_me/components/default_useritem.dart';
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, HomeScreen.id);
              },
              icon: Icon(Icons.person))
        ],
        title: const Center(child: Text('Your Requests')),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
      ),
      body: requests_recieved.length > 0
          ? ListView.separated(
              itemBuilder: (context, index) =>
                  defaultrequestUserItem(requests_recieved[index], context),
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
              itemCount: requests_recieved.length,
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
      if (u['status'] == 0) {
        await getUser(id: u['sender_id']).then((value) {
          print(value);
          requests_recieved.add(value);
        });
      }
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
      "phone": u['phone'],
      "id": u['id']
    };
    return map;

    /*for(var u in req_recieved){
      Map<String,dynamic> map={
        "name":u['name'],"age":u['age']
      };
      requests.add(map);

     }*/
  }

  Future decision({required sender, required replay}) async {
    http.Response response =
        await ApiCalls.decision(sender: sender, replay: replay);
    var response_body = json.decode(response.body);
  }
}

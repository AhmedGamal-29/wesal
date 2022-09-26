import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marry_me/components/default_useritem.dart';
import 'package:marry_me/constants/const.dart';
import 'package:marry_me/screens/users_screen.dart';
import 'package:marry_me/services/api.dart';
import 'package:http/http.dart' as http;

import '../services/globals.dart';

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
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: k5Color,
        title: const Center(child: Text('Your Requests')),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => defaultrequestUserItem(requests[index]),
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
        itemCount: requests.length,
      ),
    );
  }


showRequests()async{
     http.Response response= await ApiCalls.getRequests( );
var response_json = json.decode(response.body);
     for(var u in response_json){
      Map<String,dynamic> map={
        "name":u['name'],"age":u['age']
      };
      requests.add(map);

     }

}


}

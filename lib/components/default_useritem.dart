import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marry_me/constants/const.dart';
import 'package:marry_me/models/user.dart';
import 'package:marry_me/screens/webview_screen.dart';

import '../screens/requests_screen.dart';
import '../screens/viewuser_screen.dart';
import '../services/api.dart';
import 'package:http/http.dart' as http;

Widget defaultUserItem(Map<String, dynamic> map, context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: RawMaterialButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ViewScreen(user: map)));
      },
      child: Container(
        height: 100.0,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  radius: 25.0,
                  child: map['gender'] == 'male'
                      ? const Image(
                          image: AssetImage('assets/images/male.webp'),
                        )
                      : const Image(
                          image: AssetImage('assets/images/female.webp'),
                        ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      map['name'].toString(),
                      style: const TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${map['age'].toString()} , ',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        map['martial_status'] != null
                            ? Text(
                                map['martial_status'].toString(),
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              )
                            : Text("unknown",
                                style: const TextStyle(
                                  color: Colors.grey,
                                )),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: const Icon(
                    Icons.message,
                    size: 40.0,
                    color: k1Color,
                  ),
                  onPressed: (() {
                    //chatify implementation here
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WebViewExample()));
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget defaultrequestUserItem(Map<String, dynamic> map, context,
        {Function? onAccept, Function? onReject}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: RawMaterialButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ViewScreen(user: map)));
        },
        child: Container(
          height: 100.0,
          child: Card(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CircleAvatar(
                    radius: 25.0,
                    child: map['gender'] == 'male'
                        ? const Image(
                            image: AssetImage('assets/images/male.webp'),
                          )
                        : const Image(
                            image: AssetImage('assets/images/female.webp'),
                          ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        map['name'].toString(),
                        style: const TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${map['age'].toString()} , ',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            map['martial_status'].toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.backspace,
                          size: 40.0,
                          color: Colors.redAccent,
                        ),
                        onPressed: (() {
                          //request rejected logic
                          decision(replay: -1, sender: map['id']).then((value) {
                            Navigator.pushReplacementNamed(
                                context, RequestsScreen.id);
                          });
                        }),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.beenhere,
                          size: 40.0,
                          color: Colors.greenAccent,
                        ),
                        onPressed: (() {
                          decision(replay: 1, sender: map['id']).then((value) {
                            Navigator.pushReplacementNamed(
                                context, RequestsScreen.id);
                          });
                          //request accepted logic
                        }),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

Future decision({required sender, required replay}) async {
  http.Response response =
      await ApiCalls.decision(sender: sender, replay: replay);
  var response_body = json.decode(response.body);
}

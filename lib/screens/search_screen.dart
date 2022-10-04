import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marry_me/components/default_useritem.dart';
import 'package:marry_me/constants/const.dart';
import 'package:marry_me/screens/profile_screen.dart';
import 'package:marry_me/screens/users_screen.dart';
import 'package:marry_me/services/api.dart';
import 'package:searchfield/searchfield.dart';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:http/http.dart' as http;

import '../models/user.dart';
import 'home_screen.dart';

class SearchScreen extends StatefulWidget {
  static const id = 'search_screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, dynamic>> users_found = [];
  var search_controller=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("enterd");
    //searchPressed();
    print(users_found.length);
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
        actions: [IconButton(onPressed: () {Navigator.pushNamed(context, ProfileScreen.id);}, icon: Icon(Icons.person))],
        title: Center(
            child: Text(
          'Find Your Partner',
        )),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Find your \nbest Match !',
                  style: TextStyle(
                      fontFamily: "DMSans",
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
                Image(
                  image: AssetImage("assets/images/avatar.png"),
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            Center(
              child: Container(
                  height: 47,
                  width: 306,
                  child: TextFormField(
                    controller: search_controller ,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          searchPressed().then((value) {
                            setState(() {});
                          });
                        },
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                  )),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Results',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: "OpenSans",
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: const Color(0x106750A4),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    ' ${users_found.length} users found    ',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            Flexible(
              child: ListView.separated(
                itemBuilder: (context, index) =>
                    defaultUserItem(users_found[index], context),
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
                itemCount: users_found.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future searchPressed() async {
    users_found.clear();
    http.Response response = await ApiCalls.search(name: search_controller.text);
    var response_json = json.decode(response.body);
    for (var u in response_json) {
      Map<String, dynamic> map = {
        "name": u['name'],
        "phone": u['phone'],
        "age": u['age'],
        "gender": u['gender'],
        "martial_status": u['martial_status'],
        "smokey": u['smoky'],
        "profession": u['profession'],
        "nationality": u['nationality'],
        "height": u['height'],
        "weight": u['weight'],
        "religion": u['religion'],
        "id": u['id']
      };
      users_found.add(map);
    }
  }
}

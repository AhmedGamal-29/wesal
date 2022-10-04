import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marry_me/screens/profile_screen.dart';
import 'package:marry_me/screens/requests_screen.dart';
import 'package:marry_me/screens/search_screen.dart';

import 'friends_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome, Ali"),
          leading: IconButton(
            icon: Icon(
              Icons.home_rounded,
              size: 25,
            ),
            onPressed: () {},
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, ProfileScreen.id);
                },
                icon: Icon(Icons.person))
          ],
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Center(
              child: Column(
                children: [
                  Text('Wessal',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 50.0,
                          fontFamily: "OpenSans")),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('you deserve the ',
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "DMSans",
                              fontSize: 26)),
                      Text('best ',
                          style: TextStyle(color: Colors.blue, fontSize: 26))
                    ],
                  )
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SearchScreen.id);
                      },
                      child: Text(
                        "  Search ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.pink.shade100,
                      size: 25.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                  ]),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                onTap: () {
                  Navigator.pushNamed(context, SearchScreen.id);
                },
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: const Icon(Icons.search),
                  suffixIconColor: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, FriendsScreen.id);
                        },
                        child: Text("  Friends ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold))),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.pink.shade100,
                      size: 25.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                  ]),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    Icon(
                      Icons.account_circle_sharp,
                      color: Colors.indigo,
                      size: 60.0,
                      textDirection: TextDirection.rtl,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    Icon(
                      Icons.account_circle_sharp,
                      color: Colors.blueGrey,
                      size: 60.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    Icon(
                      Icons.account_circle_sharp,
                      color: Colors.grey,
                      size: 60.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    Icon(
                      Icons.account_circle_sharp,
                      color: Colors.cyan,
                      size: 60.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    Icon(
                      Icons.account_circle_sharp,
                      color: Colors.lightBlue,
                      size: 60.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    Icon(
                      Icons.account_circle_sharp,
                      color: Colors.black26,
                      size: 60.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 80),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RequestsScreen.id);
                        },
                        child: Text("  Requests ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold))),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.pink.shade100,
                      size: 25.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                  ]),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    /*Container(
                        margin:
                        EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0, right: 12.0),
                        width: 15.0,
                        height: 15.0,),*/
                    Icon(
                      Icons.account_circle_sharp,
                      color: Colors.indigo,
                      size: 60.0,
                      textDirection: TextDirection.rtl,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    Icon(
                      Icons.account_circle_sharp,
                      color: Colors.blueGrey,
                      size: 60.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    Icon(
                      Icons.account_circle_sharp,
                      color: Colors.grey,
                      size: 60.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    Icon(
                      Icons.account_circle_sharp,
                      color: Colors.cyan,
                      size: 60.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    Icon(
                      Icons.account_circle_sharp,
                      color: Colors.lightBlue,
                      size: 60.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    Icon(
                      Icons.account_circle_sharp,
                      color: Colors.black26,
                      size: 60.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]));
  }
}

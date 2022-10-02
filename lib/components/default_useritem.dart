import 'package:flutter/material.dart';
import 'package:marry_me/constants/const.dart';
import 'package:marry_me/models/user.dart';

import '../screens/requests_screen.dart';
import '../screens/viewuser_screen.dart';

Widget defaultUserItem(Map<String,dynamic>map,context) {




  return Padding(
      padding: const EdgeInsets.all(20.0),
      child: RawMaterialButton(
        onPressed: (){ Navigator.pushNamed(context,ViewScreen.id);},
        child: Container(
          height: 100.0,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                            '${ map['age'].toString()} , ',
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
                  child: IconButton(
                    icon: const Icon(
                      Icons.message,
                      size: 40.0,
                      color: k1Color,
                    ),
                    onPressed: (() {
                      //chatify implementation here
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );}

Widget defaultrequestUserItem(Map<String,dynamic>map,context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: RawMaterialButton(
        onPressed: (){ Navigator.pushNamed(context,ViewScreen.id);} ,
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
                    child:map['gender'] == 'male'
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
                        }),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.beenhere,
                          size: 40.0,
                          color: Colors.greenAccent,
                        ),
                        onPressed: (() {
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

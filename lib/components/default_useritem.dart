import 'package:flutter/material.dart';
import 'package:marry_me/constants/const.dart';
import 'package:marry_me/models/user.dart';

Widget defaultUserItem(User user) => Padding(
      padding: const EdgeInsets.all(20.0),
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
                  child: user.gender == 'male'
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
                      user.name,
                      style: const TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${user.age.toString()} , ',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          user.status,
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
    );

Widget defaultrequestUserItem(User user) => Padding(
      padding: const EdgeInsets.all(20.0),
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
                  child: user.gender == 'male'
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
                      user.name,
                      style: const TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${user.age.toString()} , ',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          user.status,
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
    );

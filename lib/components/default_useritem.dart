import 'package:flutter/material.dart';
import 'package:marry_me/constants/const.dart';
import 'package:marry_me/models/user.dart';

Widget defaultUserItem(User user) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 100.0,
        child: Card(
          color: k5Color,
          child: Row(
            children: [
              const Expanded(
                flex: 1,
                child: CircleAvatar(
                    radius: 25.0,
                    child: Image(
                      image: AssetImage('assets/images/female.webp'),
                    )),
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
                    Text(
                      user.phone,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                flex: 1,
                child: Icon(
                  Icons.message,
                  size: 40.0,
                ),
              )
            ],
          ),
        ),
      ),
    );

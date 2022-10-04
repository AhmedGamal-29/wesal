import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marry_me/constants/const.dart';
import 'package:marry_me/screens/register_screen.dart';
import 'package:marry_me/screens/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = "welcome_screen";
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[50],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Image(
            image: AssetImage('assets/images/marryme.png'),
          ),
          DefaultTextStyle(
            style: TextStyle(color: Colors.blueAccent, fontSize: 40.0),
            child: Text('Wessal'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marry_me/screens/login_screen.dart';
import 'package:marry_me/screens/updateprofile_screen.dart';
import 'package:marry_me/screens/users_screen.dart';

import 'home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const id = "profile_screen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        title: const Text('Your Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25.0,
              child: users[1]['gender'] == 'male'
                  ? const Image(
                      image: AssetImage('assets/images/male.webp'),
                    )
                  : const Image(
                      image: AssetImage('assets/images/female.webp'),
                    ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Name: ${users[1]['name']}',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Phone: ${users[1]['phone']}',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Gender: ${users[1]['gender']}',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Age: ${users[1]['age']}',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Status: ${users[1]['status']}',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, UpdateProfile.id);
              },
              color: Colors.blue,
              child: const Text(
                'Update Your Profile',
                style: TextStyle(color: Colors.white),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              color: Colors.red,
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

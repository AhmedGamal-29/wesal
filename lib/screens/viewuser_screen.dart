import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marry_me/screens/profile_screen.dart';
import 'package:marry_me/screens/users_screen.dart';

import 'home_screen.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key});
  static const id = "view_screen";

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, ProfileScreen.id);
              },
              icon: Icon(Icons.person))
        ],
        title: const Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
              'Location: ${users[1]['location']}',
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
            Text(
              'Height: ${users[1]['height']}',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Weight: ${users[1]['weight']}',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Smoky: ${users[1]['smoky']}',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () {
                    //request logic
                  },
                  color: Colors.green,
                  child: const Text('Send a request'),
                ),
                MaterialButton(
                  onPressed: () {
                    //block logic
                  },
                  color: Colors.red,
                  child: const Text('Block this user'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marry_me/screens/profile_screen.dart';
import 'package:marry_me/screens/users_screen.dart';

import 'home_screen.dart';

class ViewScreen extends StatefulWidget {

  static const id = "view_screen";
  Map<String,dynamic> user={};
 ViewScreen({
  required this.user,
 });

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
              child:widget.user['gender'] == 'male'
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
              'Name: ${widget.user['name']}',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Phone: ${widget.user['phone']}',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Gender: ${widget.user['gender']}',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Age: ${widget.user['age']}',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Location: ${widget.user['location']}',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Status: ${widget.user['status']}',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Height: ${widget.user['height']}',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Weight: ${widget.user['weight']}',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Smoky: ${widget.user['smoky']}',
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

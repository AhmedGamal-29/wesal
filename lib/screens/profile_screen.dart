import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marry_me/screens/login_screen.dart';
import 'package:marry_me/screens/updateprofile_screen.dart';
import 'package:marry_me/screens/users_screen.dart';
import 'package:http/http.dart' as http;

import '../services/api.dart';
import 'home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const id = "profile_screen";


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("enterd");
    getProfile().then((value) {setState(() {
      
    });});
    
  }

  Map<String,dynamic> my_data={};
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
        child: !my_data.isEmpty?Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
            CircleAvatar(
              radius: 25.0,
              child: my_data['gender'] == 'male'
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
              'Name: ${my_data['name']}',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Phone: ${my_data['phone']}',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Gender: ${my_data['gender']}',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Age: ${my_data['age']}',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Status: ${my_data['status']}',
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
        ):CircularProgressIndicator(),
      ),
    );
  }

  Future getProfile()async {
     http.Response response = await ApiCalls.getProfile();
     my_data = json.decode(response.body);
     print(my_data);

  }
}

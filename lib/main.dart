import 'package:flutter/material.dart';
import 'package:marry_me/screens/login_screen.dart';
import 'package:marry_me/screens/register_screen.dart';
import 'package:marry_me/screens/welcome_screen.dart';
import 'package:marry_me/screens/users_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RegisterScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        UsersScreen.id: (context) => const UsersScreen(),
      },
    );
  }
}

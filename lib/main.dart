import 'package:flutter/material.dart';
import 'package:marry_me/screens/friends_screen.dart';
import 'package:marry_me/screens/home_screen.dart';
import 'package:marry_me/screens/login_screen.dart';
import 'package:marry_me/screens/profile_screen.dart';
import 'package:marry_me/screens/register_screen.dart';
import 'package:marry_me/screens/requests_screen.dart';
import 'package:marry_me/screens/search_screen.dart';
import 'package:marry_me/screens/updateprofile_screen.dart';
import 'package:marry_me/screens/viewuser_screen.dart';
import 'package:marry_me/screens/welcome_screen.dart';
import 'package:marry_me/screens/users_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.blue,
          elevation: 0,
          centerTitle: true,
          actionsIconTheme: IconThemeData(size: 25, color: Colors.white),
          titleTextStyle: TextStyle(
              fontFamily: 'OpenSans', color: Color(0xffffffffff), fontSize: 20),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        UsersScreen.id: (context) => const UsersScreen(),
        SearchScreen.id: (context) => SearchScreen(),
        FriendsScreen.id: (context) => const FriendsScreen(),
        RequestsScreen.id: (context) => const RequestsScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        ViewScreen.id: (context) => ViewScreen(user: {}),
        ProfileScreen.id: (context) => const ProfileScreen(),
        UpdateProfile.id: (context) => const UpdateProfile()
      },
    );
  }
}

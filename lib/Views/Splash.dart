import 'package:flutter/material.dart';
import 'package:marry_me/Views/Quiz.dart';
import 'Home.dart';
import 'Login.dart';
import 'package:provider/provider.dart';
import '../Models/UserModel.dart';
import '../View_Model/UserViewModel.dart';
import '../Models/User.dart';
import 'dart:convert';
import '../Globals.dart';
import 'VerifyEmail.dart';



class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  static const routeName = 'splash';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {


    late User myUser;
    var response = await get_user();
    Map<String,dynamic> body=jsonDecode(response.body);
    if (response.statusCode == 200) {

      myUser = User.fromJson(body);
      print("/////////////////////////////////////////////");
      print(myUser.VIP);
      userVip=myUser.VIP;
      final user = Provider.of<MyModel>(context, listen: false);
      user.setPerson(myUser);
      print(user.getPerson());
      print(user.getPerson().email);
      Navigator.pushReplacementNamed(context, Home.routeName);
      // return myUser;
    }
    else if (body['message']=="Not all the questions are answered")
      {
        Navigator.pushReplacementNamed(context, Quiz.routeName);
      }
    else
      {
        Navigator.pushReplacementNamed(context, VerifyEmail.routeName);
      }

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/marryme.png', width: 200, height: 200),
        ],
      ),
    );
  }
}

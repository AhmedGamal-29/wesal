import 'dart:convert';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:marry_me/constants/const.dart';
import 'package:marry_me/components/default_button';
import 'package:marry_me/components/default_formfield';
import 'package:marry_me/screens/requests_screen.dart';
import 'package:marry_me/screens/search_screen.dart';
import 'package:marry_me/screens/users_screen.dart';
import 'package:marry_me/screens/register_screen.dart';
import 'package:http/http.dart' as http;
import 'package:marry_me/services/auth_services.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const id = "login_screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Validate the data entered from user in the form
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //bool isPassword = AppCubit().isPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Center(child: const Text('Login')),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue[50],
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/marryme.png')),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50.0),
                    topLeft: Radius.circular(50.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    kDefaultFormField(
                      label: 'Email',
                      keyboard: TextInputType.emailAddress,
                      prefix: Icons.email,
                      controller: emailController,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!value.toString().contains('@') ||
                            !value.toString().contains('.')) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                    ),
                    kDefaultFormField(
                      label: 'Password',
                      prefix: Icons.lock,
                      //suffix: AppCubit().suffix,
                      controller: passwordController,
                      //isPassword: isPassword,
                      /*isSuffixPressed: () {
                              AppCubit().changePasswordVisibility();
                            },*/
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value
                            .toString()
                            .length < 8) {
                          return 'Your password must be 8 characters or more';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        kDefaultButton(
                          backgroundColor: Colors.blue,
                          label: 'Register',
                          onPressed: () {
                            Navigator.pushNamed(context, RegisterScreen.id);
                          },
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        kDefaultButton(
                            backgroundColor: Colors.blue,
                            label: 'Login',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                loginPressed();

                              }
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  loginPressed() async {
    http.Response response = await AuthServices.login(
        email: emailController.text, password: passwordController.text);
    Map response_map = json.decode(response.body);
    if (response.statusCode == 200) {

      Navigator.pushReplacementNamed(
          context,
          HomeScreen.id
      );
    }
  }
}
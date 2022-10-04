import 'dart:convert';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:marry_me/constants/const.dart';
import 'package:marry_me/screens/home_screen.dart';
import 'package:marry_me/screens/users_screen.dart';
import 'package:marry_me/screens/welcome_screen.dart';
import 'package:marry_me/components/default_button';
import 'package:marry_me/components/default_formfield';
import 'package:http/http.dart' as http;
import 'package:marry_me/services/auth_services.dart';

class RegisterScreen extends StatefulWidget {
  static const id = "register_screen";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var birthdateController = TextEditingController();
  var ageController = TextEditingController();
  var statusController = TextEditingController();
  var genderController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Register'),
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue[50],
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SizedBox(
                child: Image.asset('assets/images/marryme.png'),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50.0),
                    topLeft: Radius.circular(50.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kDefaultFormField(
                        label: 'Full Name',
                        controller: nameController,
                        prefix: Icons.account_circle_rounded,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Name must not be Empty';
                          } else if (value.toString().length < 10) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      kDefaultFormField(
                        label: 'Email Address',
                        controller: emailController,
                        prefix: Icons.email,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!value.toString().contains('@') ||
                              !value.toString().contains('.')) {
                            return 'Please enter valid email';
                          }
                          return null;
                        },
                        keyboard: TextInputType.emailAddress,
                      ),
                      kDefaultFormField(
                        label: 'Phone',
                        controller: phoneController,
                        prefix: Icons.phone,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Phone must not be Empty';
                          } else if (value.toString().length < 11) {
                            return 'Please enter valid phone number';
                          }
                          return null;
                        },
                        keyboard: TextInputType.phone,
                      ),
                      kDefaultFormField(
                        label: 'Password',
                        controller: passwordController,
                        prefix: Icons.lock,
                        //suffix: AppCubit().suffix,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.toString().length < 8) {
                            return 'Your password must be 8 characters or more';
                          }
                          return null;
                        },

                        keyboard: TextInputType.visiblePassword,
                      ),
                      kDefaultFormField(
                        label: 'Confirm Password',
                        controller: confirmPasswordController,
                        //isPassword: AppCubit().isConfPassword,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password ';
                          } else if (value.toString() !=
                              passwordController.text) {
                            return "Password is not match";
                          }
                          return null;
                        },
                        keyboard: TextInputType.visiblePassword,
                        prefix: Icons.lock,
                      ),
                      kDefaultFormField(
                        label: 'Birth date (YYYY/MM/DD)',
                        controller: birthdateController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your birthdate';
                          }
                          return null;
                        },
                        prefix: Icons.child_care,
                      ),
                      kDefaultFormField(
                        label: 'Age',
                        controller: ageController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your age';
                          }
                          return null;
                        },
                        prefix: Icons.person,
                      ),
                      kDefaultFormField(
                        label: 'Marital Status',
                        controller: statusController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your marital status';
                          }
                          return null;
                        },
                        prefix: Icons.family_restroom,
                      ),
                      kDefaultFormField(
                        label: 'Gender {male, female}',
                        controller: genderController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your gender';
                          } else if (value != 'male' && value != 'female') {
                            return 'Please make sure of your gender';
                          }
                          return null;
                        },
                        prefix: Icons.people,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          kDefaultButton(
                              label: 'Register',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  registerPressed();
                                }
                              }),
                          const SizedBox(
                            width: 10.0,
                          ),
                          kDefaultButton(
                            label: 'Login',
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  registerPressed() async {
    http.Response response = await AuthServices.register(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      confirm_password: confirmPasswordController.text,
      date: birthdateController.text,
      gender: genderController.text,
      phone: phoneController.text,
      status: statusController.text,
    );

    Map response_map = json.decode(response.body);
    if (response.statusCode == 200) {
      Navigator.pushNamed(context, HomeScreen.id);
    }
  }
}

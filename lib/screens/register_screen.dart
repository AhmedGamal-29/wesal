import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:marry_me/constants/const.dart';
import 'package:marry_me/screens/welcome_screen.dart';
import 'package:marry_me/components/default_button';
import 'package:marry_me/components/default_formfield';

class RegisterScreen extends StatefulWidget {
  static const id = "register_screen";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var genderController = TextEditingController();
  var ageController = TextEditingController();
  var birthController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: k4Color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: k2Color,
        title: const Text('Register'),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: k1Color,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SizedBox(
                child: Image.asset('assets/images/marr.png'),
              ),
            ),
            Expanded(
              flex: 2,
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
                        label: 'Age',
                        controller: ageController,
                        prefix: Icons.timeline,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Age must not be Empty';
                          } else if (value < 18) {
                            return 'must be older than 18';
                          }
                          return null;
                        },
                        keyboard: const TextInputType.numberWithOptions(
                          signed: false,
                          decimal: false,
                        ),
                      ),
                      kDefaultFormField(
                        label: 'Gender {male or female}',
                        controller: genderController,
                        prefix: Icons.person,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Gender must not be Empty';
                          } else if (value.toString() != 'male' &&
                              value.toString() != 'female') {
                            return 'Please enter male or female only';
                          }
                          return null;
                        },
                      ),
                      kDefaultFormField(
                        label: 'Birth Date (1990-07-03)',
                        controller: birthController,
                        prefix: Icons.child_care,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Birth must not be Empty';
                          }
                          return null;
                        },
                        keyboard: TextInputType.datetime,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          kDefaultButton(
                              label: 'Register',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  //
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
}

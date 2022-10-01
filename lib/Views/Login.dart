import 'package:flutter/material.dart';
import 'package:marry_me/Views/Splash.dart';
import '../Globals.dart';
import 'ForgotPassword.dart';
import 'Signup.dart';
import 'package:email_validator/email_validator.dart';
import '../View_Model/auth_view_model.dart';
import 'package:provider/provider.dart';
import '../Models/UserModel.dart';



// void main() {
//   runApp(Login());
// }

class Login extends StatefulWidget {
  static const routeName = 'Login';

  @override
  _LoginState createState() => _LoginState();
}

FocusNode f1 = FocusNode();
FocusNode f2 = FocusNode();


class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _hidePassword = true;
  bool? _rememberMe = false;
  String _email="";
  String _password="";
  bool _invalidAlert=false;

  login(String email, String password, bool? rememberMe) async
  {
    var response;
    var responseBody;
      response= await userLogin(email.trim(), password, rememberMe);
      responseBody= response.data;
    if (response.statusCode == 200) {
      setState(() {
        _invalidAlert=false;
      });
      final user = Provider.of<MyModel>(context, listen: false);
      user.authUser();
      user.setToken(responseBody['AccessToken']);
      KUserToken = responseBody['AccessToken'];

      Navigator.pushReplacementNamed(context, Splash.routeName);

    }
    else
    {
      print(response.statusCode);
      setState(() {
        _invalidAlert=true;
      });
    }
  }


  @override
  void initState() {
    f1.addListener(() {
      if (!f1.hasFocus) setState(() {});
    });
    f2.addListener(() {
      if (!f2.hasFocus) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async =>false,
        child:SafeArea(
          child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 30.0, right: 20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/images/marryme.png'),
                        width: 90.0,
                        height: 90.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                      "تسجيل الدخول في وصال",
                      style: TextStyle(fontSize: 20,
                          color:  Color(0xffff6265),
                          // Color(0xfff4A494A),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans'),
                    ),

                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Visibility(
                    visible: _invalidAlert,
                    child: Container(
                      width: 370.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          border: Border.all(
                            color: Colors.red.shade100,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Center(
                        child: Text(
                          "ايميل او كلمة مرور خاطئة",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: double.infinity,
                    child: Directionality(
                        textDirection: TextDirection.rtl,
                      child: TextFormField(
                          focusNode: f1,
                          enableSuggestions: false,
                          autocorrect: false,
                          cursorColor: Color(0xffff6265),
                          decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 18.0, horizontal: 9.0),
                            labelText: 'الايميل',
                            labelStyle: TextStyle(
                                color: f1.hasFocus ? Color(0xffff6265) : Colors
                                    .grey
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffff6265)
                                )
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              FocusScope.of(context).requestFocus(f1);
                            });
                          },
                          onChanged: (email) {
                            _email= email;
                          },
                          onFieldSubmitted: (email) {
                            // if (_formKey.currentState!.validate()) {}
                            FocusScope.of(context).requestFocus(f2);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'مطلوب';

                            }
                            else if (EmailValidator.validate(value.trim())==false)
                            {
                              return 'صيغة ايميل خاطئة';
                            }
                            return null;
                          }
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: double.infinity,
                    // height: 50.0,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        focusNode: f2,
                        enableSuggestions: false,
                        autocorrect: false,
                        cursorColor: Color(0xffff6265),
                        obscureText: _hidePassword,
                        decoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 18.0, horizontal: 9.0),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: this._hidePassword
                                  ? Colors.grey
                                  : Color(0xffff6265),
                            ),
                            onPressed: () {
                              setState(
                                      () => this._hidePassword = !this._hidePassword);
                            },
                          ),
                          labelText: 'كلمة المرور',
                          labelStyle: TextStyle(
                              color:
                              f2.hasFocus ? Color(0xffff6265) : Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffff6265)),
                          ),
                        ),
                        onChanged: (password) {
                          //TODO: Set Password Variable, and toggle the Invalid alert
                          _password=password;
                        },
                        onFieldSubmitted: (password) {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _invalidAlert=false;
                              login(_email,_password,_rememberMe);
                            });

                          }

                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'مطلوب';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                            width:30.0
                        ),
                        InkWell(
                          child: Text(
                            'نسيت كلمة المرور؟',
                            style: TextStyle(fontSize: 12,
                                color: Color(0xffff6265),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans'),
                          ),
                          onTap: () {
                            // TODO: Navigate to Forgot Password Page
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ForgotPassword()));
                          },
                        ),
                        SizedBox(
                            width:140.0
                        ),

                        Text(
                          "تذكرني",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontFamily: 'OpenSans'),
                        ),
                        Checkbox(
                          value: _rememberMe,
                          // checkColor:Color(0xffff6265),
                          activeColor: Color(0xffff6265),
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value;
                            });
                          },
                        ),



                      ]
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    width: 330.0,
                    height: 45.0,
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _invalidAlert=false;
                            login(_email,_password,_rememberMe);
                          });

                        }
                      },
                      child: Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Color(0xffff6265),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),

                  InkWell(
                    child: Text(
                      'انشاء حساب جديد',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xffff6265),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans'),
                    ),
                    onTap: () {
                      // TODO: Navigate to Sign Up page
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Signup()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
       )
    );
  }
}

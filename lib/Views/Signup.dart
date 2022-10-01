import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../View_Model/auth_view_model.dart';
import 'package:provider/provider.dart';
import '../Models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'Splash.dart';

// void main() {
//   runApp(Signup());
// }

// class Try extends StatefulWidget {
//   @override
//   _TryState createState() => _TryState();
// }
//
// class _TryState extends State<Try> {
//   @override
//   Widget build(BuildContext? context) {
//     return MaterialApp (
//       home:Signup(),
//     );
//   }
// }

class Signup extends StatefulWidget {
  static const routeName = 'SignUp';

  @override
  _SignupState createState() => _SignupState();
}

FocusNode f1 = FocusNode();
FocusNode f2 = FocusNode();
FocusNode f3 = FocusNode();
FocusNode f4 = FocusNode();
FocusNode f5 = FocusNode();
FocusNode f6 = FocusNode();
FocusNode f7 = FocusNode();
FocusNode f8 = FocusNode();
FocusNode f9 = FocusNode();

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Object? _gender = 0;
  String _day="";
  String _month="";
  String _year="";
  String? _email = "";
  String _password="";
  String _confirmPassword="";
  String? _username="";
  String? _phoneNumber="";
  bool _hidePassword = true;
  String _date="";
  bool _passCheck=false;
  String age='غير مسموح لمن اقل من 18 عام بالتسجيل';
  String device="تم استخدام هذا الجهاز لانشاء حساب من قبل";
  String label1="شرط العمر";
  String label2="حدث خطأ ما";
  TextEditingController _emailController= TextEditingController(text:"");
  TextEditingController _usernameController= TextEditingController(text:"");
  TextEditingController _phoneNumberController= TextEditingController(text:"");


  Future<UserCredential> signInWithGoogle() async {
    // Initiate the auth procedure
    final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: <String>["email"]).signIn();

    // fetch the auth details from the request made earlier
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential for signing in with google
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  checkAge() async
  {
    if (_month.length==1)
    {
      _month= "0"+_month;
      // print(_month);
    }
    if (_day.length==1)
    {
      _day= "0"+_day;
      // print(_day);
    }

    _date="$_year"+"-"+"$_month"+"-"+"$_day";
    DateTime birthDate = DateTime.parse(_date);
    // print(birthDate);

    DateTime today = DateTime.now();
    // print(today);

    // Date to check but moved 18 years ahead
    DateTime adultDate = DateTime(
      birthDate.year + 18,
      birthDate.month,
      birthDate.day,
    );

    bool check = adultDate.isBefore(today);

    if (check==false)
    {
      alert(context,age,label1);
    }
    else
    {
      print("==================> API Call");
      String gender = _gender== 0 ? "female" : "male";
      // print(gender);
      var response;
      var responseBody;
      response= await  signUp(_username!.trim(),_email!.trim(),_phoneNumber,_password,gender,_date,_confirmPassword);
      responseBody= response.data;
      if (response.statusCode==201)
      {
        final user = Provider.of<MyModel>(context, listen: false);
        user.authUser();
        user.setToken(responseBody['AccessToken:']);
        //TODO: Redirect to Splash Screen
        Navigator.pushReplacementNamed(context, Splash.routeName);
      }
      else if (response.statusCode==403)
      {
        alert(context,device,label2);
      }
    }

  }

//TODO: COMPLETE RESPONSES
  googleSignUp() async
  {
    // print("ANA F AWEL EL FUNCTIOOON");
    final googleSignIn = GoogleSignIn();
    GoogleSignInAccount? _user;
    final googleUser= await googleSignIn.signIn();

    final googleAuth=await googleUser!.authentication;

    // if (googleUser == null) return;
    _user= googleUser;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    print("GOOGLE AUTHENTICATED");
    // print("TOKEN:");
    // print(user.getToken());
    final us = FirebaseAuth.instance.currentUser!;
    // print(us.displayName);
    // print(us.email);
    // print(us.phoneNumber);
    _username=us.displayName;
    _email=us.email;
    _phoneNumber=us.phoneNumber;
    setState(() {
      _emailController= TextEditingController(text:_email);
      _usernameController= TextEditingController(text:_username);
      _phoneNumberController= TextEditingController(text:_phoneNumber);
    });
  }

  alert(BuildContext context, String alert, String label) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(label),
            content: Text(
                alert),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('تم'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color(0xffff6265),
                ),
              ),
            ],
          );
        });
  }

  @override
  void initState()
  {

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 40.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.chevron_left),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Image(
                          image: AssetImage('assets/images/marryme.png'),
                          width: 100.0,
                          height: 100.0,
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "انشاء حساب جديد",
                          style: TextStyle(
                              fontSize: 17,
                              color: Color(0xffff6265),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Row(children: <Widget>[
                      SizedBox(width: 5.0),
                      Container(
                        // padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        width: 180.0,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // thirdPartySignUp(0);
                          },
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0.0),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical: 9.0, horizontal: 5.0)),
                            backgroundColor:
                            MaterialStateProperty.all(Colors.blue),
                          ),
                          icon: FaIcon(
                            FontAwesomeIcons.facebook,
                          ),
                          label: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              'انشاء حساب ب Facebook',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        width: 170.0,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // thirdPartySignUp(1);
                            googleSignUp();
                            // signInWithGoogle();
                          },
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0.0),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical: 9.0, horizontal: 5.0)),
                            backgroundColor:
                            MaterialStateProperty.all(Color(0xffff6265)),
                          ),
                          icon: FaIcon(
                            FontAwesomeIcons.googlePlus,
                          ),
                          label: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              'انشاء حساب ب Google',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 30.0,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                          focusNode: f1,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: _usernameController,
                          cursorColor: Color(0xffff6265),
                          decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 18.0, horizontal: 9.0),
                            labelText: 'اسم المستخدم',
                            labelStyle: TextStyle(
                                color: f1.hasFocus
                                    ? Color(0xffff6265)
                                    : Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffff6265))),
                          ),
                          onTap: () {
                            setState(() {
                              FocusScope.of(context).requestFocus(f1);
                            });
                          },
                          onChanged: (username) {
                            _username = username;
                          },
                          onFieldSubmitted: (username) {
                            f2.requestFocus();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'مطلوب';
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                            focusNode: f2,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: _emailController,
                            cursorColor: Color(0xffff6265),
                            decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 18.0, horizontal: 9.0),
                              labelText: 'الايميل',

                              labelStyle: TextStyle(
                                  color: f2.hasFocus
                                      ? Color(0xffff6265)
                                      : Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffff6265))),
                            ),
                            onTap: () {
                              setState(() {
                                FocusScope.of(context).requestFocus(f2);
                              });
                            },
                            onChanged: (email) {
                              _email = email;
                            },
                            onFieldSubmitted: (email) {
                              FocusScope.of(context).requestFocus(f3);
                              _email = email;
                            },
                            validator: (email) {
                              if (email == null || email.isEmpty) {
                                return 'مطلوب';
                              } else if (EmailValidator.validate(_email!.trim()) ==
                                  false) {
                                return 'صيغة ايميل خاطئة';
                              }
                              return null;
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                            focusNode: f3,
                            enableSuggestions: false,
                            autocorrect: false,
                            cursorColor: Color(0xffff6265),
                            obscureText: _hidePassword,
                            decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 18.0, horizontal: 9.0),
                              labelText: 'كلمة المرور',
                              labelStyle: TextStyle(
                                  color: f3.hasFocus
                                      ? Color(0xffff6265)
                                      : Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: this._hidePassword
                                      ? Colors.grey
                                      : Color(0xffff6265),
                                ),
                                onPressed: () {
                                  setState(() =>
                                  this._hidePassword = !this._hidePassword);
                                },
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffff6265))),
                            ),
                            onTap: () {
                              setState(() {
                                FocusScope.of(context).requestFocus(f3);
                              });
                            },
                            onChanged: (pass) {
                              _password = pass;
                            },
                            onFieldSubmitted: (pass) {
                              // if (_formKey.currentState!.validate()) {}
                              FocusScope.of(context).requestFocus(f4);

                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                _passCheck=false;
                                return 'مطلوب';
                              }
                              else if (_password.length < 8)
                              {
                                _passCheck=false;
                                return "يجب لكلمة المرور ان تكون 8 احرف علي الاقل";
                              }
                              _passCheck=true;
                              return null;
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                            focusNode: f4,
                            enableSuggestions: false,
                            autocorrect: false,
                            cursorColor: Color(0xffff6265),
                            obscureText: _hidePassword,
                            decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 18.0, horizontal: 9.0),
                              labelText: 'تأكيد كلمة المرور',
                              labelStyle: TextStyle(
                                  color: f4.hasFocus
                                      ? Color(0xffff6265)
                                      : Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffff6265))),
                            ),
                            onTap: () {
                              setState(() {
                                FocusScope.of(context).requestFocus(f4);
                              });
                            },
                            onChanged: (confirmPass) {
                              _confirmPassword = confirmPass;
                            },
                            onFieldSubmitted: (email) {
                              // if (_formKey.currentState!.validate()) {}
                              FocusScope.of(context).requestFocus(f5);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'مطلوب';
                              } else if (_password != _confirmPassword &&  _passCheck==true) {
                                return 'كلمات المرور غير متطابقة';
                              }
                              return null;
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                            focusNode: f5,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: _phoneNumberController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            cursorColor: Color(0xffff6265),
                            decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 18.0, horizontal: 9.0),
                              labelText: 'رقم التليفون',
                              labelStyle: TextStyle(
                                  color: f5.hasFocus
                                      ? Color(0xffff6265)
                                      : Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffff6265))),
                            ),
                            onTap: () {
                              setState(() {
                                FocusScope.of(context).requestFocus(f5);
                              });
                            },
                            onChanged: (phone) {
                              _phoneNumber = phone;
                            },
                            onFieldSubmitted: (phone) {
                              // if (_formKey.currentState!.validate()) {}
                              FocusScope.of(context).requestFocus(f6);

                            },
                            validator: (phone) {
                              if (phone == null || phone.isEmpty) {
                                return 'مطلوب';
                              }
                              else if ((phone.trim()).startsWith('0')!=true || (phone.trim()).length !=11)
                              {
                                return "صيغة رقم تليفون غير صحيحة";
                              }
                              return null;
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 320.0),
                        width: double.infinity,
                        child: Text(
                          "النوع",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xffff6265),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans'),
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Row(
                          children: <Widget>[
                        SizedBox(width: 70.0),
                        Text(
                            "انثى",
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              // color: Colors.blueGrey,
                              fontSize: 15.0,
                            )),
                        Radio(
                          value: 0,
                          groupValue: _gender,
                          activeColor: Color(0xffff6265),
                          onChanged: (value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                        SizedBox(width: 100.0),
                        Text("ذكر",
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              // color: Colors.blueGrey,
                              fontSize: 15.0,
                            )),
                        Radio(
                          value: 1,
                          groupValue: _gender,
                          activeColor: Color(0xffff6265),
                          onChanged: (value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                        padding: EdgeInsets.only(left:  280.0),
                        width: double.infinity,
                        child: Text(
                          "تاريخ الميلاد",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xffff6265),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans'),
                        )),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 20.0),
                        Container(
                          width: 100.0,
                          // height:60.0,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                                focusNode: f6,
                                enableSuggestions: false,
                                autocorrect: false,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                cursorColor: Color(0xffff6265),
                                decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 9.0),
                                  labelText: 'اليوم',
                                  labelStyle: TextStyle(
                                      color: f6.hasFocus
                                          ? Color(0xffff6265)
                                          : Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xffff6265))),
                                ),
                                onTap: () {
                                  setState(() {
                                    FocusScope.of(context).requestFocus(f6);
                                  });
                                },
                                onChanged: (day) {

                                  _day = day;
                                },
                                onFieldSubmitted: (day) {
                                  // if (_formKey.currentState!.validate()) {}
                                  FocusScope.of(context).requestFocus(f7);

                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مطلوب';
                                  } else if (int.parse(value) < 1 ||
                                      int.parse(value) > 31) return 'يوم غير صحيح';
                                  return null;
                                }),
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Container(
                          width: 90.0,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                                focusNode: f7,
                                enableSuggestions: false,
                                autocorrect: false,
                                cursorColor: Color(0xffff6265),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 9.0),
                                  labelText: 'الشهر',
                                  labelStyle: TextStyle(
                                      color: f7.hasFocus
                                          ? Color(0xffff6265)
                                          : Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xffff6265))),
                                ),
                                onTap: () {
                                  setState(() {
                                    FocusScope.of(context).requestFocus(f7);
                                  });
                                },
                                onChanged: (month) {

                                  _month = month;
                                },
                                onFieldSubmitted: (month) {
                                  // if (_formKey.currentState!.validate()) {}
                                  FocusScope.of(context).requestFocus(f8);

                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مطلوب';
                                  } else if (int.parse(value) < 1 ||
                                      int.parse(value) > 12)
                                    return 'شهر غير صحيح';
                                  return null;
                                }),
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Container(
                          width: 100.0,
                          // height: 60.0,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                                focusNode: f8,
                                enableSuggestions: false,
                                autocorrect: false,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                cursorColor: Color(0xffff6265),
                                decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 9.0),
                                  labelText: 'السنة',
                                  labelStyle: TextStyle(
                                      color: f8.hasFocus
                                          ? Color(0xffff6265)
                                          : Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xffff6265))),
                                ),
                                onTap: () {
                                  setState(() {
                                    FocusScope.of(context).requestFocus(f8);
                                  });
                                },
                                onChanged: (year) {
                                  _year = year;
                                },
                                onFieldSubmitted: (year) {
                                  setState(() {
                                    if (_formKey.currentState!.validate()) {
                                      checkAge();
                                    }

                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مطلوب';
                                  } else if (int.parse(value) < 1950 ||
                                      int.parse(value) > DateTime.now().year)
                                    return 'سنة غير صحيحة';
                                  return null;
                                }),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      width: 270.0,
                      height: 45.0,
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            checkAge();
                          }
                          setState(() {});
                        },
                        child: Text(
                          "انشاء الحساب",
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
                  ]),
                ),
              ))),
    );
    // );
  }
}
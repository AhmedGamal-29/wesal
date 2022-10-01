import 'package:flutter/material.dart';
import 'Login.dart';

void main() {
  runApp(Try());
}

class Try extends StatefulWidget {
  @override
  _TryState createState() => _TryState();
}

class _TryState extends State<Try> {
  @override
  Widget build(BuildContext? context) {
    return MaterialApp (
      home:ResetPassword(),
    );
  }
}

FocusNode f1 = FocusNode();
FocusNode f2 = FocusNode();


class ResetPassword extends StatefulWidget {
  static const routeName = 'ResetPassword';
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final _formKey = GlobalKey<FormState>();
  String? _password="";
  String? _confirmPassword="";
  bool _invalidAlert=true;
  bool _isDisabled=false;
  bool _hidePassword=true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left:20.0, right:20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/images/marryme.png'),
                        width: 100.0,
                        height: 100.0,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Reset Password",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xffff6265),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans'),
                      ),
                    ],
                  ),
                  Visibility(visible: _invalidAlert, child: SizedBox(height: 30.0)),
                  Visibility(
                    visible: _invalidAlert,
                    child: Container(
                      width: 370.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                          color: Colors.greenAccent.shade100,
                          border: Border.all(
                            color: Colors.greenAccent.shade100,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Center(
                        child: Text(
                          "Password is reset successfully",
                          style: TextStyle(color: Colors.grey.shade800),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
              TextFormField(
                  focusNode: f1,
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: _hidePassword,
                  cursorColor: Color(0xffff6265),
                  decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 9.0),
                    labelText: 'New Password',
                    labelStyle: TextStyle(
                        color: f1.hasFocus
                            ? Color(0xffff6265)
                            : Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(8.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Color(0xffff6265))),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: _hidePassword
                            ? Colors.grey
                            : Color(0xffff6265),
                      ),
                      onPressed: () {
                        setState(
                                () =>_hidePassword = !_hidePassword);
                      },
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      FocusScope.of(context).requestFocus(f1);
                    });
                  },
                  onChanged: (newPassword) {
                    _password=newPassword;

                  },
                  onFieldSubmitted: (newPassword) {
                    FocusScope.of(context).requestFocus(f2);

                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  }),
                  SizedBox(
                    height: 30.0
                  ),
                  TextFormField(
                      focusNode: f2,
                      enableSuggestions: false,
                      autocorrect: false,
                      cursorColor: Color(0xffff6265),
                      obscureText: _hidePassword,
                      decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 18.0, horizontal: 9.0),
                        labelText: 'Confirm New Password',
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
                      onChanged: (confirmPassword) {
                       _confirmPassword=confirmPassword;
                      },
                      onFieldSubmitted: (confirmPassword) {
                        if (_formKey.currentState!.validate()) {
                            //TODO: Call API
                        }

                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        else if (_password!=_confirmPassword && _password!="" && _confirmPassword!="")
                          {
                            return "Passwords do not match";
                          }
                        return null;
                      }),
                  SizedBox(
                    height:40.0
                  ),
                  Container(
                    width: 330.0,
                    height: 45.0,
                    child: TextButton(
                      onPressed: _isDisabled ? null : () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            //TODO: Call API
                            _invalidAlert=true;
                          });
                        }

                      },

                      child: Text(
                        "Reset Password",
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
                    height: 40.0
                  ),
                  Visibility(
                    visible: _invalidAlert,
                    child: InkWell(
                      child: Text(
                        'Go to the Login Page',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xffff6265),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans'),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                    ),
                  )
                ]
              ),
            )
          )
        )
      ),
    );
  }
}



import 'package:flutter/material.dart';
import '../View_Model/auth_view_model.dart';
import 'package:email_validator/email_validator.dart';

void main() {
  runApp(ForgotPassword());
}

class ForgotPassword extends StatefulWidget {
  static const routeName = 'ForgotPassword';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

FocusNode f1 = FocusNode();

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  String _email="";
  bool _successAlert=false;
  bool _isDisabled=false;

  forgot() async
  {
    var response;
    var responseBody;
    response= await forgotPassword(_email.trim());
    responseBody= response.data;
    if (response.statusCode== 200)
      {
        setState(() {
          _successAlert=true;
          _isDisabled=true;
        });
      }
    else
      {
        print("حدث خطأ ما");
      }

  }

  @override
  void initState() {
    f1.addListener(() {
      if (!f1.hasFocus) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                      Icon(
                        Icons.mail_outline_outlined,
                        color: Color(0xffff6265),
                        size: 35.0,
                      ),
                      SizedBox(height: 30.0),
                      Text("من فضلك ادخل الايميل الخاص بك",
                          style: TextStyle(
                              fontFamily: 'Urbanist',
                              color: Colors.black54,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                      Text("و سوف نرسل لك الخطوات لاعادة ضبط",
                          style: TextStyle(
                              fontFamily: 'Urbanist',
                              color: Colors.black54,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                      Text("كلمة المرور",
                          style: TextStyle(
                              fontFamily: 'Urbanist',
                              color: Colors.black54,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),

                      Visibility(visible: _successAlert, child: SizedBox(height: 30.0)),
                      Visibility(
                        visible: _successAlert,
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
                              "تم ارسال الايميل بنجاح",
                              style: TextStyle(color: Colors.grey.shade800),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Container(
                        width: 370.0,
                        // height: 50.0,
                        constraints: BoxConstraints(
                          maxHeight: 80.0,
                          minHeight: 80.0,
                        ),
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
                              ),
                              onTap: () {
                                setState(() {
                                  FocusScope.of(context).requestFocus(f1);
                                });
                              },
                              onChanged: (email) {
                                _email=email;
                              },
                              onFieldSubmitted: (email) {
                                print(_email.trim());
                                if (_formKey.currentState!.validate()) {
                                  // _successAlert=true;
                                  forgot();
                                }

                              },
                              validator: (email) {
                                if (email == null || email.isEmpty) {
                                  return 'مطلوب';
                                }
                                else if (!EmailValidator.validate(email.trim()))
                                  {
                                    return 'صيغة ايميل خاطئة';
                                  }
                                return null;
                              }),
                        ),
                      ),
                      SizedBox(height: 50.0),
                      Container(
                        width: 350.0,
                        height: 45.0,
                        child: TextButton(
                          onPressed: _isDisabled ? null : () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                //TODO: Call API
                                forgot();
                                // _successAlert=true;
                                // _isDisabled=true;
                              });
                            }

                          },
                          child: Text(
                            "ارسل الايميل",
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
                    ],
                  ),
                ))),
      ),
    );
  }
}

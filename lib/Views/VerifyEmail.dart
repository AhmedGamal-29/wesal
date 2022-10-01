import 'package:flutter/material.dart';

import 'Login.dart';

class VerifyEmail extends StatefulWidget {
  static const routeName = 'VerifyEmail';

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Row(children: <Widget>[
              Image(
                image: AssetImage('assets/images/marryme.png'),
                width: 100.0,
                height: 100.0,
              ),
            ]),
            SizedBox(height: 20.0),
            Icon(
              Icons.mark_email_read_outlined,
              color: Color(0xffff6265),
              size: 35.0,
            ),
            SizedBox(height: 30.0),
            Text("لقد ارسلنا لك رسالة علي الايميل الخاص بك",
                style: TextStyle(fontSize: 18.0, fontFamily: 'Urbanist')),
            SizedBox(height: 6.0),
            Text("من فضلك اتبع الخطوات الموجودة بالرسالة",
                style: TextStyle(fontSize: 18.0, fontFamily: 'Urbanist')),
            SizedBox(height: 6.0),
            Text("لتفعيل حسابك",
                style: TextStyle(fontSize: 18.0, fontFamily: 'Urbanist')),
            SizedBox(height: 40.0),
            InkWell(
              child: Text(
                'العودة لصفحة تسجيل الدخول',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xffff6265),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans'),
              ),
              onTap: () {
                // TODO: Navigate to Login Page
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) => Login()));
                Navigator.pushReplacementNamed(context, Login.routeName);
                // Navigator.of(context).pop();
              },
            ),
          ],
      ),
    ),
        ));
  }
}

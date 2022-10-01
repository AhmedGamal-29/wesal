import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:marry_me/Utility/Themes.dart';
import 'package:marry_me/Views/Home.dart';
import 'package:marry_me/Views/Profile.dart';

import 'Edit.dart';

/*AppBar profileAppBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    elevation: 1,
    backgroundColor: lightTheme.backgroundColor,
    title: Text(
      "انت",
      style: TextStyle(
          color: Colors.grey,
          fontSize: 18,
          fontFamily: 'openSans',
          fontStyle: FontStyle.italic),
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: () => {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) {
              return EditProfile(Profile.question_id); // Block instead chat
            },
          ))
        },
      )
    ],
  );
}*/

/*AppBar UsersProfileAppBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    elevation: 1,
    backgroundColor: lightTheme.backgroundColor,
    actions: [
      IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
            return Home(); // Block instead chat
          }))
        },
      ),
    ],

  );
}*/

AppBar EditProfileAppBar(BuildContext context) {
  return AppBar(
    elevation: 1,
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return Profile(); // Block instead chat
        }))
      },
    ),
    centerTitle: true,
    backgroundColor: lightTheme.backgroundColor,
    title: Text(
      "تعديل الحساب",
      style: TextStyle(
          color: Colors.grey,
          fontSize: 18,
          fontFamily: 'openSans',
          fontStyle: FontStyle.italic),
    ),
  );
}

AppBar CertifiedProfileAppBar(BuildContext context) {
  return AppBar(
    elevation: 1,
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return Profile(); // Block instead chat
        }))
      },
    ),
    centerTitle: true,
    backgroundColor: lightTheme.backgroundColor,
    title: Text(
      "تصديق حسابي",
      style: TextStyle(
          color: Colors.grey,
          fontSize: 18,
          fontFamily: 'openSans',
          fontStyle: FontStyle.italic),
    ),
  );
}


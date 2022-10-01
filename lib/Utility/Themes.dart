import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  backgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    elevation: 0,
    //backgroundColor: Color.fromRGBO(74, 74, 74, 1),
    iconTheme: IconThemeData(
      color: Color.fromRGBO(74, 74, 74, 1.0),
    ),
    centerTitle: true,
  ),
  primaryColor: Colors.white,
  hintColor: Color.fromRGBO(255, 98, 101, 1),
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Urbanist',
);

import 'package:flutter/material.dart';

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false,
    elevation: 0.0,
    toolbarHeight: 75.0,
    titleSpacing: 0,
    leading: Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Image(
        image: AssetImage('assets/images/marryme.png'),
        width: 90.0,
        height: 90.0,
      ),
    ),
  );
}

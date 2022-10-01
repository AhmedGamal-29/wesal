import 'package:flutter/material.dart';
import 'package:marry_me/Utility/Themes.dart';

class ProfileWidget extends StatelessWidget {
  var imagePath;
  final VoidCallback onClicked;

  ProfileWidget({Key? key, required this.imagePath, required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = lightTheme.primaryColor;
    return Center(
      child: Image(),
    );
  }

  Widget Image() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }
}

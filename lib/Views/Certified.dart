import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marry_me/Components/Profile_Components/AppBar.dart';
import 'package:marry_me/Utility/Themes.dart';
import 'package:marry_me/Views/Profile.dart';
import 'package:http/http.dart' as http;
import 'package:marry_me/Models/User.dart';

import '../Globals.dart';
import 'Search.dart';


class Certified extends StatefulWidget {
  const Certified({Key? key}) : super(key: key);

  @override
  State<Certified> createState() => _CertifiedState();
}

class _CertifiedState extends State<Certified> {
  bool click = false;

  //List<File> image=new List.empty(growable: true);
  var imageName = "اختر صورة او عدة صور";
  var pickedFile;
  var image;
   var imageFile;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.popAndPushNamed(context, Profile.routeName);
          return new Future(() => false);
        },
        child: Scaffold(
            appBar:AppBar(
              foregroundColor: Colors.grey[700],
              elevation: 8,
              actions: [
                GestureDetector(
                  onTap: (){

                    showSearch(
                      context: context,
                      delegate: DataSearch(),
                    );

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(Icons.search,color:Color(0xffff6265)),
                  ),
                )
              ],
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
                    return Profile(); // Block instead chat
                  }))
                },
              ),
              title: Text(
                "تصديق حسابي",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontFamily: 'openSans',
                    fontStyle: FontStyle.italic),
              ),

              backgroundColor: Colors.white38,

            ),
            body: Container(

                alignment: AlignmentDirectional.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30,),
                    Text(
                      'قم برفع صور تتضمن معلومات تريد تصديقها',
                      style: TextStyle(
                        color: lightTheme.hintColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(FontAwesomeIcons.camera),
                          onPressed: () {
                            setState(() {
                              click = !click;
                            });
                          },
                        ),
                        Text(
                          imageName,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'openSans'
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30,),
                    FlatButton(
                        onPressed: () {
                          setState(() {
                             imageFile=image;
                          });
                          /*Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => Profile()));*/
                           // certifiedData();
                        },
                        child: Text(
                          "قم بارسال طلب تصديق لحسابي",
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        color: lightTheme.hintColor,
                        padding: EdgeInsets.fromLTRB(13, 13, 13, 13)),

                    click == true ? chooseImage(context) : Container(),

                    const SizedBox(height: 80,),
                    showImage(),
                  ],
                )
            )));
  }

  Future getImage(ImageSource src) async {
    var data = (await ImagePicker().pickImage(source: src))!;
    File file = File(data.path).absolute;
    image = file;
    certifiedData((file.readAsBytesSync()));
    //print(obj.message);
    /*
    pickedFile = await ImagePicker().getImage(source: src);

    if (pickedFile != null) {

        this.image = File(pickedFile.path);

      certifiedData(image);
      print('Image selected.');
    } else {
      print('No image selected.');
    }*/
  }

  Builder buildDialogItem(BuildContext context, String text, IconData icon,
      ImageSource src) {
    return Builder(
      builder: (innerContext) =>
          Container(
            decoration: BoxDecoration(
              color: lightTheme.hintColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: Icon(icon, color: Colors.white),
              title: Text(text),
              onTap: () {
                getImage(src);
                Navigator.of(innerContext).pushReplacement(
                    MaterialPageRoute(builder: (_) => Certified()));
              },
            ),
          ),
    );
  }

  Widget chooseImage(BuildContext context) {
    return Container(
      width: double.infinity,
      child: AlertDialog(
        title: Text("Choose Picture from:"),
        content: Container(
          height: 150,
          child: Column(
            children: [
              Divider(color: Colors.black),
              buildDialogItem(context, "Camera", Icons.add_a_photo_outlined,
                  ImageSource.camera),
              SizedBox(height: 10),
              buildDialogItem(context, "Gallery", Icons.image_outlined,
                  ImageSource.gallery),
            ],
          ),
        ),
      ),
    );
  }

  Widget showImage() {
    return  Center(
      child: image != null
          ? Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: 100,
          height: 100,
          child: Image.file(
            image,
          ),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text('No image selected'),
      ),
    );
  }

  certifiedData(image) async {
    var url = Uri.parse("http://10.0.2.2:8000/api/certified");

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $KUserToken'
      },
      body: {
        'image': image.toString(),
      },
    );

    final responseJson = json.decode(response.body);

    print(responseJson);

    /*
    String imgName = image.path.split('/').last;
    print(imgName);
    http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization':
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3Q6ODAwMFwvYXBpXC9yZWdpc3RlciIsImlhdCI6MTYzMjI3MTI5MCwiZXhwIjoxNjMyNTAxNjkwLCJuYmYiOjE2MzIyNzEyOTAsImp0aSI6Im5IUW1Jd2l5SHcyRGJ5bmYiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.4mUGpn98s9kJF1PlPdVxiqbqnZnYXbDEbx3nWEJ-FmM'
    }, body: {
      'image': imgName
    }).then((response) => {
      print('Response body:${response.body}'),
      print('Response Status: ${response.statusCode}')
    });*/
  }

}
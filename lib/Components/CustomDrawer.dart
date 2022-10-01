import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marry_me/Utility/Themes.dart';
import 'package:marry_me/Views/Blocks.dart';
import 'package:marry_me/Views/Likedme.dart';
import 'package:marry_me/Views/Login.dart';
import 'package:marry_me/Views/Profile.dart';
import 'package:marry_me/Views/Splash.dart';
import 'package:marry_me/Views/requests.dart';
import 'package:marry_me/Views/requestsrecieved.dart';
import '../Views/Home.dart';

import '../Globals.dart';
import 'Profile_Components/ProfileWidget.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({Key? key}) : super(key: key);

  // var _appIconState = Icons.hide_image;
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  void logout() {
    //int id = Profile.userId;
    var url = Uri.parse('http://10.0.2.2:8000/api/logout');
    http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer  $KUserToken'
    }).then((response) => {

      print('Response body:${response.body}'),
      print('Response Status: ${response.statusCode}')
    });
  }

  void profile(BuildContext ctx) {
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_) {
      return Profile(); // Block instead chat
    }));
  }

  _navigateToHome() async {

    Navigator.pushReplacementNamed(context, Home.routeName);
  }

  _navigateToBlocks() async {
    Navigator.pushReplacementNamed(context, Blocks.routeName);
  }
  _navigateToRequests() async {
    Navigator.pushReplacementNamed(context, requests.routeName);
  }
  _navigateToRequestsrec() async {
    Navigator.pushReplacementNamed(context, requestsrecieved.routeName);
  }
  _navigateToLikedme() async {
    Navigator.pushReplacementNamed(context, Likedme.routeName);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final image = ProfileWidget(
        imagePath: Home.imageJson, onClicked: () => profile(context));

    return Drawer(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: image.Image(),
              accountName: Text(Home.nameJson),
              accountEmail: Text(Home.emailJson),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.remove_red_eye),
                    title: Text('Hide App Icon'),
                    subtitle: Text('Change Your Application Icon'),
                    onTap: () {
                      // if(widget._appIconState == Icons.hide_image){
                      setState(() {
                        // widget._appIconState = Icons.image;
                        changeAppIcon();
                      });
                      // }else{
                      setState(() {
                        // widget._appIconState = Icons.hide_image;
                      });
                      // }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.home,size: 18),
                    title: Text("القائمة"),
                    onTap: (){
                      _navigateToHome();
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,top: 20),
                    child: GestureDetector(
                        onTap: (){
                          _navigateToRequests();
                        },
                        child:Column(
                          children: [
                            Row(
                              children: [
                                Text("قائمة طلبات بدء المحادثة المرسلة",style: TextStyle(color: Color(0xffff6265),),),

                              ],
                            ),
                          ],
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,top: 20),
                    child: GestureDetector(
                        onTap: (){
                          _navigateToRequestsrec();
                        },
                        child:Column(
                          children: [
                            Row(
                              children: [
                                Text("قائمة طلبات بدء المحادثة ",style: TextStyle(color: Color(0xffff6265),),),

                              ],
                            ),
                          ],
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,top: 20),
                    child: GestureDetector(
                        onTap: (){
                          _navigateToBlocks();
                        },
                        child:Column(
                          children: [
                            Row(
                              children: [
                                Text("قائمة المحظورين",style: TextStyle(color: Color(0xffff6265),),),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Icon(Icons.block,size: 18,color: Color(0xffff6265),),
                                ),
                              ],
                            ),
                          ],
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,top: 20),
                    child: GestureDetector(
                        onTap: (){
                          _navigateToLikedme();
                        },
                        child:Column(
                          children: [
                            Row(
                              children: [
                                Text("قائمة المعجبين بي",style: TextStyle(color: Color(0xffff6265),),),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Icon(Icons.favorite,size: 18,color: Color(0xffff6265),),
                                ),
                              ],
                            ),
                          ],
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,top: 20),
                    child: GestureDetector(
                      onTap: (){
                        _navigateToHome();
                      },
                      child:Column(
                        children: [
                          /* icon logout */
                          SizedBox(height:250),
                          Row(
                            children: [
                              Text("Log out",style: TextStyle(color: Color(0xffff6265), fontSize: 15,fontWeight: FontWeight.bold),),
                              IconButton(
                                onPressed:(){
                                  Navigator.of(context).pushNamed(Login.routeName);
                                  logout();
                                },
                                icon: Icon(IconData(0xe3b3, fontFamily: 'MaterialIcons')),
                                iconSize: 28,
                                color: lightTheme.hintColor,
                              ),
                            ],
                          )

                        ],
                      )
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  changeAppIcon() async {
    print('good');
    try {
      print(await FlutterDynamicIcon.supportsAlternateIcons);
      await FlutterDynamicIcon.supportsAlternateIcons;
      await FlutterDynamicIcon.setAlternateIconName(
          'assets/images/marryme.png');
    } catch (e) {}
  }
}

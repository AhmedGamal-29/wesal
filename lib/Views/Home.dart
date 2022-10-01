
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:marry_me/Components/CustomDrawer.dart';
import 'package:marry_me/Views/Profile.dart';
import 'package:marry_me/Views/RecentChats.dart';
import '../Globals.dart';
import 'Splash.dart';
import '../Utility/Themes.dart';
import 'Chat.dart';
import '../Components/UserCard.dart';
import 'Search.dart';
import '../View_Model/UserViewModel.dart';
import '../Models/User.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Premium.dart';
import 'Fav.dart';


class Home extends StatefulWidget {

  static var option;
  static var nameJson = 'User';
  static var emailJson = 'user@gmail.com';
  static var imageJson='';

  const Home({Key? key}) : super(key: key);
  static const routeName = 'Home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _indx=1;
  Color premiumColor=Colors.black26;
  Color homeColor=Color(0xffff6265);
  Color likedColor=Colors.black26;
  Color profileColor=Colors.black26;
  Widget mainPageView=Container();

  /////////////////////For user's info customDrawer//////////

  void getUser() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/profile'),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $KUserToken',
      },
    );

    if (response.statusCode == 200) {
      var data;
      setState(() {
        data = json.decode(response.body);
        Home.nameJson = data['name'];
        Home.emailJson = data['email'];
        if(data['image'] !=null) {
          Home.imageJson = data['image'];
        }else{
          Home.imageJson = "https://a6ciswdyxn-flywheel.netdna-ssl.com/wp-content/uploads/bb-plugin/cache/no-profile-image-e1568830705855-square.png";
        }
      }
      );
    }
  }
  ////////////////////////////////
  void _incrementTab(index)
  {
    setState(() {
      _indx=index;
    });


  }

  _navigateToChat() {
    Navigator.pushReplacementNamed(context, RecentChats.routeName);
  }

  _navigateToFav() {
    Navigator.pushReplacementNamed(context, Fav.routeName);
  }



  @override
  void initState() {
    // TODO: implement initState
    this.getUser();
    super.initState();
    setState(() {
      mainPageView=mainPage();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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

        backgroundColor: Colors.white38,

      ),
      body: mainPageView,
      drawer: CustomDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indx,
        type: BottomNavigationBarType.fixed,
        items:[

          BottomNavigationBarItem(
            icon: Icon( Icons.label_important_sharp,color:premiumColor,),
              label: "VIP"
          ),
          BottomNavigationBarItem(
            icon: Icon( Icons.home,color:homeColor,),
            label: "القائمة"
          ),
          BottomNavigationBarItem(
              icon: Icon( Icons.star,color:likedColor,),
              label: "المعجب بهم"
          ),
          BottomNavigationBarItem(
              icon: Icon( Icons.person,color:profileColor,),
              label: "حسابك الشخصي"
          )

        ],
        onTap: (index){
          _incrementTab(index);
            Home.option=index;
          if (index==0)
            {
              premiumColor=Color(0xffff6265);
             homeColor=Colors.black26;
               likedColor=Colors.black26;
               profileColor=Colors.black26;

              //TODO Call the VIP view instead of Container
               mainPageView=PremiumPage();


            }
          else if (index==1)
          {
            homeColor=Color(0xffff6265);
            premiumColor=Colors.black26;
            likedColor=Colors.black26;
            profileColor=Colors.black26;

            mainPageView=mainPage();
          }
          else if (index==2)
          {
            likedColor=Color(0xffff6265);
            premiumColor=Colors.black26;
            homeColor=Colors.black26;
            profileColor=Colors.black26;

            //TODO Call the Liked view instead of Container
            mainPageView=Fav();

          }
          else if (index==3)
          {
            profileColor=Color(0xffff6265);
            premiumColor=Colors.black26;
            homeColor=Colors.black26;
            likedColor=Colors.black26;

            //TODO Call the Profile view instead of Container
            mainPageView=Profile();

          }

        },
      ),
      floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.white,
        child:Icon( Icons.send,color:Color(0xffff6265),),
        onPressed: (){
          setState(() {
            premiumColor=Colors.black26;
            homeColor=Colors.black26;
            likedColor=Colors.black26;
            profileColor=Colors.black26;
            _navigateToChat();

          });


        },
      ),
    );
  }
}

class mainPage extends StatefulWidget {
  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {

  late Future<List<UserCard>> users;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // get_user();

    users=getPreferenceList();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: users,
        builder:(BuildContext context,AsyncSnapshot snapshot)
          {
            if (snapshot.data==null)
              {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor:AlwaysStoppedAnimation<Color>(Color(0xffff6265)),
                  )
                );
              }
            else
              {
                return Container(
                  padding: const EdgeInsets.only(left: 16,right: 16,top: 48),
                  child: Column(
                    children:<Widget> [
                      Expanded(
                          child: new ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return snapshot.data[index];
                            },
                          )
                      )
                    ],
                  ),
                );
              }
          }
      ),
    );
  }
}











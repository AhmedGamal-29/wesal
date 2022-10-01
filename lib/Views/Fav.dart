import 'dart:io';
import 'package:flutter/material.dart';
import 'package:marry_me/Models/FavModel.dart';
import 'package:http/http.dart' as http;
import 'package:marry_me/View_Model/UserViewModel.dart';
import 'dart:async';
import 'dart:convert';
import 'RecentChats.dart';

import '../Globals.dart';
import 'UsersProfile.dart';


Future<List<Favs>> fetch() async {
  final response =
  await http.get(Uri.parse('$BaseUrl/api/getAllFriends'), headers: {
    'Accept' : 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $KUserToken',
  },);

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Favs>((json) => Favs.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load Favorite List');
  }
}

class Fav extends StatefulWidget {
  const Fav({Key? key}) : super(key: key);
  static const routeName = 'Fav';

  @override
  _FavState createState() => _FavState();
}

class _FavState extends State<Fav> {

  late Future <List<Favs>> futurePost;
  _navigateToChat() {
    Navigator.pushReplacementNamed(context, RecentChats.routeName);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLiked = true;
    futurePost = fetch();
    return Scaffold(
      //back
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left:260,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ImageIcon(AssetImage('assets/images/marryme.png'),size: 130,color: Color(0xffff6265),),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(

              child:RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 45,
                  ),
                  text:'قائمة المعجب بهم',
                  children: <TextSpan>[
                    TextSpan(
                      text: String.fromCharCode(57947), //<-- charCode
                      style: TextStyle(
                        fontFamily: 'MaterialIcons', //<-- fontFamily
                        fontSize: 38,
                        color: Color(0xffff6265),
                      ),
                    )
                  ],
                ),
              )

          ),
          SizedBox(
            height: 30,
          ),
          //         mainPage(),
          Expanded(child: FutureBuilder<List<Favs>>(
            future: futurePost,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => Container(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UsersProfile(snapshot.data![index].user_1)),
                        );
                      },
                      child: Container(
                        height: 120,
                        child: ListTileTheme(
                          // tileColor: Colors.grey[300],
                          child: Padding(
                            padding: const EdgeInsets.only(bottom:8.0),
                            child: Card(
                              elevation: 12,
                              shape:BeveledRectangleBorder(),
                              child: Row(
                                  children:[
                              Padding(
                              padding: const EdgeInsets.only(left:12.0),
                                child: Container(
                                    width: 80,
                                    height: 80,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(snapshot.data![index].user2_image),
                                    ),
                                  ),
                              ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:[
                                            Text(snapshot.data![index].name,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: 'Frutiger',
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text("age:  "+snapshot.data![index].age.toString(), style: TextStyle(
                                              fontSize: 14,

                                            ),),
                                          ]
                                      ),
                                    ),
                                    new Spacer(),

                                    Padding(
                                      padding: const EdgeInsets.only(top:50.0),
                                      child: Row(

                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            child: Padding(
                                                padding: const EdgeInsets.only(left: 8.0,right: 8),
                                                child: TextButton(
                                                    style: TextButton.styleFrom(
                                                      primary: Color(0xffff6265),
                                                    ),
                                                    child: Text('ازالة صديق',
                                                      style: TextStyle(
                                                        color: Color(0xffff6265),
                                                        //fontSize: 45,
                                                      ),),

                                                    onPressed: () async{
                                                      int res =await removeFriend(snapshot.data![index].id);
                                                      // addFriend(snapshot.data![index].user_1);
                                                      // if (res==200) {
                                                      showDialog<String>(
                                                          context: context,
                                                          builder: (BuildContext context) =>
                                                              AlertDialog(
                                                                  title: const Text(
                                                                      'تم ازالة هذا الشخص من قائمة الاصدقاء بنجاح'),
                                                                  // content: const Text('ستبدا المحادثة حينما يوافق لبطرف الاخر علي الطلب'),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      onPressed: () =>
                                                                          Navigator.pop(context, 'Cancel'),
                                                                      child: const Text('موافق',
                                                                        style: TextStyle(
                                                                          color: Color(0xffff6265),
                                                                          //fontSize: 45,
                                                                        ),),
                                                                    )
                                                                  ]));
                                                      // }

                                                    }
                                                )
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              if (userVip==1)
                                              {

                                                int res =await startChat(snapshot.data![index].user_1);
                                                if (res==201)
                                                {
                                                  _navigateToChat();
                                                }

                                              }
                                              else
                                              {
                                                Future<int> res=sentRequest(snapshot.data![index].user_1);
                                                print(res.toString());

                                                showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext context) =>
                                                        AlertDialog(
                                                            title: const Text('تم ارسال الطلب بنجاح'),
                                                            content: const Text('ستبدا المحادثة حينما يوافق لبطرف الاخر علي الطلب'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                                                child: const Text('موافق',style: TextStyle(
                                                                  color: Color(0xffff6265),
                                                                  //fontSize: 45,
                                                                ),),
                                                              )]));

                                              }
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                              child: Icon(Icons.chat_bubble,color:Color(0xffff6265)),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: ()async{
                                              int res =await blockFriend(snapshot.data![index].user_1);
                                               if (res==201) {
                                              showDialog<String>(
                                                  context: context,
                                                  builder: (BuildContext context) =>
                                                      AlertDialog(
                                                          title: const Text(
                                                              'تم حظر هذا الشخص  بنجاح'),
                                                          // content: const Text('ستبدا المحادثة حينما يوافق لبطرف الاخر علي الطلب'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(context, 'Cancel'),
                                                              child: const Text('موافق',style: TextStyle(
                                                                color: Color(0xffff6265),
                                                                //fontSize: 45,
                                                              ),),
                                                            )
                                                          ]));
                                               }
                                              if (res==200) {

                                                showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext context) =>
                                                        AlertDialog(
                                                            title: const Text(
                                                                'لقد تم حظر هذا الشخص من قبل'),
                                                            // content: const Text('ستبدا المحادثة حينما يوافق لبطرف الاخر علي الطلب'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () =>

                                                                    Navigator.pop(context, 'Cancel'),
                                                                child: const Text('موافق',style: TextStyle(
                                                                  color: Color(0xffff6265),
                                                                  //fontSize: 45,
                                                                ),),
                                                              )
                                                            ]));
                                              }

                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                                              child: Icon(Icons.block,color:Color(0xffff6265)),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ]
                              ),
                            ),
                          ),

                        ),

                      ),
                    ),
                  ),);
              } else {
                return Center(child: CircularProgressIndicator(
                  valueColor:AlwaysStoppedAnimation<Color>(Color(0xffff6265),),));
              }
            },
          ),
          ),
        ],
      ),
    );
  }
}

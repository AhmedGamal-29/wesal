import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:marry_me/Models/LikedMeModel.dart';
import 'package:marry_me/View_Model/UserViewModel.dart';
import '../Globals.dart';
import 'Home.dart';
import 'RecentChats.dart';
import 'UsersProfile.dart';


Future <List<Liked>> fetch() async {
  final response =
  await http.get(Uri.parse('$BaseUrl/api/showAllLiked'),
    headers: {
      'Accept' : 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $KUserToken',
    },);

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Liked>((json) => Liked.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load Liked Me List');
  }
}


class Likedme extends StatefulWidget {
  const Likedme({Key? key}) : super(key: key);
  static const routeName = 'Likedme';

  @override
  _LikedmeState createState() => _LikedmeState();
}

class _LikedmeState extends State<Likedme> {


  _navigateToChat() {
    Navigator.pushReplacementNamed(context, RecentChats.routeName);
  }
  _navigateToHome() {
    Navigator.pushReplacementNamed(context, Home.routeName);
  }

  late Future <List<Liked>> futurePost;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    futurePost = fetch();
    bool isLiked = false;
    return Scaffold(
      //back
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left:10,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Color(0xffff6265),
                      ),
                      child: Text(
                        'الرجوع',
                        style: TextStyle(
                          color: Color(0xffff6265),
                          fontSize:25,
                          //fontSize: 45,
                        ),
                      ),
                      onPressed: () async {
                        _navigateToHome();
                      },),
                    SizedBox(width: 180),
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
                  text: 'قائمة المعجبين بي',
                ),
              )

          ),
          SizedBox(
            height: 30,
          ),
          //         mainPage(),
          Expanded(child: FutureBuilder<List<Liked>>(
            future: futurePost,
            builder: (context, snapshot) {
              if(userVip==1) {
                if (snapshot.hasData) {
                  //if(snapshot.data![index])
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) =>
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    UsersProfile(snapshot.data![index].user_1)),
                              );
                            },
                            child: Container(
                              height: 120,
                              child: ListTileTheme(
                                // tileColor: Colors.grey[300],
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Card(
                                    elevation: 12,
                                    shape: BeveledRectangleBorder(),
                                    child: Row(
                                        children: [
                                    Padding(
                                    padding: const EdgeInsets.only(left:12.0),
                                          child: Container(
                                          width: 80,
                                          height: 80,
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                snapshot.data![index]
                                                    .user2_image),
                                          ),
                                        ),
                                    ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Text(
                                                    snapshot.data![index].name,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Frutiger',
                                                      color: Colors.black,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                    ),
                                                  ),
                                                  Text("age:  " +
                                                      snapshot.data![index].age
                                                          .toString()),
                                                ]
                                            ),
                                          ),
                                          new Spacer(),

                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 50.0),
                                            child: Row(

                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    int res = await addFriend(
                                                        snapshot.data![index]
                                                            .user_1);
                                                    // addFriend(snapshot.data![index].user_1);
                                                    if (res == 201) {
                                                      showDialog<String>(
                                                          context: context,
                                                          builder: (
                                                              BuildContext context) =>
                                                              AlertDialog(
                                                                  title: const Text(
                                                                      'تم اضافة هذه الشخص الي قائمة الاصدقاء بنجاح'),
                                                                  // content: const Text('ستبدا المحادثة حينما يوافق لبطرف الاخر علي الطلب'),
                                                                  actions: <
                                                                      Widget>[
                                                                    TextButton(
                                                                      onPressed: () =>
                                                                          Navigator
                                                                              .pop(
                                                                              context,
                                                                              'Cancel'),
                                                                      child: const Text(
                                                                        'موافق',
                                                                        style:
                                                                        TextStyle(
                                                                          color: Color(
                                                                              0xffff6265),
                                                                          //fontSize: 45,
                                                                        ),),
                                                                    )
                                                                  ]));
                                                    }
                                                    else if (res == 400) {
                                                      showDialog<String>(
                                                          context: context,
                                                          builder: (
                                                              BuildContext context) =>
                                                              AlertDialog(
                                                                  title: const Text(
                                                                      'لقد أضفت هذا الشخص من قبل'),
                                                                  // content: const Text('ستبدا المحادثة حينما يوافق لبطرف الاخر علي الطلب'),
                                                                  actions: <
                                                                      Widget>[
                                                                    TextButton(
                                                                      onPressed: () =>
                                                                          Navigator
                                                                              .pop(
                                                                              context,
                                                                              'Cancel'),
                                                                      child: const Text(
                                                                        'موافق',
                                                                        style: TextStyle(
                                                                          color: Color(
                                                                              0xffff6265),
                                                                          //fontSize: 45,
                                                                        ),),
                                                                    )
                                                                  ]));
                                                    }
                                                    else if (res == 402) {
                                                      showDialog<String>(
                                                          context: context,
                                                          builder: (
                                                              BuildContext context) =>
                                                              AlertDialog(
                                                                  title: const Text(
                                                                      'لقد أضفت هذا الشخص من قبل في قائمة الخظر لا يمكنك اضافته'),
                                                                  // content: const Text('ستبدا المحادثة حينما يوافق لبطرف الاخر علي الطلب'),
                                                                  actions: <
                                                                      Widget>[
                                                                    TextButton(
                                                                      onPressed: () =>
                                                                          Navigator
                                                                              .pop(
                                                                              context,
                                                                              'Cancel'),
                                                                      child: const Text(
                                                                        'موافق',
                                                                        style: TextStyle(
                                                                          color: Color(
                                                                              0xffff6265),
                                                                          //fontSize: 45,
                                                                        ),),
                                                                    )
                                                                  ]));
                                                    }
                                                    else if (res == 402) {
                                                      showDialog<String>(
                                                          context: context,
                                                          builder: (
                                                              BuildContext context) =>
                                                              AlertDialog(
                                                                  title: const Text(
                                                                      'لقد أضفت هذا الشخص من قبل في قائمة الخظر لا يمكنك اضافته'),
                                                                  // content: const Text('ستبدا المحادثة حينما يوافق لبطرف الاخر علي الطلب'),
                                                                  actions: <
                                                                      Widget>[
                                                                    TextButton(
                                                                      onPressed: () =>
                                                                          Navigator
                                                                              .pop(
                                                                              context,
                                                                              'Cancel'),
                                                                      child: const Text(
                                                                        'موافق',
                                                                        style: TextStyle(
                                                                          color: Color(
                                                                              0xffff6265),
                                                                          //fontSize: 45,
                                                                        ),),
                                                                    )
                                                                  ]));
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        left: 12.0, right: 12),
                                                    child: Icon(Icons.favorite,
                                                        color: Color(
                                                            0xffff6265)),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    if (userVip == 1) {
                                                      int res = await startChat(
                                                          snapshot.data![index]
                                                              .user_1);
                                                      if (res == 201) {
                                                        _navigateToChat();
                                                      }
                                                    }
                                                    else {
                                                      Future<
                                                          int> res = sentRequest(
                                                          snapshot.data![index]
                                                              .user_1);
                                                      print(res.toString());

                                                      showDialog<String>(
                                                          context: context,
                                                          builder: (
                                                              BuildContext context) =>
                                                              AlertDialog(
                                                                  title: const Text(
                                                                      'تم ارسال الطلب بنجاح'),
                                                                  content: const Text(
                                                                      'ستبدا المحادثة حينما يوافق لبطرف الاخر علي الطلب'),
                                                                  actions: <
                                                                      Widget>[
                                                                    TextButton(
                                                                      onPressed: () =>
                                                                          Navigator
                                                                              .pop(
                                                                              context,
                                                                              'Cancel'),
                                                                      child: const Text(
                                                                        'موافق',
                                                                        style:
                                                                        TextStyle(
                                                                          color: Color(
                                                                              0xffff6265),
                                                                          //fontSize: 45,
                                                                        ),),
                                                                    )
                                                                  ]));
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        left: 12.0, right: 12),
                                                    child: Icon(
                                                        Icons.chat_bubble,
                                                        color: Color(
                                                            0xffff6265)),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    int res = await blockFriend(
                                                        snapshot.data![index]
                                                            .user_1);
                                                    // if (res==200) {
                                                    showDialog<String>(
                                                        context: context,
                                                        builder: (
                                                            BuildContext context) =>
                                                            AlertDialog(
                                                                title: const Text(
                                                                    'تم حظر هذا الشخص  بنجاح'),
                                                                // content: const Text('ستبدا المحادثة حينما يوافق لبطرف الاخر علي الطلب'),
                                                                actions: <
                                                                    Widget>[
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator
                                                                            .pop(
                                                                            context,
                                                                            'Cancel'),
                                                                    child: const Text(
                                                                      'موافق',
                                                                      style:
                                                                      TextStyle(
                                                                        color: Color(
                                                                            0xffff6265),
                                                                        //fontSize: 45,
                                                                      ),),
                                                                  )
                                                                ]));
                                                    // }

                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        left: 12.0, right: 12),
                                                    child: Icon(Icons.block,
                                                        color: Color(
                                                            0xffff6265)),
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
                    valueColor: AlwaysStoppedAnimation<Color>(Color(
                        0xffff6265)),));
                }
              }
              else
                {
                  return Expanded(child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                      ),
                      text: 'أنت لست VIP',
                    ),
                  ),

                  );
                }
            },
          ),
          ),
        ],
      ),
    );
  }
}
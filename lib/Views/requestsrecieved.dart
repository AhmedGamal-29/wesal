import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:marry_me/Models/BlocksModel.dart';
import 'package:marry_me/Models/rRequestsModel.dart';
import 'package:marry_me/Models/requestsModel.dart';
import 'package:marry_me/View_Model/UserViewModel.dart';
import '../Globals.dart';
import 'Home.dart';
import 'RecentChats.dart';
import 'UsersProfile.dart';

Future<List<Req>> fetch() async {
  final response = await http.get(
    Uri.parse('$BaseUrl/api/RequestsRecieved'),
    headers: {
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $KUserToken',
    },
  );

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Req>((json) => Req.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load Requests List');
  }
}

class requestsrecieved extends StatefulWidget {
  const requestsrecieved({Key? key}) : super(key: key);
  static const routeName = 'requestsrecieved';

  @override
  _requestsrecievedState createState() => _requestsrecievedState();
}

class _requestsrecievedState extends State<requestsrecieved> {


  _navigateToChat() {
    Navigator.pushReplacementNamed(context, RecentChats.routeName);
  }

  _navigateToHome() {
    Navigator.pushReplacementNamed(context, Home.routeName);
  }


  late Future<List<Req>> futurePost;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    futurePost = fetch();
    bool isBlock = false;
    return Scaffold(
//back
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
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
                    ImageIcon(
                      AssetImage('assets/images/marryme.png'),
                      size: 130,
                      color: Color(0xffff6265),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 30,
                  ),
                  text: 'قائمة طلبات بدء المحادثة ',
                ),
              )),
          SizedBox(
            height: 30,
          ),
//         mainPage(),
          Expanded(
            child: FutureBuilder<List<Req>>(
              future: futurePost,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
//if(snapshot.data![index])
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => Container(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UsersProfile(
                                    snapshot.data![index].sender_id)),
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
                                child: Row(children: [
                                Padding(
                                padding: const EdgeInsets.only(left:12.0),
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          snapshot.data![index].image),
                                    ),
                                  ),
                                ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            snapshot.data![index].name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Frutiger',
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text("age:  " +
                                              snapshot.data![index].age
                                                  .toString()),
                                        ]),
                                  ),
                                  new Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 50.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8),
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                primary: Color(0xffff6265),
                                              ),
                                              child: Text(
                                                'رفض الطلب',
                                                style: TextStyle(
                                                  color: Color(0xffff6265),
                                                  //fontSize: 45,
                                                ),
                                              ),
                                              onPressed: () async {
                                                int res = await dec(
                                                    snapshot
                                                        .data![index].sender_id,2);
                                                // addFriend(snapshot.data![index].user_1);
                                                // if (res==200) {
                                                showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext
                                                    context) =>
                                                        AlertDialog(
                                                            title: const Text(
                                                                'تم رفض  طلب هذا الشخص  بنجاح'),
                                                            // content: const Text('ستبدا المحادثة حينما يوافق لبطرف الاخر علي الطلب'),
                                                            actions: <
                                                                Widget>[
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context,
                                                                        'Cancel'),
                                                                child: Text(
                                                                  'موافق',
                                                                  style:
                                                                  TextStyle(
                                                                    color: Color(
                                                                        0xffff6265),
                                                                    //fontSize: 45,
                                                                  ),
                                                                ),
                                                              )
                                                            ]));
                                                // }
                                              },
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8),
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                primary: Color(0xffff6265),
                                              ),
                                              child: Text(
                                                'قبول الطلب',
                                                style: TextStyle(
                                                  color: Color(0xffff6265),
                                                  //fontSize: 45,
                                                ),
                                              ),
                                              onPressed: () async {
                                                int res = await dec(
                                                    snapshot
                                                        .data![index].sender_id,1);
                                                // addFriend(snapshot.data![index].user_1);
                                                // if (res==200) {
                                                showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext
                                                    context) =>
                                                        AlertDialog(
                                                            title: const Text(
                                                                'تم قبول طلب هذا الشخص بنجاح'),
                                                            // content: const Text('ستبدا المحادثة حينما يوافق لبطرف الاخر علي الطلب'),
                                                            actions: <
                                                                Widget>[
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context,
                                                                        'Cancel'),
                                                                child: Text(
                                                                  'موافق',
                                                                  style:
                                                                  TextStyle(
                                                                    color: Color(
                                                                        0xffff6265),
                                                                    //fontSize: 45,
                                                                  ),
                                                                ),
                                                              )
                                                            ]));
                                                // }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ),
                  );
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xffff6265)),
                      ));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

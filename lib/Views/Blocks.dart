import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:marry_me/Models/BlocksModel.dart';
import 'package:marry_me/View_Model/UserViewModel.dart';
import '../Globals.dart';
import 'Home.dart';
import 'RecentChats.dart';
import 'UsersProfile.dart';

Future<List<Block>> fetch() async {
  final response = await http.get(
    Uri.parse('$BaseUrl/api/getAllBlocks'),
    headers: {
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $KUserToken',
    },
  );

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Block>((json) => Block.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load Block Me List');
  }
}

class Blocks extends StatefulWidget {
  const Blocks({Key? key}) : super(key: key);
  static const routeName = 'Blocks';

  @override
  _BlocksState createState() => _BlocksState();
}

class _BlocksState extends State<Blocks> {


  _navigateToChat() {
    Navigator.pushReplacementNamed(context, RecentChats.routeName);
  }

  _navigateToHome() {
    Navigator.pushReplacementNamed(context, Home.routeName);
  }


  late Future<List<Block>> futurePost;

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
                    fontSize: 45,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: String.fromCharCode(57569), //<-- charCode
                      style: TextStyle(
                        fontFamily: 'MaterialIcons', //<-- fontFamily
                        fontSize: 38,
                        color: Color(0xffff6265),
                      ),
                    )
                  ],
                  text: 'قائمة الحظر',
                ),
              )),
          SizedBox(
            height: 30,
          ),
//         mainPage(),
          Expanded(
            child: FutureBuilder<List<Block>>(
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
                                    snapshot.data![index].blocked_id)),
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
                                          snapshot.data![index].blocked_image),
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
                                                    'ازالة الحظر',
                                                    style: TextStyle(
                                                      color: Color(0xffff6265),
                                                      //fontSize: 45,
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    int res = await removeBlock(
                                                        snapshot
                                                            .data![index].id);
                                                    // addFriend(snapshot.data![index].user_1);
                                                    // if (res==200) {
                                                    showDialog<String>(
                                                        context: context,
                                                        builder: (BuildContext
                                                        context) =>
                                                            AlertDialog(
                                                                title: const Text(
                                                                    'تم ازالة هذا الشخص من قائمة الحظر بنجاح'),
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
                                                  },),),
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

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:marry_me/Components/CustomDrawer.dart';
import 'package:marry_me/Components/Profile_Components/AppBar.dart';
import 'package:marry_me/Components/Profile_Components/Edit.dart';
import 'package:marry_me/Components/Profile_Components/ProfileWidget.dart';
import 'package:marry_me/Models/QuestionAndAnswerUser.dart';
import 'package:marry_me/Models/QuestionUsersProfile.dart';
import 'package:marry_me/Models/User.dart';
import 'package:marry_me/Utility/Themes.dart';
import 'package:marry_me/Views/Home.dart';
import 'package:marry_me/Views/Signup.dart';

import '../Globals.dart';
import 'Certified.dart';
import 'Login.dart';
import 'Search.dart';

class UsersProfile extends StatefulWidget {
  var Id;
  UsersProfile(this.Id);

  static var nameJson = 'User';

  static var emailJson = 'user@gmail.com';

  static var phoneJson;

  static var ageJson;

  static var banJson;

  static var banCountJson;

  static var birthDayJson;

  static var vipJson = 0;

  static var certifiedJson = 0;

  static var image ="https://a6ciswdyxn-flywheel.netdna-ssl.com/wp-content/uploads/bb-plugin/cache/no-profile-image-e1568830705855-square.png";

  static var imageJson ='';

  static var answerJson;

  static var reportJson;

  static var genderJson = 'female';

  static var question = 'm';
  static var question_id;
  static var answer = 'l';
  static var answer_id;


  static const routeName = 'usersprofile';

  @override
  _UsersProfileState createState() => _UsersProfileState(this.Id);
}

class _UsersProfileState extends State<UsersProfile> {
  bool click = false;
  List jsonData=[];
  bool show = false;
  bool love=false;
  bool block=false;

  var userId;

  _UsersProfileState(this.userId);

  void getUserData() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/getUser?id=${this.userId}'),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader:
        'Bearer $KUserToken',
      },
    );

    if (response.statusCode == 200) {
      var data;
      setState(() {
        data = json.decode(response.body);
        var jsonData = User.fromJson(data);
        UsersProfile.nameJson = jsonData.name;
        UsersProfile.emailJson = jsonData.email;
        UsersProfile.genderJson = jsonData.gender;
        UsersProfile.imageJson=jsonData.image;
        UsersProfile.certifiedJson = jsonData.certified;
        UsersProfile.vipJson = jsonData.VIP;
        UsersProfile.ageJson = jsonData.age;
        UsersProfile.banJson = jsonData.ban;
        UsersProfile.banCountJson = jsonData.ban_count;
        UsersProfile.reportJson = jsonData.reports;
        UsersProfile.birthDayJson = jsonData.birth_day;
        UsersProfile.answerJson = jsonData.answered;
        UsersProfile.phoneJson = jsonData.phone;
      });
      print(UsersProfile.imageJson);
    }
  }

  var data;
  Future<List<QuestionUsersProfile>> getQuestionsUser() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/show-user?user_id=${this.userId}'),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $KUserToken',
      },
    );

    if (response.statusCode == 200) {
      data = json.decode(response.body);

      List<dynamic> question=data;
      List<QuestionUsersProfile>jsonData=[];

      for(var i=0; i< question.length;i++){
        QuestionUsersProfile quest = QuestionUsersProfile(question_id: question[i][0][0]['id'], question: question[i][0][0]['question'], answer:question[i][2][0]['answer'], hidden: question[i][1][0]['hidden']);
        jsonData.add(quest);
      };
      //  jsonData.add(data);
      //jsonData.asMap();
      return jsonData;
    } else {
      throw Exception('Failed to load Questions');
    }
  }

  void addFriend(int userId) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/addFriend');

    await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $KUserToken'
      },
      body: {
        "recevier_id":userId.toString(),
      },
    ).then((value){
      print('body:${value.body}');
      print('status:${value.statusCode}');

    });
  }

  void removeFriend(int userId) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/removeFromFav');
    await http.delete(
        url,
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $KUserToken'
        },
        body: {
          "id":userId.toString()
        }
    ).then((value){
      print('body:${value.body}');
      print('status:${value.statusCode}');

    });
  }

  void blockFriend(int userId) async {
        var url = Uri.parse('http://10.0.2.2:8000/api/blockFriend');

        await http.post(
        url,
        headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $KUserToken'
        },
        body: {
        "reciever_id":userId.toString(),
        },
    ).then((value){
      print('body:${value.body}');
      print('status:${value.statusCode}');

    });
  }

  void removeBlockFriend(int userId) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/removeBlock');
    await http.delete(
        url,
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $KUserToken'
        },
        body: {
          "blockId":userId.toString()
        }
    ).then((value){
      print('body:${value.body}');
      print('status:${value.statusCode}');

    });
  }

  @override
  void initState() {
    super.initState();

    // TODO: implement initState
    this.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final user = UserInfo.user;
    return WillPopScope(
      onWillPop: () {
        Navigator.popAndPushNamed(context, Home.routeName);
        return new Future(() => false);
      },
      child: Scaffold(
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
        body:SingleChildScrollView(
            child:Column(
          children: [
            const SizedBox(height: 15),
            ProfileWidget(
              imagePath: UsersProfile.imageJson ==''?UsersProfile.image:UsersProfile.imageJson,
              onClicked: () async {},
            ),
            const SizedBox(height: 24),
            name(),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: (){
                      setState((){
                        love=!love;
                      });
                      if(love==true) {
                        addFriend(this.userId);
                      }else{
                        removeFriend(this.userId);
                      }
                    },
                    icon: Icon(
                       love==false? FontAwesomeIcons.heart:FontAwesomeIcons.solidHeart
                    ),
                  color: lightTheme.hintColor,
                ),

                const SizedBox(
                  width: 20,
                ),

                IconButton(
                  onPressed: (){
                    setState((){
                      block=!block;
                    });

                    if(block==true) {
                      Fluttertoast.showToast(
                          msg: 'لقد قمت بحظر هذا الحساب',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: lightTheme.hintColor,
                          textColor: Colors.white,
                          fontSize: 16.0);

                      blockFriend(this.userId);
                    }else{
                      Fluttertoast.showToast(
                          msg: 'لقد قمت بازالة الحظر عن هذا الحساب',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: lightTheme.hintColor,
                          textColor: Colors.white,
                          fontSize: 16.0);

                      removeBlockFriend(this.userId);
                    }
                  },
                  icon: Icon(IconData(59359, fontFamily: 'MaterialIcons')),
                  //color: lightTheme.hintColor,
                ),

              ],
            ),
            const SizedBox(height: 30),
            numbers(),
            const SizedBox(height: 30),

            FlatButton(
                onPressed:(){
                  setState(() {
                    show=!show;
                  });
                },
                child: Text(
                  show==false?'عرض الاسئلة':'اخفاء الاسئلة',
                  style: TextStyle(color: Colors.white,fontSize: 12),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                color: lightTheme.hintColor,
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16)),

            const SizedBox(height: 30),
            show==true ? FutureBuilder(
                future: getQuestionsUser(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.hasData) {
                    List<QuestionUsersProfile> list = snapshot.data ?? [];
                    return ListView.builder(

                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, int index) {
                        return Card(
                          elevation: 12,
                          shape: BeveledRectangleBorder(),
                          child: Column(
                            children: [
                              Text(
                                list[index].question,
                                style: TextStyle(
                                  color: lightTheme.hintColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                list[index].answer,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }else{
                    return Center(
                        child: CircularProgressIndicator(
                          valueColor:AlwaysStoppedAnimation<Color>(Color(0xffff6265)),
                        )
                    );
                  }
                }):Container(),
            SizedBox(height: 20,),
          ],
        )),
        drawer: CustomDrawer(),
      ),
    );
  }

  Widget name() => Column(
    children: [
      Text(
        UsersProfile.nameJson,
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'openSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic),
      ),
      const SizedBox(height: 4),
      Text(
        UsersProfile.emailJson,
        style: TextStyle(
            color: Colors.grey,
            fontFamily: 'openSans',
            fontSize: 13,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic),
      ),
      const SizedBox(height: 5),

      UsersProfile.vipJson==1 ? Text(
        "مميز",
        style: TextStyle(
            color: lightTheme.hintColor,
            fontFamily: 'openSans',
            fontSize: 17,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic),
      ):Text(''),

      const SizedBox(height: 5),

    ],
  );

  Widget numbers() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Expanded(
        child: Column(
          children: [
            Text(
              "تاريخ الميلاد",
              style: TextStyle(
                  color: lightTheme.hintColor,
                  fontFamily: 'openSans',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            Text(
              "${UsersProfile.birthDayJson}",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'openSans',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
        flex: 1,
      ),
      const SizedBox(width: 5),
      Text(
        '|',
        style: TextStyle(
          color: Colors.grey,
          fontFamily: 'openSans',
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(width: 5),
      Expanded(
        child: InkWell(
          onTap: () {},
          child: Column(
            children: [
              Text(
                "عدد مرات الحظر",
                style: TextStyle(
                    color: lightTheme.hintColor,
                    fontFamily: 'openSans',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              Text(
                "${UsersProfile.banCountJson}",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'openSans',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        flex: 1,
      ),
      const SizedBox(width: 5),
      Text(
        '|',
        style: TextStyle(
          color: Colors.grey,
          fontFamily: 'openSans',
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(width: 5),
      Expanded(
          child: InkWell(
              onTap: () {} /*() => views(context)*/,
              child: Column(
                children: [
                  Text(
                    'عدد مرات الابلاغ',
                    style: TextStyle(
                        color: lightTheme.hintColor,
                        fontFamily: 'openSans',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  Text(
                    "${UsersProfile.reportJson}", // حد عمله لاف هتظهر Vip بس
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'openSans',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              )),
          flex: 1),
    ],
  );
}

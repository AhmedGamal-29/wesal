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
import 'package:marry_me/Models/User.dart';
import 'package:marry_me/Utility/Themes.dart';
import 'package:marry_me/Views/Home.dart';
import 'package:marry_me/Views/Login.dart';
import 'package:marry_me/Views/Signup.dart';

import '../Globals.dart';
import 'Certified.dart';
import 'Search.dart';

class Profile extends StatefulWidget {
  static var userId;

  static var nameJson = 'User';

  static var emailJson = 'user@gmail.com';

  static var phoneJson;

  static var ageJson;

  static var banJson;

  static var banCountJson;

  static var birthDayJson;

  static var vipJson = 0;

  static var certifiedJson = 0;

  static var image =
      "https://a6ciswdyxn-flywheel.netdna-ssl.com/wp-content/uploads/bb-plugin/cache/no-profile-image-e1568830705855-square.png";

  static var imageJson = '';

  static var answerJson;

  static var reportJson;

  static var genderJson = 'female';

  static var question = 'm';
  static var question_id;
  static var answer = 'l';
  static var answer_id;

  Profile({Key? key}) : super(key: key);
  static const routeName = 'profile';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool click = false;
  bool hide = false;
  bool show = false;

  late Future<List<QuestionUser>> list;

  var length;
 // List jsonData = [];
  int i = 0;

  void getUserData() async {
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
        var jsonData = User.fromJson(data);
        Profile.userId = jsonData.id;
        Profile.nameJson = jsonData.name;
        Profile.emailJson = jsonData.email;
        Profile.genderJson = jsonData.gender;

        if (jsonData.image != '') {
          Profile.imageJson = jsonData.image;
        } else {
          Profile.phoneJson = Profile.image;
        }

        Profile.certifiedJson = jsonData.certified;

        if(jsonData.VIP==null){
         Profile.vipJson=0;
        }else{
          Profile.vipJson = jsonData.VIP;
        }

        Profile.ageJson = jsonData.age;
        Profile.banJson = jsonData.ban;
        Profile.banCountJson = jsonData.ban_count;
        Profile.reportJson = jsonData.reports;
        Profile.birthDayJson = jsonData.birth_day;
        Profile.answerJson = jsonData.answered;
        Profile.phoneJson = jsonData.phone;
      });
      print(Profile.imageJson);
    }
  }

  var data;
  Future<List<QuestionUser>> getQuestionsUser() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/show-user?user_id=${Profile.userId}'),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $KUserToken',
      },
    );

    if (response.statusCode == 200) {
      data = json.decode(response.body);

        List<dynamic> question=data;
        List<QuestionUser>jsonData=[];

        for(var i=0; i< question.length;i++){
           QuestionUser quest = QuestionUser(question_id: question[i][0][0]['id'], question: question[i][0][0]['question'], answer:question[i][2][0]['answer'], hidden: question[i][1][0]['hidden']);
           jsonData.add(quest);
           };
        //  jsonData.add(data);
        //jsonData.asMap();
        return jsonData;
      } else {
      throw Exception('Failed to load Questions');
    }
  }

  void deleteAccount() {
    //int id = Profile.userId;
    var url = Uri.parse('http://10.0.2.2:8000/api/delete');

    http.delete(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer  $KUserToken'
    }).then((response) => {
          print('Response body:${response.body}'),
          print('Response Status: ${response.statusCode}')
        });
  }

  void showQuestion(id) async {
    await http.get(
      Uri.parse('http://10.0.2.2:8000/api/unhide?question_id=$id'),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer  $KUserToken',
      },
    ).then((response) => {
          /*if(response.statusCode==200){
              setState(() {
              hide = false;
              })
          },*/
          print('Response body:${response.body}'),
          print('Response Status: ${response.statusCode}')
        }
    );
  }

  void hideQuestion(id) async {
    await http.get(
      Uri.parse('http://10.0.2.2:8000/api/hide?question_id=$id'),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $KUserToken',
      },

    ).then((response) => {
          /*if(response.statusCode==200){
              setState(() {
              hide = true;
             })
          },*/
          print('Response body:${response.body}'),
          print('Response Status: ${response.statusCode}')
        });
  }

  Widget alertDelete() {
    return Container(
      width: double.infinity,
      child: AlertDialog(
        title: Text(
          "هل انت متأكد من حذف حسابك الشخصي ؟",
          style: TextStyle(fontSize: 16),
        ),
        content: Container(
          height: 150,
          child: Column(
            children: [
              Divider(color: Colors.black),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Login.routeName);
                    deleteAccount();
                    setState(() {
                      click = false;
                    });
                  },
                  child: Text(
                    'نعم',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )),
              SizedBox(height: 10),
              FlatButton(
                  onPressed: () {
                    setState(() {
                      click = false;
                    });
                  },
                  child: Text(
                    'لا',
                    style: TextStyle(
                        color: lightTheme.hintColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  //late Future<List<dynamic>?> questions;

  @override
  void initState() {

    // TODO: implement initState
    this.getUserData();
    getQuestionsUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.popAndPushNamed(context, Home.routeName);
        return new Future(() => false);
      },
      child:Home.option !=3? Scaffold(
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

          backgroundColor: Colors.white38,

        ),
        body: SingleChildScrollView(
          child: Column(
            //physics: BouncingScrollPhysics(),
            children: [

              const SizedBox(height: 15),
              Center(
                child: Stack(
                    children: [
                      Image(
                        Profile.imageJson == '' ? Profile.image : Profile.imageJson,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context)
                                  .scaffoldBackgroundColor,
                            ),
                            color: lightTheme.hintColor,
                          ),
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: IconButton(
                              padding:EdgeInsets.all(3.5),
                              icon: Icon(Icons.edit),
                              color: Colors.white,
                              onPressed: () => {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (_) {
                                    return EditProfile(Profile.question_id); // Block instead chat
                                  },
                                ))
                              },
                            )

                          ),
                          ),
                        ),
                    ]
                ),
              ),
              const SizedBox(height: 24),
              name(),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                      onPressed: () {},
                      child: Text(
                        "ترقية",
                        style: TextStyle(color: Colors.white,fontSize: 14),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      color: lightTheme.hintColor,
                      padding: EdgeInsets.fromLTRB(14, 14, 14, 14)),
                  const SizedBox(
                    width: 20,
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => Certified()));
                      },
                      child: Text(
                        "تصديق حسابي",
                        style: TextStyle(color: Colors.white,fontSize: 12),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      color: lightTheme.hintColor,
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 16)),
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
                      List<QuestionUser> list = snapshot.data ?? [];
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Profile.vipJson==1 ?
                                    list[index].hidden==0
                                      ? TextButton.icon(
                                    key:Key(list[index].hidden.toString()),
                                    onPressed: () {
                                      hideQuestion(list[index].question_id.toString());
                                    },
                                    label: Text(
                                      "اخفاء السؤال",
                                      style:
                                      TextStyle(color: Colors.black),
                                    ),
                                    icon: Icon(
                                      FontAwesomeIcons.eyeSlash,
                                      color: lightTheme.hintColor,
                                      size: 17,
                                    ),
                                  ):
                                    TextButton.icon(
                                      key:Key(list[index].question_id.toString()),
                                      onPressed: () {
                                        showQuestion(list[index].question_id.toString());
                                      },
                                      label: Text(
                                        "اظهار السؤال",
                                        style:
                                        TextStyle(color: Colors.black),
                                      ),
                                      icon: Icon(
                                        FontAwesomeIcons.eye,
                                        color: lightTheme.hintColor,
                                        size: 17,
                                      ),
                                    ):
                                  TextButton(onPressed: (){},child: Text(''),),

                                  const SizedBox(
                                    width: 20,
                                  ),
                                  TextButton.icon(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  EditProfile(list[index].question_id)
                                          )
                                      );
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.edit,
                                      color: lightTheme.hintColor,
                                      size: 17,
                                    ),
                                    label: Text(
                                      "تعديل اجابة السؤال",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
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
              click == true ? alertDelete() : Container(),
            ],
          ),
        ),
        drawer: CustomDrawer(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.delete),
          onPressed: () {
            setState(() {
              click = !click;
            });
          },
          backgroundColor: lightTheme.hintColor,
        ),
      ) : Scaffold(
        body: SingleChildScrollView(
          child: Column(
            //physics: BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 15),
              Center(
                child: Stack(
                    children: [
                      Image(
                        Profile.imageJson == '' ? Profile.image : Profile.imageJson,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context)
                                  .scaffoldBackgroundColor,
                            ),
                            color: lightTheme.hintColor,
                          ),
                          child: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: IconButton(
                                padding:EdgeInsets.all(3.5),
                                icon: Icon(Icons.edit),
                                color: Colors.white,
                                onPressed: (){
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (_) {
                                      return EditProfile(Profile.question_id); // Block instead chat
                                    },
                                  ));

                                  Home.option=0;
                                },
                              )

                          ),
                        ),
                      ),
                    ]
                ),
              ),
              const SizedBox(height: 24),
              name(),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                      onPressed: () {
                        Home.option=0;
                      },
                      child: Text(
                        "ترقية",
                        style: TextStyle(color: Colors.white,fontSize: 14),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      color: lightTheme.hintColor,
                      padding: EdgeInsets.fromLTRB(14, 14, 14, 14)),
                  const SizedBox(
                    width: 20,
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => Certified()));
                        Home.option=0;
                      },
                      child: Text(
                        "تصديق حسابي",
                        style: TextStyle(color: Colors.white,fontSize: 12),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      color: lightTheme.hintColor,
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 16)),
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
                      List<QuestionUser> list = snapshot.data ?? [];
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Profile.vipJson==1 ?
                                    list[index].hidden==0
                                        ? TextButton.icon(
                                      key:Key(list[index].question_id.toString()),
                                      onPressed: () {
                                        showQuestion(list[index].question_id);
                                      },
                                      label: Text(
                                        "اظهار السؤال",
                                        style:
                                        TextStyle(color: Colors.black),
                                      ),
                                      icon: Icon(
                                        FontAwesomeIcons.eye,
                                        color: lightTheme.hintColor,
                                        size: 17,
                                      ),
                                    ) : TextButton.icon(
                                      key:Key(list[index].hidden.toString()),
                                      onPressed: () {
                                        hideQuestion(list[index].question_id);
                                      },
                                      label: Text(
                                        "اخفاء السؤال",
                                        style:
                                        TextStyle(color: Colors.black),
                                      ),
                                      icon: Icon(
                                        FontAwesomeIcons.eyeSlash,
                                        color: lightTheme.hintColor,
                                        size: 17,
                                      ),
                                    ):TextButton(onPressed: (){},child: Text(''),),

                                    const SizedBox(
                                      width: 20,
                                    ),
                                    TextButton.icon(
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    EditProfile(list[index].question_id)
                                            )
                                        );
                                        Home.option=0;
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.edit,
                                        color: lightTheme.hintColor,
                                        size: 17,
                                      ),
                                      label: Text(
                                        "تعديل اجابة السؤال",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
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
              click == true ? alertDelete() : Container(),
            ],
          ),
        ),
        drawer: CustomDrawer(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.delete),
          onPressed: () {
            setState(() {
              click = !click;
            });
          },
          backgroundColor: lightTheme.hintColor,
        ),
      ),
    );
  }

/*
  void blockPage(BuildContext ctx) {
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_) {
      return Home(); // Block instead chat
    }));
  }
*/
  void views(BuildContext ctx) {
    if (Profile.vipJson == 1) {
      Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_) {
        return Home(); // View instead Home
      }));
    } else {
      Fluttertoast.showToast(
          msg: 'قم ترقية حسابك',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
  }

  Widget name() => Column(
        children: [
          Text(
            Profile.nameJson,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'openSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 4),
          Text(
            Profile.emailJson,
            style: TextStyle(
                color: Colors.grey,
                fontFamily: 'openSans',
                fontSize: 13,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
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
                  "${Profile.birthDayJson}",
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
                    "${Profile.banCountJson}",
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
                        "${Profile.reportJson}", // حد عمله لاف هتظهر Vip بس
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

  Widget Image(imge) {
    final image = NetworkImage(imge);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: () {}),
        ),
      ),
    );
  }
}

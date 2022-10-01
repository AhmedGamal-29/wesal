import 'dart:convert';
import 'dart:io';
import 'package:marry_me/Models/User.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:marry_me/Models/QuestionAndAnswerUser.dart';
import 'package:marry_me/Utility/Themes.dart';
import 'package:marry_me/Views/Profile.dart';
import 'package:marry_me/Views/Search.dart';

import '../../Globals.dart';
import 'AppBar.dart';

class EditProfile extends StatefulWidget {
  var questionId;
  EditProfile(this.questionId) ;
  static const routeName = 'editProfile';

  @override
  _EditProfileState createState() => _EditProfileState(questionId);
}

class _EditProfileState extends State<EditProfile> {
  var questId;
  _EditProfileState(this.questId);
  bool choose = false;
  bool otherBool=false;
  var picked;
  var name = Profile.nameJson;
  var image = Profile.imageJson;
  var phone = Profile.phoneJson;
  var answer='' ;
  var question ='';
 var answer_id ;
  var ans='الاجابة';
  var other="اخرى";

  final phoneController = TextEditingController();
  final otherController = TextEditingController();
  final questionController = TextEditingController();
  final answerController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  var val;
  var pickedFile;
  var imagePick;

  List answers=[];
  List jsonData = [];

  void getQuestions() async {
    if(questId==null){
      questId=1;
    }
    print(this.questId);
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/get-question-by-id?id=${this.questId}'),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer  $KUserToken',
      },
    );

    if (response.statusCode == 200) {
      var data;
      setState(() {
        data = json.decode(response.body);
        this.question = data['question'];
      });
      print(data);
    }
  }

  Future<String> getAnswers() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/get-question-answers?id=${this.questId}'),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer  $KUserToken',
      },
    );

    if (response.statusCode == 200) {
      var data;
      setState(() {
        data = json.decode(response.body);
       answers=data;
        /* this.answer = data[0]['answer'];
         this.answer_id = data[0]['id'];*/
      });
      print(answer_id);
    }
    return 'Done';
  }

  /*Future getAllQuestionsUser() async {
    final response = await http.get(
      Uri.parse('http://localhost:8000/api/show-user?user_id=${Profile.userId}'),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer  $KUserToken',
      },
    );

    if (response.statusCode == 200) {
      var data;
      var question;
      List list=[];

      setState(() {
        data = json.decode(response.body);
        list.add(data);
        list.asMap();
        jsonData.add(list[0]);
        jsonData.asMap();
       /* var j=0;
        for(var i=0; i<list[0][0].length; i++){
          print(list[0][0].length);
         print('/////////00');
          jsonData[j]=list[i][0][0][0];
         print('kkkk${jsonData}');
          j++;
        }
        jsonData.asMap();
        print(jsonData);
*/
      });
    } else {
      print('Error 404');
    }
  }*/


  void editPhone() {
//    int id = Profile.userId;
    var url = Uri.parse('http://10.0.2.2:8000/api/EditInfo');

    http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization':
      'Bearer  $KUserToken'
    }, body: {
      'phone': Profile.phoneJson,
    }).then((response) => {
      print('Response body:${response.body}'),
      print('Response Status: ${response.statusCode}')
    });
  }

  void editAnswer() {
    print("Fffffffffffffff $answer_id");
//    int id = Profile.userId;
    var url = Uri.parse('http://10.0.2.2:8000/api/EditInfo');

    http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization':
      'Bearer  $KUserToken'
    }, body: {
      'new_answer': answer_id.toString(),
      'question_id':questId.toString(),
    }).then((response) => {
      print('Response body:${response.body}'),
      print('Response Status: ${response.statusCode}')
    });
  }

  void editImage(image) async{
//    int id = Profile.userId;
    var url = Uri.parse('http://10.0.2.2:8000/api/EditInfo');

    /*String imgName = image.path.split('/').last;
    print(imgName);*/

    await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $KUserToken'
      },
      body: {
        'image': image,
      },
    ).then((value){
      print('body:${value.body}');
      print('status:${value.statusCode}');

    });
  }

  void deleteImage() async{
//    int id = Profile.userId;
    var url = Uri.parse('http://10.0.2.2:8000/api/deleteImage');

    await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $KUserToken'
      },
      body: {
        'image':'',
      },
    ).then((value){
      print('body:${value.body}');
      print('status:${value.statusCode}');

    });
  }

  /*void saveAnswer() {
    // print("Fffffffffffffff $answer_id");
//    int id = Profile.userId;
    var url = Uri.parse('http://10.0.2.2:8000/api/save-answer');

    http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization':
      'Bearer  $KUserToken'
    }, body: {
      'answer': other,
      'question_id':questId.toString(),
    }).then((response) => {
      print('Response body:${response.body}'),
      print('Response Status: ${response.statusCode}')
    });
  }*/

  @override
  void initState() {
    super.initState();

    // TODO: implement initState

    this.getQuestions();
    this.getAnswers();
  }

  @override
  Widget build(BuildContext context) {
    //  var user = Profile.dataJson[0];
    var _image = Profile.imageJson;

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
              "تعديل الحساب",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontFamily: 'openSans',
                  fontStyle: FontStyle.italic),
            ),
            backgroundColor: Colors.white38,

          ),
          body: Container(
              padding: EdgeInsets.only(left: 16, top: 25, right: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Image(),
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
                                    child:  PopupMenuButton(
                                      onSelected: (value)=>{},
                                      itemBuilder:(context) => [
                                        PopupMenuItem(
                                          child:TextButton.icon(
                                            onPressed: (){
                                              setState(() {
                                                //image =picked;
                                                Profile.imageJson=Profile.image;
                                                deleteImage();

                                              });
                                            },
                                            label:Text('حذف الصورة',style: TextStyle(
                                              color:Colors.black,
                                            ),),
                                            icon:Icon(Icons.delete, color:lightTheme.hintColor),
                                          ),
                                          value: 1,
                                        ),
                                        PopupMenuItem(
                                          child:TextButton.icon(
                                            onPressed: ()=>{
                                              setState((){
                                                choose=!choose;
                                              })
                                            },
                                            label:Text('تعديل الصورة',style: TextStyle(
                                              color:Colors.black,
                                            ),),
                                            icon:Icon(Icons.edit, color:lightTheme.hintColor),
                                          ),
                                          value: 2,
                                        )
                                      ],
                                    padding: EdgeInsets.all(3.5),
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    ),
                                  ),
                              ),
                          )
                        ]
                      ),
                    ),
                    const SizedBox(height: 30),
                    choose==true ? chooseImage(context) : Container(),
                    const SizedBox(height: 30),

                    SingleChildScrollView(
                        child: Column(
                      children: [

                        TextField(
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.number,
                          textDirection:TextDirection.rtl ,
                          controller: phoneController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 4),
                            labelText: "رقم الهاتف المحمول",
                            labelStyle: TextStyle(
                                color: lightTheme.hintColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: Profile.phoneJson,
                            hintTextDirection: TextDirection.rtl,
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'openSans'),
                          ),
                        ), // phone

                        const SizedBox(height: 30),

                        DropdownButton(
                          focusColor: lightTheme.hintColor,
                          isExpanded: true,
                          items: [
                            DropdownMenuItem(
                              child: Text(this.question,textDirection: TextDirection.rtl,),
                              value: questId,
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              val = value as int;
                              otherBool=true;
                            });
                          },
                          hint: Text(this.question,textDirection: TextDirection.rtl,),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'openSans'),
                          dropdownColor: Colors.white,
                        ), //Questions

                        const SizedBox(height: 30),

                        DropdownButton(
                          focusColor: lightTheme.hintColor,
                          isExpanded: true,
                          items:answers.map((data){
                              return DropdownMenuItem(
                              child: Text(data['answer'],textDirection: TextDirection.rtl,),
                              value: data['id'],
                              );}).toList(),

                          onChanged: (value) {
                            setState(() {
                              val = value as int;
                              ans=this.answer;
                            });
                          },
                          value: val,
                          hint: Text(ans,textDirection: TextDirection.rtl,),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'openSans'),

                          dropdownColor: Colors.white,
                        ), //Answers

                        const SizedBox(height: 30),

                        /*otherBool==true? TextField(
                          textAlign: TextAlign.right,
                          textDirection:TextDirection.rtl ,
                          controller: otherController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 4),
                            labelText: "أخرى",
                            labelStyle: TextStyle(
                                color: lightTheme.hintColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: other,
                            hintTextDirection: TextDirection.rtl,
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'openSans'),
                          ),
                        ):TextField(),*/ // other
                      ],
                    )),
                    const SizedBox(height: 30),
                    FlatButton(
                        onPressed: () {
                          if(Profile.phoneJson!=phoneController.text){
                            setState(() {
                              Profile.phoneJson = phoneController.text;
                              print(Profile.phoneJson);
                              editPhone();
                            });

                          }else if(answer_id != val){
                            setState((){
                              answer_id=val;
                              editAnswer();
                            });
                          }

                          /*if(otherBool==true) {
                            setState(() {
                              other = otherController.text;
                              saveAnswer();
                            });
                          }*/
                          /*   Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => Profile()));*/
                        },
                        child: Text(
                          "حفظ التعديلات",
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        color: lightTheme.hintColor,
                        padding: EdgeInsets.fromLTRB(12, 12, 12, 12)),
                  ],
                ),
              ))),
    );
  }

  Future getImage(ImageSource src) async {
    var data = (await ImagePicker().pickImage(source: src))!;
    File file = File(data.path).absolute;
    picked = file;
    editImage((file.readAsBytesSync()));
    /*pickedFile = await ImagePicker().getImage(source: src);

    if (pickedFile != null) {
      imagePick = File(pickedFile.path);
      setState(() {
        image = imagePick.toString();
      });
      print(image);
      editImage(imagePick);
      print('Image selected.');
    } else {
      print('No image selected.');
    }*/
  }

  Builder buildDialogItem(
      BuildContext context, String text, IconData icon, ImageSource src) {
    return Builder(
      builder: (innerContext) => Container(
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
                MaterialPageRoute(builder: (_) => EditProfile(this.questId)));
          },
        ),
      ),
    );
  }

  Widget chooseImage(BuildContext context) {
    return Container(
      width: double.infinity,
      child: AlertDialog(
        title:Text("اختر صورة من : ",textAlign: TextAlign.center, ),
        content: Container(
          height: 150,
          child: Column(
            children: [
              Divider(color: Colors.black),
              buildDialogItem(context, "الكاميرا", Icons.add_a_photo_outlined,
                  ImageSource.camera),
              SizedBox(height: 10),
              buildDialogItem(context, "مجلد الصور", Icons.image_outlined,
                  ImageSource.gallery),
            ],
          ),
        ),
      ),
    );
  }

  Widget Image() {
    final image = NetworkImage(this.image);

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

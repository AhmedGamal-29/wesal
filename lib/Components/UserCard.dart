import 'package:flutter/material.dart';
import 'package:marry_me/Globals.dart';
import 'package:marry_me/View_Model/UserViewModel.dart';
import 'package:marry_me/Views/UsersProfile.dart';
import '../Models/User.dart';
import 'package:marry_me/Views/RecentChats.dart';

class UserCard extends StatefulWidget {
  UserCard({required this.person});

  final User person;

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {

  _navigateToChat() {
    Navigator.pushReplacementNamed(context, RecentChats.routeName);
  }

  // _navigateToUser() {
  //   Navigator.pushReplacement(context, UsersProfile());
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UsersProfile(widget.person.id)),
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
                      backgroundImage: NetworkImage(widget.person.image),
                    ),
                ),
                  ),
                 Padding(
                   padding: const EdgeInsets.only(left: 8.0),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children:[
                       Text(widget.person.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Frutiger',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                       ),
                       Text("age:  "+widget.person.age.toString()),
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
                         onTap: ()async{
                           int res =await addFriend(widget.person.id);

                            if (res==201) {
                             showDialog<String>(
                                 context: context,
                                 builder: (BuildContext context) =>
                                     AlertDialog(
                                         title: const Text(
                                             'تم اضافة هذه الشخص الي قائمة الاصدقاء بنجاح'),
                                         // content: const Text('ستبدا المحادثة حينما يوافق لبطرف الاخر علي الطلب'),
                                         actions: <Widget>[
                                           TextButton(
                                             onPressed: () =>
                                                 Navigator.pop(context, 'Cancel'),
                                             child: const Text('موافق'),
                                           )
                                         ]));
                            }
                            else if(res==400)
                            {
                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                          title: const Text(
                                              'لقد أضفت هذا الشخص من قبل'),
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
                            else if(res==402)
                            {
                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                          title: const Text(
                                              'لقد أضفت هذا الشخص من قبل في قائمة الخظر لا يمكنك اضافته'),
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
                           padding: const EdgeInsets.only(left: 12.0,right: 12),
                           child: Icon(Icons.favorite,color:Color(0xffff6265)),
                         ),
                       ),
                       GestureDetector(
                         onTap: () async {
                           if (userVip==1)
                             {

                               int res =await startChat(widget.person.id);
                               if (res==201)
                                 {
                                   _navigateToChat();
                                 }

                             }
                           else
                             {
                               Future<int> res=sentRequest(widget.person.id);
                               print(res.toString());

                                   showDialog<String>(
                                       context: context,
                                       builder: (BuildContext context) =>
                                           AlertDialog(
                                               title: const Text('تم ارسال الطلب بنجاح'),
                                               content: const Text('ستبدا المحادثة حينما يوافق الطرف الاخر علي الطلب'),
                                               actions: <Widget>[
                                                 TextButton(
                                                   onPressed: () => Navigator.pop(context, 'Cancel'),
                                                   child: const Text('موافق'),
                                                 )]));

                             }
                         },
                         child: Padding(
                           padding: const EdgeInsets.only(left: 12.0,right: 12),
                           child: Icon(Icons.chat_bubble,color:Color(0xffff6265)),
                         ),
                       ),
                       // Padding(
                       //   padding: const EdgeInsets.only(left: 12.0,right: 12),
                       //   child: Icon(Icons.block,color:Color(0xffff6265)),
                       // )
                     ],
                   ),
                 ),
              ]
                ),
            ),
          ),

        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:marry_me/Components/CustomDrawer.dart';
import 'package:marry_me/Components/LastMessageCard.dart';
import 'package:marry_me/Components/ReceivedImageMessageItem.dart';
import 'package:marry_me/Models/ChatRoomData.dart';
import 'package:marry_me/Models/RecentChat.dart';
import 'package:marry_me/View_Model/MessageHandel.dart';
import 'package:marry_me/View_Model/RecentChatHandel.dart';
import '../Globals.dart';
import 'Chat.dart';
import 'Home.dart';

class RecentChats extends StatefulWidget {
  const RecentChats({Key? key}) : super(key: key);
  static const routeName = 'recentChat';
  @override
  _RecentChatsState createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  late Future<List<RecentChat>> list;
  @override
  Widget build(BuildContext context) {
    list = getRecentChats();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Recent Chat', style: TextStyle(fontSize: 22),),
        actions: [
          Container(
              margin: EdgeInsets.only(right: 10),
              child: ImageIcon(AssetImage('assets/images/People - simple-line-icons.png'))),
        ],
      ),
      body: FutureBuilder(future: list
        ,builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
        if(snapshot.hasData){
          List<RecentChat> list = snapshot.data ?? [];
          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                RecentChat item = list[index];
                ChatRoomData chatRoomData = ChatRoomData(chatId: item.chatId, userId: 1, receiverId: item.userId, receiverImage: item.image, userImage: '', receiverName: item.name, block: item.block);
                return InkWell(child: LastMessageCard(recentChat: item), onTap: ()=>Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Chat(chatRoomData: chatRoomData)),
                ));
              });
        }else if(snapshot.hasError){
          print(snapshot.error);
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Error In Loading Chats', style: TextStyle( fontSize: 18),),
                SizedBox(height: 10,),
                TextButton(onPressed: ()=> Navigator.pushReplacementNamed(context, Home.routeName), child: Text('Go Back', style: TextStyle(color: Theme.of(context).hintColor),))
              ],
            ),
          );
        }{
          return Center(child: CircularProgressIndicator());
        }
      }),
      drawer: CustomDrawer(),
    );
  }


  getRecentChats(){
    return RecentChatHandel.retrieveRecentChats();
  }
}

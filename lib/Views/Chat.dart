import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marry_me/Components/MessageTypeHandel.dart';
import 'package:marry_me/Components/SendMessageButtonComponent.dart';
import 'package:marry_me/Models/ChatRoomData.dart';
import 'package:marry_me/Models/Message.dart';
import 'package:marry_me/View_Model/MessageHandel.dart';
import 'package:marry_me/Views/RecentChats.dart';

import '../Globals.dart';

class Chat extends StatefulWidget {
  Chat({Key? key, required this.chatRoomData}) : super(key: key);
  ChatRoomData chatRoomData;
  bool replay = false;
  static const routeName = 'chat';
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late Future<List<Message>> list;

  @override
  Widget build(BuildContext context) {
    list = getMessages();
    return Scaffold(
      appBar: AppBar(
        title: Row(children:[
          Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.chatRoomData.receiverImage),
            ),
          ),
          Text(widget.chatRoomData.receiverName, style: TextStyle(fontSize: 22),)
        ]),
        actions: [
          Container(
              margin: EdgeInsets.only(right: 10),
              child:  PopupMenuButton(
                onSelected: (value)=>{},
                itemBuilder:(context) => [
                  PopupMenuItem(
                    child: Text("Block" , style: TextStyle(fontSize: 14)),
                    value: 1,
                  )
                ],
              ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Expanded(child: FutureBuilder(future: list
                ,builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                  if(snapshot.hasData){
                    List<Message> list = snapshot.data ?? [];
                    return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          Message item = list[index];
                          return InkWell(child: MessageTypeHandel(message: item, changeReplay: changeReplay,));
                        });
                  }else if(snapshot.hasError){
                    print(snapshot.error);
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Error In Loading Messages', style: TextStyle( fontSize: 18),),
                          SizedBox(height: 10,),
                          TextButton(onPressed: ()=> Navigator.pushReplacementNamed(context, RecentChats.routeName), child: Text('Go Back', style: TextStyle(color: Theme.of(context).hintColor),))
                        ],
                      ),
                    );
                  }{
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            ),
            (widget.chatRoomData.block == false)?SendMessageComponent(replay: widget.replay,changeReplay: changeReplay,):Container(child: Center(child: Text('Cant Send Message', style: TextStyle(color: Theme.of(context).hintColor),),),)
          ],
        ),
      )
    );
  }

  getMessages(){
    return MessageHandel.getAllMessages(widget.chatRoomData.chatId);
  }

  changeReplay(){
    if(widget.replay == true){
      setState(() {
        widget.replay = false;
      });
    }else{
      setState(() {
        widget.replay = true;
      });
    }
  }
}

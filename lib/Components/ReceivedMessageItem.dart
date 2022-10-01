import 'package:flutter/material.dart';
import 'package:marry_me/Models/ApiResponse.dart';
import 'package:marry_me/Models/Message.dart';
import 'package:marry_me/View_Model/MessageHandel.dart';

import 'MessageActionMenue.dart';

class ReceivedMessageItem extends StatefulWidget {
  Function() changeReplay;
  ReceivedMessageItem({Key? key, required this.message, required Function() this.changeReplay}) : super(key: key);
  Message message;
  @override
  _ReceivedMessageItemState createState() => _ReceivedMessageItemState();
}

class _ReceivedMessageItemState extends State<ReceivedMessageItem> {
  var borderColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 60,bottom: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(width: 0.5, color: borderColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          padding: EdgeInsets.all(5),
                          color: Colors.grey,
                          child: Text('Replay: ${widget.message.content}', style: TextStyle(fontSize: 12, color: Colors.white),),
                        ),
                        Text(widget.message.content, style: TextStyle(fontSize: 14),),
                      ]
                    ),
                  ),
                  Text(widget.message.getDateFormatted().toString(), style: TextStyle(fontSize: 12)),
                ],
              ),
            )
          ],
        ),
      ),
      onLongPress: (){
          SnackBar snackBar = SnackBar(duration: Duration(seconds: 2),
                                        content: actionBar(context, widget.message.id, changeContent, widget.changeReplay),padding: EdgeInsets.all(5),);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //MessageActionMenue(context, widget.message.id, changeContent);
      }
    );
  }

  changeContent(value){
    setState(() {
      widget.message.content = value;
      borderColor = Colors.red;
    });
  }
}
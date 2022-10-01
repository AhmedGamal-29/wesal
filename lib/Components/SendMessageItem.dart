import 'package:flutter/material.dart';
import 'package:marry_me/Models/Message.dart';

import 'MessageActionMenue.dart';
class SendMessageItem extends StatefulWidget {
  Function() changeReplay;

  SendMessageItem({Key? key, required this.message, required Function() this.changeReplay}) : super(key: key);
  Message message;
  @override
  _SendMessageItemState createState() => _SendMessageItemState();
}

class _SendMessageItemState extends State<SendMessageItem> {
  late Color borderColor;

  @override
  Widget build(BuildContext context) {
    borderColor = Theme.of(context).hintColor;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 60, bottom: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                            width: 0.5, color: borderColor),
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
            ),
            SizedBox(width: 10,),
          ],
        ),
      ),

      onLongPress: (){
        SnackBar snackBar = SnackBar(duration: Duration(seconds: 2),
            content: actionBar(context, widget.message.id, changeContent, widget.changeReplay),padding: EdgeInsets.all(5));
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

import 'package:flutter/material.dart';
import 'package:marry_me/Models/Message.dart';
class ReceivedImageMessageItem extends StatefulWidget {
  ReceivedImageMessageItem({Key? key, required this.message}) : super(key: key);
  Message message;
  @override
  _ReceivedImageMessageItemState createState() => _ReceivedImageMessageItemState();
}

class _ReceivedImageMessageItemState extends State<ReceivedImageMessageItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(right: 60,bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Image.network(widget.message.content),
          ),
          Text(widget.message.getDateFormatted().toString(), style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

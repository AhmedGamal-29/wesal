import 'package:flutter/material.dart';
import 'package:marry_me/Models/Message.dart';
class SendImageMessageItem extends StatefulWidget {
  SendImageMessageItem({Key? key, required this.message}) : super(key: key);
  Message message;
  @override
  _SendImageMessageItemState createState() => _SendImageMessageItemState();
}

class _SendImageMessageItemState extends State<SendImageMessageItem> {
  @override
  Widget build(BuildContext context) {
    print(widget.message.content);
    return Container(
      margin: EdgeInsets.only(bottom: 20, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              margin: EdgeInsets.only(left: 60,bottom: 10),
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

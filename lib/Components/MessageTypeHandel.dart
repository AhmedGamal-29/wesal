import 'package:flutter/material.dart';
import 'package:marry_me/Components/ReceivedMessageItem.dart';
import 'package:marry_me/Components/SendMessageItem.dart';
import 'package:marry_me/Models/Message.dart';
import 'ReceivedImageMessageItem.dart';
import 'SendImageMessageItem.dart';

class MessageTypeHandel extends StatelessWidget {
  Function() changeReplay;

  MessageTypeHandel({Key? key, required this.message, required Function() this.changeReplay}) : super(key: key);
  Message message;
  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<AppProvider>(context);
    //User user = provider.getUser()!;

    if (message.isImage == 1) {
      return message.senderId == 1
          ? SendImageMessageItem(message: message):
          ReceivedImageMessageItem(message: message);
    }
    else {
      return message.senderId == 1
          ? SendMessageItem(message: message, changeReplay: changeReplay)
          : ReceivedMessageItem(message: message, changeReplay: changeReplay);
    }
    /*return message.senderId == 1
        ? SendMessageItem(message: message)
        : ReceivedMessageItem(message: message);*/
  }
}

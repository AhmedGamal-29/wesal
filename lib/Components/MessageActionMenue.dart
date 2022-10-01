import 'package:flutter/material.dart';
import 'package:marry_me/Models/ApiResponse.dart';
import 'package:marry_me/Models/Message.dart';
import 'package:marry_me/View_Model/MessageHandel.dart';

MessageActionMenue(context,messageId, Function(String) changeContent){
  late SnackBar snackBar;
  late ApiResponse obj;
  return showMenu(context: context,position: RelativeRect.fromLTRB(0, 0, 0, 0),items: [
    PopupMenuItem(
      child: Text("Replay" , style: TextStyle(fontSize: 14)),
      onTap: (){

      },
    ),
    PopupMenuItem(
      child: Text("Report" , style: TextStyle(fontSize: 14)),
      onTap: () async{
        obj = await MessageHandel.reportMessage(messageId);
        snackBar = SnackBar(content: Text(obj.message));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if(obj.done()){
          changeContent(obj.message);
        }
      },
    ),
    PopupMenuItem(
      child: Text("Delete" , style: TextStyle(fontSize: 14)),
      onTap: () async {
        obj = await MessageHandel.deleteMessage(messageId);
        snackBar = SnackBar(content: Text(obj.message));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if(obj.done()){
          changeContent(obj.message);
        }
      },
    )
  ]);
}

actionBar(context,messageId, Function(String) changeContent, Function() changeReplay){
  late SnackBar snackBar;
  ApiResponse obj;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TextButton(onPressed: () async{
        obj = await MessageHandel.reportMessage(messageId);
        snackBar = SnackBar(content: Text(obj.message));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if(obj.done()){
          changeContent(obj.message);
        }
      }, child: Text('Report')),
      TextButton(onPressed: ()async{
        obj = await MessageHandel.deleteMessage(messageId);
        snackBar = SnackBar(content: Text(obj.message));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if(obj.done()){
          changeContent(obj.message);
        }
      }, child: Text('Delete')),
      TextButton(onPressed: (){
        changeReplay();
      }, child: Text('Replay')),
    ],
  );
}

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marry_me/Models/ApiResponse.dart';
import 'package:marry_me/View_Model/MessageHandel.dart';

class SendMessageComponent extends StatefulWidget {
  bool replay;
  Function() changeReplay;
  SendMessageComponent({Key? key,required this.replay, required Function() this.changeReplay}) : super(key: key);
  bool isImage = false;
  late File image;
  @override
  _SendMessageComponentState createState() => _SendMessageComponentState();
}

class _SendMessageComponentState extends State<SendMessageComponent> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        returnReplay(),
        Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: textController,
                keyboardType: TextInputType.name,
                cursorColor: Theme.of(context).hintColor,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'Write Message…',
                ),
              ),
            ),
            IconButton(onPressed: (){uploadImage();}, icon: Icon(Icons.attach_file)),
            Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Theme.of(context).hintColor,
                    borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(onPressed: (){
                        MessageHandel.sendMessage(43, textController.value.text);
                        textController.clear();
                    },
                    icon: ImageIcon(AssetImage('assets/images/Cursor - simple-line-icons.png'), color: Colors.white,))
            ),
          ],
        )
      ),
      ]
    );
  }


  Widget returnReplay(){
    if(widget.isImage){
      return Container(
          color: Colors.grey,
          width: double.infinity,
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              (widget.image == null)?Text('Error Upload Image'): Image.file(widget.image, width: 80, height: 80,),
            ],
          )
      );
    }else if(widget.replay){
      if(false){
        return Container(
          height: 40,
          color: Colors.grey,
          child: Center(child: Text('hello this is a replay message', style: TextStyle(color: Colors.white),)),
        );
      }else{
        return Container(
          color: Colors.grey,
          width: double.infinity,
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network('https://lh3.googleusercontent.com/proxy/b2fNZK7t5Y44QQ7q1sY3vuHJ_LXNl8Y_lPeAnfsDoeTxswLXUWvMScKTXqO3CILu7pzJzZtW2JdlgjEGSQ',height: 80, width: 80,),
            ],
          )
        );
      }
    }else{
      return Container();
    }
  }

  uploadImage()async{
    var data = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    File file = File(data.path).absolute;
    widget.image = file;
    setState(() {
      widget.isImage = true;
    });
    MessageHandel.sendImage(43,
        (file.readAsBytesSync()));
    //print(obj.message);
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marry_me/Models/RecentChat.dart';
class LastMessageCard extends StatefulWidget {
  RecentChat recentChat;
  LastMessageCard({Key? key, required this.recentChat}) : super(key: key);
  @override
  _LastMessageCardState createState() => _LastMessageCardState();
}

class _LastMessageCardState extends State<LastMessageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 8, right: 8, bottom: 3),
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Theme.of(context).hintColor, width: 0.5),
          )
      ),
      child: Row(
        children: [
          Container(
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Container(
                  width: 55,
                  height: 55,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.recentChat.image),
                  ),
                ),
                (widget.recentChat.online == 1)?Container(
                  width: 9,
                  height: 9,
                  margin: EdgeInsets.only(right: 2,bottom: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).hintColor,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ):Center(),
              ],
            ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.recentChat.name, style: TextStyle(fontSize: 16,),),
                        SizedBox(height: 5,),
                        Text((!isImage(widget.recentChat.content))?widget.recentChat.content:'Image',
                          style: TextStyle(color: Colors.grey, fontSize: 12,), maxLines: 3, overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(widget.recentChat.getDateFormatted().toString(), style: TextStyle(fontSize: 14,)),
                      ),
                      (widget.recentChat.unreadMessage != 0)?Container(
                        width: 20,
                        height: 20,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).hintColor,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Center(child: Text(widget.recentChat.unreadMessage.toString(), style: TextStyle(color: Colors.white),)),
                      ):Container(),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  isImage(String image){
    return image.contains('http');
  }
}


/*

class _LastMessageCardState extends State<LastMessageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 8, right: 8, bottom: 3),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).hintColor, width: 0.5),
        )
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/img_avatar.png'),
            ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text('Abdelrhman', style: TextStyle(fontSize: 14,),)),
                      /*Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Theme.of(context).hintColor,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),*/
                      Container(
                        child: Text('2:30 PM'),
                      )
                    ],
                  ),
                  SizedBox(height: 2,),
                  Row(
                    children: [
                      Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry .', style: TextStyle(color: Colors.grey, fontSize: 12, ),),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Theme.of(context).hintColor,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Text('4', style: TextStyle(color: Colors.white, fontSize: 12),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
*/

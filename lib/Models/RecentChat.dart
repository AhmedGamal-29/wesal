import 'package:intl/intl.dart';

class RecentChat{
  String name, image, content, createdAt;
  int unreadMessage,online, status, userId, chatId;
  bool block;
  RecentChat({required this.image,required this.name, required this.chatId, required this.userId,
    required this.content, required this.unreadMessage, required this.createdAt, required this.online, required this.status,required this.block});

  RecentChat.fromJson(Map<String,dynamic> json):this(
    name: json['name'] as String,
    image: json['image'] as String,
    userId: json['user_id'] as int,
    chatId: json['chat_id'] as int,
    content: json['content'] as String,
    unreadMessage: json['unreadcount'] as int,
    createdAt: json['created_at'] as String,
    status: json['status'] as int,
    online: json['online'] as int,
    block: json['block'] as bool,
  );


  String getDateFormatted(){
    var output = DateFormat('HH:mm a');
    return output.format(DateTime.parse(createdAt));
  }
}
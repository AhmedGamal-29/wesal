import 'package:intl/intl.dart';

class Message{
  int id;
  int senderId;
  int receiverId;
  int chatId;
  String content;
  int status;
  int isImage;
  String time;

  Message({required this.id,required this.content,required this.time,required this.receiverId, required this.senderId,
           required this.chatId, required this.status, required this.isImage});

  Message.fromJson(Map<String,dynamic> json):this(
    id: json['id'] as int,
    senderId: json['sender_id'] as int,
    receiverId: json['reciever_id'] as int,
    chatId: json['chat_id'] as int,
    status: json['status'] as int,
    content: json['content'] as String,
    time: json['created_at'] as String,
    isImage: json['isImg'] as int,
  );

  Map<String, Object?> toJson(){
    return{
      'id': id,
      'content': content,
      'time': time,
      'receiverId': receiverId,
      'senderId': senderId
    };
  }

  String getDateFormatted(){
    var output = DateFormat('HH:mm a');
    return output.format(DateTime.parse(time));
  }

}
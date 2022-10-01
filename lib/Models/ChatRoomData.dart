import 'package:marry_me/Models/RecentChat.dart';

class ChatRoomData{
  int chatId, userId, receiverId;
  String userImage, receiverImage, receiverName;
  bool block;
  ChatRoomData({required this.chatId, required this.userId, required this.receiverId,
                required this.receiverImage, required this.userImage, required this.receiverName, required this.block});
}
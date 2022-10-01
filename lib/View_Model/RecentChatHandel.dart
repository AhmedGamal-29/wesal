import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:marry_me/Models/RecentChat.dart';

import '../Globals.dart';

class RecentChatHandel{
  static Future<List<RecentChat>> retrieveRecentChats() async{
    final response = await http.get(
      Uri.parse('$BaseUrl/api/listallchats'),
      headers: {
        'Accept' : 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $KUserToken',
      },
    );
    print(convert.jsonDecode(response.body));
    if (response.statusCode == 200) {
      List<dynamic> list = convert.jsonDecode(response.body);
      List<RecentChat> recentChat = [];
      list.forEach((element) {
        recentChat.add(RecentChat.fromJson(element));
      });
      return recentChat;
    } else {
      throw Exception('Failed to load Recent chats ${convert.jsonDecode(response.body)['message']}');
    }
  }
}
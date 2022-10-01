import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:marry_me/Models/ApiResponse.dart';
import 'dart:io';

import 'package:marry_me/Models/Message.dart';

import '../Globals.dart';

class MessageHandel{
  static Future<List<Message>> getAllMessages(chatId) async{
    final response = await http.get(
      Uri.parse('$BaseUrl/api/fetchmsgs/$chatId'),
      headers: {
        'Accept' : 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $KUserToken',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> list = convert.jsonDecode(response.body);
      List<Message> recentChat = [];
      list.forEach((element) {
        recentChat.add(Message.fromJson(element));
      });
      return recentChat;
    } else {
      throw Exception('Failed to load Recent chats ${response.body}');
    }
  }

  static sendMessage(chatId,content) async{
    final queryParameters = {
      'chat_id':  chatId.toString(),
      'content' : content.toString()
    };
    final response = await http.post(
      Uri.parse('$BaseUrl/api/sendmsg'),
      headers: {
        'Accept' : 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $KUserToken}',
      },
      body: queryParameters
    );
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load Recent chats ${response.body}');
    }
  }


  static reportMessage(messageId) async{
    final queryParameters = {
      'message_id':  messageId.toString(),
    };
    final response = await http.post(
        Uri.parse('$BaseUrl/api/report'),
        headers: {
          'Accept' : 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $KUserToken',
        },
        body: queryParameters
    );
    ApiResponse obj = ApiResponse(status: response.statusCode, message: convert.jsonDecode(response.body)['message'].toString());
    if (response.statusCode == 200) {
      return obj;
    } else {
      return obj;
    }
  }

  static deleteMessage(messageId) async{
    final response = await http.delete(
        Uri.parse('$BaseUrl/api/deletemsg/$messageId'),
        headers: {
          'Accept' : 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $KUserToken',
        },
    );
    ApiResponse obj = ApiResponse(status: response.statusCode, message: convert.jsonDecode(response.body)[0].toString());
    if (response.statusCode == 200) {
      return obj;
    } else {
      return obj;
    }
  }

  static sendImage(chatId, image) async{
    final response = await http.post(
      Uri.parse('$BaseUrl/api/sendpic'),
      headers: {
        'Accept' : 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $KUserToken',
      },
      body: {
        'chat_id': chatId.toString(),
        'image': image
      }
    );
    print(image.toString());
    //ApiResponse obj = ApiResponse(status: response.statusCode, message: convert.jsonDecode(response.body)[0].toString());
    print('////////////////////////////////////////// ${response.body}//////////////////////');
    if (response.statusCode == 200) {
      //return obj;
    } else {
      //return obj;
    }
  }
}

import 'dart:convert';

import 'package:marry_me/services/globals.dart';
import 'package:http/http.dart' as http;

import 'auth_services.dart';

class ApiCalls{
  static Future<http.Response> search(
      { String? name,String? age,String? height,String? nationality,String?weight ,String?status}) async {
    Map data = {"name":name,"age":age,"height" :height,"nationality":nationality,"martial_status":status};

print("object");
    var body = jsonEncode(data);
    var url = Uri.parse(base_url + "searchreq");
    http.Response response = await http.post(
      url,
      headers: {"Content-Type": "application/json",
      },
     
    );
    print(response.body);


    print("search here");

    return response;
  }

static Future<http.Response> getFriends(
      { String? name,String? age,String? height,String? nationality,String?weight ,String?status}) async {
    Map data = {"name":name,"age":age,"height" :height,"nationality":nationality,"martial_status":status};

    var body = jsonEncode(data);
    var url = Uri.parse(base_url + "search");
    http.Response response = await http.post(
      url,
      headers: {"Content-Type": "application/json",
        "Authorization":'Bearer ${AuthServices.token}'
      },
      body: body,
    );
    print(response.body);


    print("search here");

    return response;
  }

static Future<http.Response> getRequests() async {
   // Map data = {"name":name,"age":age,"height" :height,"nationality":nationality,"martial_status":status};

   // var body = jsonEncode(data);
    var url = Uri.parse(base_url + "getAllFriends");
    http.Response response = await http.post(
      url,
      headers: {"Content-Type": "application/json",
        "Authorization":'Bearer ${AuthServices.token}'
      },
     
    );
   


    print("friends here");
     print(response.body);

    return response;
  }












}
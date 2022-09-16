import 'dart:convert';

import 'package:marry_me/services/globals.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  static Future<http.Response> login(
      {required String email, required String password}) async {
    Map data = {"email": email, "password": password};

    var body = jsonEncode(data);
    var url = Uri.parse(base_url + "login");
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    print("i am here");
    return response;
  }
}

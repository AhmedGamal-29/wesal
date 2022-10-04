import 'dart:convert';

import 'package:marry_me/services/globals.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  static String token="";

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
    token=json.decode(response.body)['AccessToken'];

    print("iam here");
    print("$token");
    return response;
  }

  static Future<http.Response> register(
      {required String name,required String email, required String password,
      required String confirm_password,required String gender,required String phone,
        required String date,required String status


      }) async {
    Map data = {"name": name,"email": email,"password": password,
      "password_confirmation": confirm_password,"phone": phone,"gender": gender,
      "birth_day": date,"martial_status": status};

    var body = jsonEncode(data);
    var url = Uri.parse(base_url + "register");
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    print("iam here");
    return response;
  }


static Future<http.Response> chatify() async{


  var url = Uri.parse(home_url + "chatify");
  http.Response response = await http.get(
    url,
    headers: headers,

  );
  return response;
}

}

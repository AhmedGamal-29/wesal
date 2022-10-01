import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:marry_me/Globals.dart' ;
// import 'package:dio/dio.dart';

class NetworkHelper {
  NetworkHelper(this.url);

  String url;

  Future getData(bool ifToken,var endPoint) async {

      var response = await http.get(
        (Uri.parse(BaseUrl + endPoint)),
        headers: {"authorization": "Bearer " + KUserToken},
      );

      return response;
    }



  Future postData(Map<String, dynamic> Body, bool ifToken) async {
    print(url);

    if (ifToken) {
      var uri = Uri.parse(url);
      var response = await http.post(
        uri,
        body: Body,
        headers: {
          'Token': KUserToken,
        },
      );

      return response;
    } else {
      var uri = Uri.parse(url);
      var response = await http.post(
        uri,
        body: Body,
      );

      return response;
    }
  }
}


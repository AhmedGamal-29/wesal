import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../Globals.dart';

List<Favs> postFromJson(String str) =>
    List<Favs>.from(json.decode(str).map((x) => Favs.fromMap(x)));

class Favs {
  Favs({

    required this.id,
    required this.user_1,
    required this.user2_image,
    required this.updated_at,
    required this.created_at,
    required this.user_2,
    required this.age,
    required this.name,

  });


  int id;
  int user_1;
  int user_2;
  var age;
  String user2_image;
  String name;
  String updated_at;
  String created_at;


  factory Favs.fromMap(Map<String, dynamic> json) => Favs(
    id: json["id"],
    created_at: json["created_at"],
    name: json["name"],
    age: json["age"],
    user_1: json['user_1'],
    updated_at: json["updated_at"],
    user_2: json["user_2"],
    user2_image: json["user2_image"],
  );
  factory Favs.fromJson(Map<String, dynamic> json) {
    return Favs(
      id: json['id'],
      //title: json['title'],
      created_at: json["created_at"],
      name: json["name"],
      age: json["age"],
      user_1: json['user_1'],
      updated_at: json["updated_at"],
      user_2: json["user_2"],
      user2_image: json["user2_image"],

    );
  }

}



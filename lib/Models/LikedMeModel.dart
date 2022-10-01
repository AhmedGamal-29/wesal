// To parse this JSON data, do
//
//     final liked = likedFromJson(jsonString);

import 'dart:convert';

List<Liked> likedFromJson(String str) => List<Liked>.from(json.decode(str).map((x) => Liked.fromJson(x)));

String likedToJson(List<Liked> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Liked {
  Liked({
    required this.id,
    required this.user_1,
    required this.user_2,
    required this.name,
    required this.age,
    required this.user2_image,
    required this.created_at,
    required this.updated_at,
  });

  int id;
  int user_1;
  int user_2;
  String name;
  var age;
  String user2_image;
  DateTime created_at;
  DateTime updated_at;

  factory Liked.fromJson(Map<String, dynamic> json) => Liked(
    id: json["id"],
    user_1: json["user_1"],
    user_2: json["user_2"],
    name: json["name"],
    age: json["age"],
    user2_image: json["user2_image"],
    created_at: DateTime.parse(json["created_at"]),
    updated_at: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_1": user_1,
    "user_2": user_2,
    "name": name,
    "age": age,
    "user2_image": user2_image,
    "created_at": created_at.toIso8601String(),
    "updated_at": updated_at.toIso8601String(),
  };
}


/*
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../Globals.dart';

List<Liked> LikedFromJson(String str) =>
    List<Liked>.from(json.decode(str).map((x) => Liked.fromMap(x)));

class Liked {
  Liked({
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
  double age;
  String user2_image;
  String name;
  String updated_at;
  String created_at;


  factory Liked.fromMap(Map<String, dynamic> json) => Liked(

    id: json["id"],
    created_at: json["created_at"],
    name: json["name"],
    age: 0,//json["age"],
    user_1: json["user_1"],
    updated_at: json["updated_at"],
    user_2: json["user_2"],
    user2_image: json["user2_image"],
  );
  }*/
// To parse this JSON data, do
//
//     final Req = ReqFromJson(jsonString);

import 'dart:convert';

List<Req> ReqFromJson(String str) => List<Req>.from(json.decode(str).map((x) => Req.fromJson(x)));

String ReqToJson(List<Req> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Req {
  Req({
    required this.id,
    required this.sender_id,
    required this.name,
    required this.age,
    required this.status,
    required this.image,

  });

  int id;
  int sender_id;
  String name;
  var age;
  var status;
  String image;


  factory Req.fromJson(Map<String, dynamic> json) => Req(
    id: json["id"],
    sender_id: json["sender_id"],
    name: json["name"],
    age: json["age"].toDouble(),
    status: json["status"],
    image: json["image"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender_id": sender_id,
    "name": name,
    "age": age,
    "status": status,
    "image": image,

  };
}

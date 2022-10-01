// To parse this JSON data, do
//
//     final Request = RequestFromJson(jsonString);

import 'dart:convert';

List<Request> RequestFromJson(String str) => List<Request>.from(json.decode(str).map((x) => Request.fromJson(x)));

String RequestToJson(List<Request> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Request {
  Request({
    required this.id,
    required this.req_id,
    required this.name,
    required this.age,
    required this.status,
    required this.image,

  });

  int id;
  int req_id;
  String name;
  var age;
  int status;
  String image;


  factory Request.fromJson(Map<String, dynamic> json) => Request(
    id: json["id"],
    req_id: json["req_id"],
    name: json["name"],
    age: json["age"].toDouble(),
    status: json["status"],
    image: json["image"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "req_id": req_id,
    "name": name,
    "age": age,
    "status": status,
    "image": image,

  };
}

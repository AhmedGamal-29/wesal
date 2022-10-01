// To parse this JSON data, do
//
//     final block = blockFromJson(jsonString);

import 'dart:convert';

List<Block> blockFromJson(String str) => List<Block>.from(json.decode(str).map((x) => Block.fromJson(x)));

String blockToJson(List<Block> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Block {
  Block({
    required this.id,
    required this.blocker_id,
    required this.name,
    required this.age,
    required this.blocked_id,
    required this.blocked_image,
    required this.created_at,
    required this.updated_at,
  });

  int id;
  int blocker_id;
  String name;
  var age;
  int blocked_id;
  String blocked_image;
  DateTime created_at;
  DateTime updated_at;

  factory Block.fromJson(Map<String, dynamic> json) => Block(
    id: json["id"],
    blocker_id: json["blocker_id"],
    name: json["name"],
    age: json["age"].toDouble(),
    blocked_id: json["blocked_id"],
    blocked_image: json["blocked_image"],
    created_at: DateTime.parse(json["created_at"]),
    updated_at: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "blocker_id": blocker_id,
    "name": name,
    "age": age,
    "blocked_id": blocked_id,
    "blocked_image": blocked_image,
    "created_at": created_at.toIso8601String(),
    "updated_at": updated_at.toIso8601String(),
  };
}

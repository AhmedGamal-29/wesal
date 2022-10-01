import 'package:intl/intl.dart';
import 'package:marry_me/Views/Profile.dart';

class User {
  static const collectionName = 'users';
  int id;
  String name;
  String email;
  String phone;
  String birth_day;
  var age; // new field
  String gender;
  String image;
  var reports;
  var answered;
  var ban;
  var ban_count;
  var certified;
  var VIP;


  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.birth_day,
    required this.age,
    required this.gender,
    required this.image,
    required this.reports,
    required this.answered,
    required this.ban,
    required this.ban_count,
    required this.certified,
    required this.VIP,


  });

  User.fromJson(Map<String,dynamic> json):this(
    id: json['id'] ,
    name:json['name'] as String,
    email:json['email'] as String,
    phone:json['phone'] as String,
    birth_day: json['birth_day'] as String,
    age: json['age'] ,
    gender:json['gender'] as String,
    image : json['image']== null ? Profile.image : json['image'],
    reports : json['reports'] ,
    answered:json['answered'] ,
    ban: json['ban'] ,
    ban_count : json['ban_count'] ,
    certified: json['certified'] ,
    VIP: json['VIP'] ,
  );

}

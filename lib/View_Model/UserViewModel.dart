import '../Services/networking.dart';
import '../Models/User.dart';
import '../Globals.dart';
import 'dart:convert';
import '../Components/UserCard.dart';
import 'package:http/http.dart' as http;



  Future<List<UserCard>> getPreferenceList() async {

    List<dynamic> userbody=[];

    List<User> persons=[];

    List<UserCard> users=[];


    var res =  await http.get(
      (Uri.parse(BaseUrl + '/api/preference')),
      headers: {"authorization": "Bearer " + KUserToken},
    );
    print(res.statusCode);
    if (res.statusCode == 200) {

      List<dynamic> body=jsonDecode(res.body);





      body.forEach((element) {
        userbody.add(element["user"][0]);
        print(element["user"][0]);
      });

      userbody.forEach((element) {
        persons.add(User(id: element["id"], name: element["name"], email: element["email"],phone:  element["phone"], birth_day:  element["birth_day"], age:  element["age"].floor(), gender:  element["gender"], image:  element["image"], reports:  element["reports"], answered:  element["answered"], ban:  element["ban"], ban_count:  element["ban_count"], certified:  element["certified"], VIP:  element["VIP"]));
        print(persons.length);
      });


      persons.forEach((element) {

        print(element.name);
        users.add(UserCard(person: element));

      });


      print(users.length);



    }
    return users;

  }

  Future<List<UserCard>> searchFreeUser(String nameQuery,String vipQuery,String ageQuery,String banCountQuery,String certifiedQuery) async{

    List<dynamic> userbody=[];

    List<User> persons=[];

    List<UserCard> users=[];

    var res = await http.post(
      (Uri.parse(BaseUrl + "/api/filter")),
      headers: {"authorization": "Bearer " + KUserToken},
      body: {"name":nameQuery,
              "vip":vipQuery,
              "age":ageQuery,
              "ban_count":banCountQuery,
              "certified":certifiedQuery}
    );

    print(res.statusCode);
    print(res.body);

    if (res.statusCode == 200) {

    List<dynamic> body=jsonDecode(res.body);


    // print(body.length);


    body.forEach((element) {
      userbody.add(element);
      print(element["name"]);
      print("saad");

    });



    body.forEach((element) {
      print(element);
    });


    userbody.forEach((element) {

      persons.add(User(id: element["id"], name: element["name"], email: element["email"],phone:  element["phone"], birth_day:  element["birth_day"], age:  element["age"].floor(), gender:  element["gender"], image:  element["image"], reports:  element["reports"], answered:  element["answered"], ban:  element["ban"], ban_count:  element["ban_count"], certified:  element["certified"], VIP:  element["VIP"]));
      print(persons.length);
    });


    print(persons.length);

    persons.forEach((element) {

      print(element.name);
      users.add(UserCard(person: element));

    });




    }
    // print(users.length);
    return users;

}

get_user() async {

var myUser;
  var res =  await http.get(
    (Uri.parse(BaseUrl + '/api/profile')),
    headers: {"authorization": "Bearer " + KUserToken},
  );
  return res;
}

Future<int>sentRequest(int receverId) async {

  var res =  await http.post(
    (Uri.parse(BaseUrl + '/api/request')),
    headers: {"authorization": "Bearer " + KUserToken},
      body: {"recevier":receverId.toString()}
  );

  print(res.statusCode);
  if (res.statusCode == 200) {

    Map<String,dynamic> body=jsonDecode(res.body);
  }
  return res.statusCode;

}

Future<int> startChat(int userId) async {

  var res =  await http.post(
      (Uri.parse(BaseUrl + '/api/startchat')),
      headers: {"authorization": "Bearer " + KUserToken},
      body: {"userid2":userId.toString()}
  );

  if (res.statusCode == 200) {

    Map<String,dynamic> body=jsonDecode(res.body);

  }
  return res.statusCode;

}

Future<int> addFriend(int userId) async {

  var res =  await http.post(
      (Uri.parse(BaseUrl + '/api/addFriend')),
      headers: {"authorization": "Bearer " + KUserToken},
      body: {"recevier_id":userId.toString()}
  );

  if (res.statusCode == 200) {

    Map<String,dynamic> body=jsonDecode(res.body);

  }
  return res.statusCode;
  }

Future<int> removeBlock(int userId) async {

  var res =  await http.delete(
      (Uri.parse(BaseUrl + '/api/removeBlock')),
      headers: {"authorization": "Bearer " + KUserToken},
      body: {"blockId":userId.toString()}
  );

  print(res.statusCode);
  if (res.statusCode == 200) {

    Map<String,dynamic> body=jsonDecode(res.body);

  }
  return res.statusCode;

}
Future<int> removeRequest(int userId) async {

  var res =  await http.delete(
      (Uri.parse(BaseUrl + '/api/deleteRequest')),
      headers: {"authorization": "Bearer " + KUserToken},
      body: {"id":userId.toString()}
  );

  print(res.statusCode);
  if (res.statusCode == 200) {

    Map<String,dynamic> body=jsonDecode(res.body);

  }
  return res.statusCode;

}

Future<int> removeFriend(int userId) async {

  var res =  await http.delete(
      (Uri.parse(BaseUrl + '/api/removeFromFav')),
      headers: {"authorization": "Bearer " + KUserToken},
      body: {"id":userId.toString()}
  );

  print(res.statusCode);
  if (res.statusCode == 200) {

    Map<String,dynamic> body=jsonDecode(res.body);

  }
  return res.statusCode;

}

Future<int> blockFriend(int userId) async {

  var res =  await http.post(
      (Uri.parse(BaseUrl + '/api/blockFriend')),
      headers: {"authorization": "Bearer " + KUserToken},
      body: {"reciever_id":userId.toString()}
  );

  if (res.statusCode == 200) {

    Map<String,dynamic> body=jsonDecode(res.body);

  }
  return res.statusCode;

}
Future<int> dec(int userId,int r) async {
  final queryParameters = {
    'sender':  userId.toString(),
    'replay' : r.toString()
  };
  var res =  await http.post(
      (Uri.parse(BaseUrl + '/api/decision')),
      headers: {"authorization": "Bearer " + KUserToken},
      body: queryParameters,
  );

  if (res.statusCode == 200) {

    Map<String,dynamic> body=jsonDecode(res.body);

  }
  return res.statusCode;

}
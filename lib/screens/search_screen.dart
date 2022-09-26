import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marry_me/components/default_useritem.dart';
import 'package:marry_me/constants/const.dart';
import 'package:marry_me/screens/users_screen.dart';
import 'package:marry_me/services/api.dart';
import 'package:searchfield/searchfield.dart';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';


import 'package:http/http.dart' as http;


import '../models/user.dart';

class SearchScreen extends StatefulWidget {
 
  static const id = 'search_screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
   List<Map<String,dynamic>> users_found=[];
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("enterd");
    //searchPressed();
    print(users_found.length);
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        bottomOpacity: 90,
        backgroundColor: Color(0x52CC9595),
        elevation: 0,
        title: const Center(child: Text('Welcome, Ali',
        style:TextStyle(
          fontFamily: 'PlayfairDisplay',
          color: Color(0xff030303)

        )
         )
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
          
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Find your \nbest Match !',
                  style: TextStyle(
                      fontFamily: "DMSans",
                      fontSize: 30.0,
                      
                      fontWeight: FontWeight.bold),
                ),
                Image(image:AssetImage("assets/images/avatar.png"),),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            Center(
              child: Container(
                height: 47,
                width: 306,
                child: TextFormField(
                  
                  decoration: InputDecoration(
                    suffixIcon:IconButton(icon:Icon(Icons.search),
                    onPressed: (){

                    },
                    
                    
                    ) ,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                
                )
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Results',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: "OpenSans",
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color:  const Color(0x106750A4),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    ' ${users_found.length} users found    ',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            Flexible(
              child: ListView.separated(
                itemBuilder: (context, index) => defaultUserItem(users_found[index]),
                separatorBuilder: (context, index) 
                 
                  => Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 20.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                ),
                itemCount: users_found.length,
              ),
            ),
          ],
        ),
      ),
      
    );
  }

  searchPressed()async{
     http.Response response= await ApiCalls.search( );
var response_json = json.decode(response.body);
     for(var u in response_json){
      Map<String,dynamic> map={
        "name":u['name'],"age":u['age'],"gender":u['gender'],"martial_status":u['martial_status']
      };
      users_found.add(map);

     }
      

  }
}

import 'package:flutter/material.dart';
import 'package:marry_me/Components/Profile_Components/Edit.dart';
import 'package:marry_me/Utility/Themes.dart';
import 'package:marry_me/Views/ForgotPassword.dart';
import 'package:marry_me/Views/Profile.dart';
import 'package:marry_me/Views/Quiz.dart';
import 'package:marry_me/Views/Splash.dart';
import 'package:marry_me/Views/VerifyEmail.dart';
import 'package:marry_me/Views/requests.dart';
import 'Views/Blocks.dart';
import 'Views/Chat.dart';
import 'Views/Fav.dart';
import 'Views/Home.dart';
import 'Views/Likedme.dart';
import 'Views/Login.dart';
import 'Views/RecentChats.dart';
import 'Views/Signup.dart';
import 'Views/UsersProfile.dart';
import 'Views/VerifyEmail.dart';
import 'package:provider/provider.dart';
import 'Models/UserModel.dart';
import 'Models/ChatRoomData.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Views/UsersProfile.dart';
import 'Views/requestsrecieved.dart';

void main() async{
  /*WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
        create: (context) => MyModel(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Marry Me',
          theme: lightTheme,
          initialRoute: Login.routeName,
          routes: {
            Splash.routeName: (context) => Splash(),
            requests.routeName: (context) => requests(),
            requestsrecieved.routeName: (context) => requestsrecieved(),
            Home.routeName: (context) => Home(),
            RecentChats.routeName: (context) => RecentChats(),
            Chat.routeName: (context) => Chat(chatRoomData: ChatRoomData(userImage: '',userId: 0,receiverName: '',receiverImage: '',receiverId: 0,chatId: 0, block: true),),
           Login.routeName: (context) => Login(),
            ForgotPassword.routeName: (context) => ForgotPassword(),
           Signup.routeName: (context) => Signup(),
            VerifyEmail.routeName: (context) => VerifyEmail(),
            Profile.routeName: (context) => Profile(),
            EditProfile.routeName: (context) => EditProfile(0),
            UsersProfile.routeName: (context) => UsersProfile(0),
            Quiz.routeName: (context)=>Quiz(),
            Likedme.routeName: (context)=>Likedme(),
            Blocks.routeName: (context)=>Blocks(),
            Fav.routeName: (context)=>Fav(),
          },
        )
    );
  }
}

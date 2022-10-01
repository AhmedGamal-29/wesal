import 'package:flutter/material.dart';
import 'package:marry_me/Components/UserCard.dart';
import 'package:marry_me/Globals.dart';
import '../View_Model/UserViewModel.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../Models/UserModel.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class DataSearch extends SearchDelegate<String> {
  late Future<List<UserCard>> users;
  FocusNode focusNode = new FocusNode();

  String name = "";
  String vip ="";
  String age ="";
  String banCount="";
  String certified = "";


  Color vipColor = Colors.black;

  Color ageColor = Colors.black;

  Color banCountColor = Colors.black;

  Color certifiedColor = Colors.black;


  Widget VipOrFreeUserWidget(final user)
  {


    if (user.getPerson().VIP==1)
      {
        // name="";

        return   Container(
          child: PopupMenuButton<String>(
            icon: Icon(
              Icons.filter_list_outlined,
              color: Color(0xffff6265),
            ),
            onSelected: (String result) {},
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[


              PopupMenuItem<String>(
                child: ToggleSwitch(
                  minWidth: 60.0,
                  // minHeight: 90.0,
                  fontSize: 12.0,
                  initialLabelIndex: 1,
                  activeBgColor: [Color(0xffff6265)],
                  activeFgColor: Colors.white,
                  inactiveBgColor:Colors.grey[350],
                  inactiveFgColor: Colors.grey[900],
                  totalSwitches: 2,
                  labels: ['VIP', 'الكل'],
                  onToggle: (index) {

                    if (index==1)
                      {
                        vip="";
                      }
                    else if (index==0)
                      {
                        vip="1";
                      }

                  },
                ),

                // TextButton(
                //   style: TextButton.styleFrom(
                //     // padding: EdgeInsets.all(16.0),
                //     primary: vipColor,
                //     textStyle: TextStyle(fontSize: 17),
                //   ),
                //   onPressed: () {
                //     if (vipColor == Colors.black) {
                //
                //       vip="1";
                //
                //       vipColor = Color(0xffff6265);
                //     }
                //
                //     else {
                //       vip="";
                //       vipColor = Colors.black;
                //
                //     }
                //   },
                //   child: const Text('VIP'),
                // ),
              ),

              PopupMenuItem<String>(
                child: ToggleSwitch(
                  minWidth: 60.0,
                  // minHeight: 90.0,
                  fontSize: 12.0,
                  initialLabelIndex: 1,
                  activeBgColor: [Color(0xffff6265)],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey[350],
                  inactiveFgColor: Colors.grey[900],
                  totalSwitches: 2,
                  labels: ['الموثق', 'الكل'],
                  onToggle: (index) {

                    if (index==1)
                    {
                      certified="";
                    }
                    else if (index==0)
                    {
                      certified="1";
                    }

                  },
                ),


                // TextButton(
                //   style: TextButton.styleFrom(
                //    padding: EdgeInsets.all(16.0),
                //     primary: certifiedColor,
                //     textStyle: TextStyle(fontSize: 17),
                //   ),
                //   onPressed: () {
                //
                //     if (certifiedColor == Colors.black) {
                //
                //       certified="1";
                //
                //       certifiedColor = Color(0xffff6265);
                //
                //     } else {
                //       certified="";
                //       certifiedColor = Colors.black;
                //     }
                //   },
                //   child: const Text('Certified'),
                // ),
              ),


              PopupMenuItem<String>(
                child: TextFormField(
              decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'ادخل العمر',
              ),
                  onFieldSubmitted: (String? value) {
                     age=value!;
                  },
              ),
              ),
              PopupMenuItem<String>(
                  child: TextFormField(
                  decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'ban count',

                  ),
                    onFieldSubmitted: (String? value) {
                      banCount=value!;
                    },
                  ),

              ),


            ],
          ),
        );
      }
    else {
      return Container();
    }
  }



  @override
  String get searchFieldLabel => "Search..";

  @override
  TextStyle get searchFieldStyle => TextStyle(
        color: Colors.black,
        fontSize: 18.0,
      );

  @override
  List<Widget> buildActions(BuildContext context) {

    final user = Provider.of<MyModel>(context, listen: false);
    user.getPerson();
    // TODO: implement buildActions
    return [
      VipOrFreeUserWidget(user),
      IconButton(
          color: Color(0xffff6265),
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear)),
    ];
    throw UnimplementedError();
  }

  // @override
  // List<Widget> buildActions(BuildContext context) {
  //
  //   return [
  //     VipOrFreeUserWidget(),
  //     IconButton(
  //         color: Color(0xffff6265),
  //         onPressed: () {
  //           query = "";
  //         },
  //         icon: Icon(Icons.clear)),
  //   ];
  //   throw UnimplementedError();
  // }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, "");
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
          color: Color(0xffff6265),
        ));
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    users = searchFreeUser(query,vip,age,banCount,certified);
    age="";
    banCount="";
    return Container(
      child: FutureBuilder(
          future: users,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xffff6265)),
              ));
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return snapshot.data[index];
                  });
            }
          }),
    );
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // users = searchFreeUser("");
    users = searchFreeUser("",vip,age,banCount,certified);
    age="";
    banCount="";

    // TODO: implement buildSuggestions
    return Container(
      child: FutureBuilder(
          future: users,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xffff6265)),
              ));
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return snapshot.data[index];
                  });
            }
          }),
    );
    throw UnimplementedError();
  }
}

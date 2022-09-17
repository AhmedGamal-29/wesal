import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marry_me/components/default_useritem.dart';
import 'package:marry_me/constants/const.dart';
import 'package:marry_me/screens/users_screen.dart';
import 'package:searchfield/searchfield.dart';

import '../models/user.dart';

class SearchScreen extends StatefulWidget {
  static const id = 'search_screen';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: k5Color,
        title: const Center(child: Text('Welcome, Ali')),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Find Your \nBest Match!',
                  style: TextStyle(
                      fontFamily: "DM Sans",
                      fontSize: 40.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
                CircleAvatar(
                  radius: 25.0,
                  child: Image(
                    image: AssetImage('assets/images/per.jpg'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            SearchField(
              suggestions: users
                  .map(
                    (e) => SearchFieldListItem<User>(
                      e.name,
                      item: e,
                    ),
                  )
                  .toList(),
              hint: ' search',
              hasOverlay: false,
              searchStyle: TextStyle(
                fontSize: 18,
                color: Colors.black.withOpacity(0.8),
              ),
              suggestionState: Suggestion.expand,
              searchInputDecoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: k5Color,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    ' ${users.length} users found    ',
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
                itemBuilder: (context, index) => defaultUserItem(users[index]),
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 20.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                ),
                itemCount: users.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:friends/drawer_class.dart';
import 'package:friends/home.dart';
import 'package:friends/list_of_friends.dart';
import 'package:friends/new_page.dart';

class FriendApp extends StatefulWidget {
  const FriendApp({super.key});
  @override
  State<FriendApp> createState() {
    return _FriendApp();
  }
}

class _FriendApp extends State<FriendApp> {
  bool isNewFriendAdded = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff0F0E47),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xFFBABAE0),
          ),
          title: Text(
            'Friends',
            style: TextStyle(
              color: Color(0xFFBABAE0),
            ),
          ),
          backgroundColor: Color(0xff272757),
        ),
        drawer: DrawerClass(),
        body: Home(
          isNewFriendAdded: isNewFriendAdded,
        ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () async {
              final newFriend = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return NewPage();
                  },
                ),
              );
              setState(() {
                // listOfFriends.add(newFriend);
                isNewFriendAdded = true;
                addFriend(newFriend);
              });
            },
            backgroundColor: Color(0xFFBABAE0),
            child: Icon(
              Icons.add,
              size: 30,
            ),
          );
        }),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:friends/detailed_page.dart';
import 'package:friends/friend.dart';
import 'package:friends/list_of_friends.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.isNewFriendAdded});
  final isNewFriendAdded;
  @override
  State<Home> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  List<Friend> friendsList = [];
  @override
  void initState() {
    super.initState();
    friendsList = getAllFriends();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isNewFriendAdded) {
      setState(() {
        friendsList = getAllFriends();
      });
    }
    if (friendsList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.person_add_alt_1_rounded,
              color: Color(0x9BBABAE0),
              size: 80,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Your friends list is empty',
              style: TextStyle(
                color: Color(0x9BBABAE0),
                fontSize: 18,
              ),
            ),
            Text(
              'Try adding new friends to your list',
              style: TextStyle(
                color: Color(0x9BBABAE0),
                fontSize: 16,
              ),
            )
          ],
        )),
      );
    }

    return ListView.builder(
      itemCount: friendsList.length,
      itemBuilder: (context, index) {
        final friend = friendsList[index];
        return Dismissible(
          background: Container(
            color: Color(0xFF505081),
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Icon(
                Icons.delete_forever_rounded,
                color: Color(0xFF0F0E47),
              ),
            ),
          ),
          secondaryBackground: Container(
            color: Color(0xFF505081),
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                Icons.delete_forever_rounded,
                color: Color(0xFF0F0E47),
              ),
            ),
          ),
          key: ValueKey(friend),
          onDismissed: (direction) {
            final removedFriend = friend;
            final snackBar = SnackBar(
              content: Text('You removed ${friend.name}'),
              duration: Duration(seconds: 3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.symmetric(horizontal: 20),
              backgroundColor: Color(0xFF272757),
              action: SnackBarAction(
                label: 'UNDO',
                onPressed: () async {
                  await insertFriend(index, removedFriend);
                  setState(() {
                    friendsList = getAllFriends();
                  });
                },
              ),
            );

            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            setState(() {
              // listOfFriends.removeAt(index);
              deleteFriend(index);
              friendsList = getAllFriends();
            });
          },
          child: Column(
            children: [
              ListTile(
                leading: ClipOval(
                  child: friend.profile.startsWith('assets/')
                      ? Image.asset(
                          friend.profile,
                          width: 50,
                          height: 50,
                          fit: BoxFit.fill,
                        )
                      : Image.file(
                          File(friend.profile),
                          width: 50,
                          height: 50,
                          fit: BoxFit.fill,
                        ),
                ),
                title: Text(
                  friend.name,
                  style: TextStyle(
                    color: Color(0xFFffffff),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  friend.dream,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xff8686AC),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () async {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  final editedFriend = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailedPage(friend: friend),
                    ),
                  );
                  setState(() {
                    // listOfFriends[index] = editedFriend;
                    updatedFriend(index, editedFriend);
                    friendsList = getAllFriends();
                  });
                },
              ),
              if (index < friendsList.length - 1)
                Divider(
                  color: Color(0xFF07061F),
                  thickness: 1,
                  height: 1,
                  indent: 85,
                ),
            ],
          ),
        );
      },
    );
  }
}

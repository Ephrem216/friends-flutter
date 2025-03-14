import 'dart:io';

import 'package:flutter/material.dart';
import 'package:friends/friend.dart';
import 'package:friends/new_page.dart';

class DetailedPage extends StatefulWidget {
  const DetailedPage({super.key, required this.friend});

  final Friend friend;

  @override
  State<DetailedPage> createState() {
    return _DetailedPageState();
  }
}

class _DetailedPageState extends State<DetailedPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, widget.friend);
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xff0F0E47),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xFFBABAE0),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                final Friend editedFriend = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => NewPage(
                      friend: widget.friend,
                    ),
                  ),
                );
                setState(() {
                  widget.friend.name = editedFriend.name;
                  widget.friend.dream = editedFriend.dream;
                  widget.friend.profile = editedFriend.profile;
                });
              },
              icon: Icon(Icons.edit),
            )
          ],
          title: Text(
            'Profile',
            style: TextStyle(
              color: Color(0xFFBABAE0),
            ),
          ),
          backgroundColor: Color(0xff272757),
        ),
        body: Container(
          color: Color(0xff0F0E47),
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Container(
                width: 250,
                height: 250,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  // color: Color(0xff505081),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xff505081),
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: widget.friend.profile.startsWith('assets/')
                      ? Image.asset(
                          widget.friend.profile,
                          fit: BoxFit.fill,
                        )
                      : Image.file(
                          File(widget.friend.profile),
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.friend.name,
                      // textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Divider(
                      color: Color(0xFF07061F),
                      thickness: 1,
                      height: 20,
                      // indent: 5,
                    ),
                    Text(
                      widget.friend.dream,
                      style: TextStyle(
                        color: Color(0xff8686AC),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

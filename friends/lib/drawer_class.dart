import 'package:flutter/material.dart';
import 'package:friends/detailed_page.dart';
import 'package:friends/friend.dart';
import 'package:friends/list_of_friends.dart';
import 'package:hive/hive.dart';

class DrawerClass extends StatefulWidget {
  const DrawerClass({super.key});

  @override
  State<DrawerClass> createState() {
    return _DrawerClass();
  }
}

class _DrawerClass extends State<DrawerClass> {
  final myBox = Hive.box('me');
  @override
  Widget build(BuildContext context) {
    Friend ephrem = myBox.getAt(0);
    return Drawer(
      // backgroundColor: Colors.red,
      child: Container(
        color: Color(0xff272757),
        child: ListView(
          children: [
            Container(
              color: Color.fromARGB(255, 49, 49, 110),
              padding:
                  EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      // color: Color(0xff505081),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xff505081),
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        ephrem.profile,
                        width: 85,
                        // height: 75,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    ephrem.name,
                    style: TextStyle(
                      color: Color(0xFFBABAE0),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Software Engineering Student | Aspiring Full-Stack Developer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF8C8CCD),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: TextButton(
                onPressed: () async {
                  final updatedMe = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailedPage(
                        friend: ephrem,
                      ),
                    ),
                  );

                  setState(() {
                    updateMe(updatedMe);
                    ephrem = myBox.getAt(0);
                  });
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.account_circle_sharp,
                      color: Color(0xFFBABAE0),
                      size: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'About',
                      style: TextStyle(
                        color: Color(0xFFBABAE0),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:friends/friend.dart';
import 'package:friends/friend_app.dart';
import 'package:friends/list_of_friends.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(FriendAdapter());
  await Hive.openBox<Friend>('friendBox');
  await Hive.openBox('config');
  await Hive.openBox('me');
  // final a = Hive.box('friendBox');
  // final b = Hive.box('config');
  // await a.clear();
  // await b.clear();
  // deleteAllFriends();
  await initializeApp();

  runApp(FriendApp());
}

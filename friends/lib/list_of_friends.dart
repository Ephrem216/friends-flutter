import 'package:friends/friend.dart';
import 'package:hive_flutter/hive_flutter.dart';

List<Friend> listOfFriends = [
  Friend(
      name: 'Henok Enyew',
      dream:
          'To become a top software engineer, leading innovative projects that leverage cutting-edge technologies such as machine learning and cloud computing, ultimately aiming to revolutionize the tech industry and inspire the next generation of developers.',
      profile: 'assets/henoke.png'),
  Friend(
      name: 'Ermias Desalegn',
      dream:
          'To develop AI-driven applications that not only solve real-world problems but also enhance user experience through intuitive design, focusing on areas like healthcare and education to create meaningful change in people’s lives.',
      profile: 'assets/ermias.jpg'),
  Friend(
      name: 'Ehenew Amogne',
      dream:
          'To create a startup focused on financial technology, aiming to democratize access to financial services through innovative solutions that empower individuals and small businesses, fostering economic growth in underserved communities.',
      profile: 'assets/ehenew.jpg'),
  Friend(
      name: 'Henok Mulat',
      dream:
          'To work with leading tech companies on secure software solutions, ensuring data integrity and privacy while developing applications that meet the highest standards of cybersecurity, thus contributing to a safer digital world.',
      profile: 'assets/henok.jpg'),
  Friend(
      name: 'Bereket Alemayewhu',
      dream:
          'To contribute to open-source projects in software development, collaborating with global developers to create robust tools and frameworks that enhance productivity and accessibility in software engineering, while fostering a spirit of community and knowledge sharing.',
      profile: 'assets/bereket.jpg'),
  Friend(
      name: 'Eyob Yihalem',
      dream:
          'To build user-friendly software tools for various industries, focusing on usability and functionality to streamline processes and improve efficiency, ultimately aiming to bridge the gap between technology and everyday users.',
      profile: 'assets/eyob.jpg'),
  Friend(
      name: 'Estifanos Kelemu',
      dream:
          'To design scalable systems for growing tech needs, leveraging modern architectures and best practices to ensure that applications can handle increasing loads while maintaining performance and reliability, thus supporting businesses as they evolve.',
      profile: 'assets/estif.jpg'),
];

Friend me = Friend(
    name: 'Ephrem Ketachew',
    dream:
        'To revolutionize the way businesses interact with their customers through dynamic web and mobile applications built on the MERN stack; to create intuitive, high-performance solutions that not only meet the needs of today\'s users but also anticipate the demands of tomorrow\'s digital landscape.',
    profile: 'assets/e02.jpg');

void replace(Friend originalFriend, Friend updatedFriend) {
  int index = listOfFriends.indexOf(originalFriend);
  listOfFriends[index] = updatedFriend;
}

void addFriend(Friend friend) async {
  final boxFriends = Hive.box<Friend>('friendBox');
  await boxFriends.add(friend);
}

Friend? getFriend(int index) {
  final boxFriends = Hive.box<Friend>('friendBox');
  return boxFriends.getAt(index);
}

List<Friend> getAllFriends() {
  final boxFriends = Hive.box<Friend>('friendBox');
  return boxFriends.values.toList();
}

void updatedFriend(int index, Friend updatedFriend) async {
  final boxFriends = Hive.box<Friend>('friendBox');
  final key = boxFriends.keyAt(index);
  if (key != null) {
    await boxFriends.put(key, updatedFriend);
  }
}

void updateMe(Friend updatedMe) async {
  final myBox = Hive.box('me');
  await myBox.put(0, updatedMe);
}

void deleteFriend(int index) async {
  final boxFriends = Hive.box<Friend>('friendBox');
  await boxFriends.deleteAt(index);
}

void deleteAllFriends() async {
  final boxFriends = Hive.box<Friend>('friendBox');
  await boxFriends.clear();
}

Future<void> insertFriend(int index, Friend insertedFriend) async {
  final boxFriends = Hive.box<Friend>('friendBox');
  final List<Friend> friendsList = boxFriends.values.toList();

  friendsList.insert(index, insertedFriend);

  await boxFriends.clear();
  for (var updatedFriend in friendsList) {
    await boxFriends.add(updatedFriend);
  }
}

Future<void> registerFriendsFromAFile() async {
  final boxFriends = Hive.box<Friend>('friendBox');
  for (Friend friend in listOfFriends) {
    if (!boxFriends.values.contains(friend)) {
      await boxFriends.add(friend);
    }
  }
}

Future<void> initializeApp() async {
  final appConfig = Hive.box('config');
  final epha = Hive.box('me');
  final boxFriends = Hive.box<Friend>('friendBox');
  if (appConfig.get('isInitialized') != true) {
    await epha.add(me);
    for (Friend friend in listOfFriends) {
      if (!boxFriends.values.contains(friend)) {
        await boxFriends.add(friend);
      }
    }
  }

  await appConfig.put('isInitialized', true);
}

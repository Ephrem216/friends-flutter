import 'package:hive/hive.dart';

part 'friend.g.dart';

@HiveType(typeId: 0)
class Friend {
  @HiveField(0)
  String name;

  @HiveField(1)
  String dream;

  @HiveField(2)
  String profile;

  Friend({
    required this.name,
    required this.dream,
    required this.profile,
  });
  // @override
  // bool operator ==(Object other) {
  //   if (identical(other, this)) return true;
  //   if (other is! Friend) return false;

  //   return name.toLowerCase() == other.name.toLowerCase() &&
  //       dream.toLowerCase() == other.dream.toLowerCase() &&
  //       profile.toLowerCase() == other.profile.toLowerCase();
  // }

  // @override
  // int get hashCode => name.hashCode ^ dream.hashCode ^ profile.hashCode;
}

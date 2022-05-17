import 'package:hive/hive.dart';

import '../../../model/user.dart';

abstract class HiveUserAbstract {
  Future<User?> getUser();
  Future<void> cacheUser({User user});
}

class UserHive implements HiveUserAbstract {
  final HiveInterface hive;

  UserHive({required this.hive});

  Future<Box> _openBox(String type) async {
    try {
      final box = await hive.openBox(type);
      return box;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> cacheUser({User? user}) async {
    try {
      final userbox = await _openBox("user");
      userbox.put("user", user);
      print("added");
    } catch (e) {
      print("eeeeeee112${e.toString()}");
      throw e;
    }
  }

  @override
  Future<User?> getUser() async {
    try {
      final userbox = await _openBox("user");
      // if (newsBox.containsKey("news")) {
      print("got here");
      print("iiiiio${await userbox.get("user")}");
      return await userbox.get("user");
    } catch (e) {
      return null;
    }
  }
}

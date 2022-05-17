import 'package:hive/hive.dart';

import '../model/walletbalance.dart';

abstract class HiveWalletAbstract {
  Future<WalletBalance?>? getWalletBalance();
  Future<void> cacheWalletBalance({WalletBalance walletBalance});
}

class WalletHive implements HiveWalletAbstract {
  final HiveInterface? hive;

  WalletHive({required this.hive});

  Future<Box> _openBox(String type) async {
    try {
      final box = await hive!.openBox(type);
      return box;
    } catch (e) {
      throw e;
    }
  }

  // @override
  // Future<void> cacheWalletBalance({WalletBalance balance})async {
  //   try {
  //     final balancebox = await _openBox("balance");
  //     balancebox.put("balance", balance);
  //     print("added");
  //   } catch (e) {
  //     // print("eeeeeee112${e.toString()}");
  //     throw e;
  //   }
  //
  // }

  @override
  Future<WalletBalance?>? getWalletBalance() async {
    try {
      final balancebox = await _openBox("balance");
      // if (newsBox.containsKey("news")) {
      // print("got here");
      // print("iiiiio${await balancebox.get("balance")}");
      return await balancebox.get("balance");
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheWalletBalance({WalletBalance? walletBalance}) async {
    try {
      final balancebox = await _openBox("balance");
      balancebox.put("balance", walletBalance);
      // print("added");
    } catch (e) {
      // print("eeeeeee112${e.toString()}");
      throw e;
    }
  }
}

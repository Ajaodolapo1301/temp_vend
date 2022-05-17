import 'package:hive/hive.dart';

part 'walletbalance.g.dart';

@HiveType(typeId: 5, adapterName: "Wallet")
class WalletBalance {
  @HiveField(0)
  String? balance;

  WalletBalance({this.balance});

  WalletBalance.fromJson(Map<String, dynamic> json) {
    balance = json["data"];
  }
}

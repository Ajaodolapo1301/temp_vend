import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../../core/GlobalState/baseState.dart';
import '../../../core/error/failures.dart';
import '../api/local_datasource.dart';
import '../api/repos.dart';
import '../model/initateModel.dart';
import '../model/walletHistoryModel.dart';
import '../model/walletbalance.dart';

abstract class AbstractWalletViewModel extends BaseViewModel {
  Future<Either<Failure, WalletBalance>> fetchWalletBalance({token});
  Future<Either<Failure, String>> confirmPayment(
      {transaction_id, gateway, token});
  Future<Either<Failure, List<WalletHistoryModel>>> getTransaction({token});
  Future<Either<Failure, InitiateModel>> initiatePayment(
      {token, transaction_id, amount, type, previous_balance});
  Future<Either<Failure, String>> paymentWithWallet({
    token,
    transaction_id,
    amount,
    title,
    user_id,
  });
}

class WalletState extends AbstractWalletViewModel {
  WalletHive hive = WalletHive(hive: Hive);
  WalletBalance? _walletBalance;

  WalletBalance get walletBalance => _walletBalance!;
  set walletBalance(WalletBalance value) {
    _walletBalance = value;
    notifyListeners();
  }

  List<WalletHistoryModel> _walletHistory = [];
  List<WalletHistoryModel> get walletHistory => _walletHistory;
  set walletHistory(List<WalletHistoryModel> walletHistory1) {
    _walletHistory = walletHistory1;
    notifyListeners();
  }

  @override
  Future<Either<Failure, String>> confirmPayment(
      {transaction_id, gateway, token}) async {
    setBusy(true);
    var res = await WalletRepoImpl().confirmPayment(
        token: token, transaction_id: transaction_id, gateway: gateway);
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {});

    return res;
  }

  @override
  Future<Either<Failure, WalletBalance>> fetchWalletBalance({token}) async {
    setBusy(true);
    var res = await WalletRepoImpl().fetchWalletBalance(
      token: token,
    );
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {
      walletBalance = r;
    });
    await hive.cacheWalletBalance(walletBalance: walletBalance);
    var wallet = await hive.getWalletBalance();
    // print(wallet.balance);
    walletBalance = wallet!;
    return res;
  }

  @override
  Future<Either<Failure, List<WalletHistoryModel>>> getTransaction(
      {token}) async {
    setBusy(true);
    var res = await WalletRepoImpl().getTransaction(
      token: token,
    );
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {
      walletHistory = r;
    });

    return res;
  }

  @override
  Future<Either<Failure, InitiateModel>> initiatePayment(
      {token, transaction_id, amount, type, previous_balance}) async {
    setBusy(true);
    var res = await WalletRepoImpl().initiatePayment(
        token: token,
        transaction_id: transaction_id,
        type: type,
        amount: amount,
        previous_balance: previous_balance);
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {});

    return res;
  }

  @override
  Future<Either<Failure, String>> paymentWithWallet(
      {token, transaction_id, amount, title, user_id}) async {
    setBusy(true);
    var res = await WalletRepoImpl().paymentWithWallet(
        token: token,
        transaction_id: transaction_id,
        title: title,
        amount: amount,
        user_id: user_id);
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {});

    return res;
  }
}

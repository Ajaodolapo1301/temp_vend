import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:vend_express/features/wallet/api/remote_datasource.dart';

import '../../../core/error/failures.dart';
import '../model/initateModel.dart';
import '../model/walletHistoryModel.dart';
import '../model/walletbalance.dart';

abstract class AbstractWalletRepo {
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

class WalletRepoImpl implements AbstractWalletRepo {
  @override
  Future<Either<Failure, String>> confirmPayment(
      {transaction_id, gateway, token}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await WalletApi().confirmPayment(
            token: token, transaction_id: transaction_id, gateway: gateway);

        if (res["error"] == false) {
          return Right(res["message"]);
        } else {
          return Left(ServerFailure(res["message"]));
        }
      } catch (e) {
        return Left(ServerFailure(e));
      }
    } else {
      return Left(ServerFailure("No internet acesss"));
    }
  }

  @override
  Future<Either<Failure, WalletBalance>> fetchWalletBalance({token}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await WalletApi().fetchWalletBalance(
          token: token,
        );

        if (res["error"] == false) {
          return Right(res["balance"]);
        } else {
          return Left(ServerFailure(res["message"]));
        }
      } catch (e) {
        return Left(ServerFailure(e));
      }
    } else {
      return Left(ServerFailure("No internet acesss"));
    }
  }

  @override
  Future<Either<Failure, List<WalletHistoryModel>>> getTransaction(
      {token}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await WalletApi().getTransaction(
          token: token,
        );

        if (res["error"] == false) {
          return Right(res["walletHistoryModel"]);
        } else {
          return Left(ServerFailure(res["message"]));
        }
      } catch (e) {
        return Left(ServerFailure(e));
      }
    } else {
      return Left(ServerFailure("No internet acesss"));
    }
  }

  @override
  Future<Either<Failure, InitiateModel>> initiatePayment(
      {token, transaction_id, amount, type, previous_balance}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await WalletApi().initiatePayment(
            token: token,
            transaction_id: transaction_id,
            amount: amount,
            type: type,
            previous_balance: previous_balance);

        if (res["error"] == false) {
          return Right(res["message"]);
        } else {
          return Left(ServerFailure(res["message"]));
        }
      } catch (e) {
        return Left(ServerFailure(e));
      }
    } else {
      return Left(ServerFailure("No internet acesss"));
    }
  }

  @override
  Future<Either<Failure, String>> paymentWithWallet(
      {token, transaction_id, amount, title, user_id}) async {
    // bool result = await DataConnectionChecker().hasConnection;

    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await WalletApi().paymentWithWallet(
            token: token,
            transaction_id: transaction_id,
            amount: amount,
            title: title,
            user_id: user_id);

        if (res["error"] == false) {
          return Right(res["message"]);
        } else {
          return Left(ServerFailure(res["message"]));
        }
      } catch (e) {
        return Left(ServerFailure(e));
      }
    } else {
      return Left(ServerFailure("No internet acesss"));
    }
  }
}

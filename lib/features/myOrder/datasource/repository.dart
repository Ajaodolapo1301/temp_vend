import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../core/error/failures.dart';
import '../model/myOrderModel.dart';
import 'myOrderApi.dart';

abstract class AbstractMyOrderRepository {
  Future<Either<Failure, List<MyOrderModel>>> getMyOrders({filtered_by});
  Future<Either<Failure, String>> rateOrder({token, order_id, score});
}

class MyOrderRepoImpl implements AbstractMyOrderRepository {
  @override
  Future<Either<Failure, List<MyOrderModel>>> getMyOrders(
      {filtered_by, token}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await MyOrderApi()
            .getMyOrders(filtered_by: filtered_by, token: token);

        if (res["error"] == false) {
          return Right(res["myOrderModel"]);
        } else {
          return Left(ServerFailure(res["message"]));
        }
      } catch (e) {
        return Left(ServerFailure(e));
      }
    } else {
      return Left(ServerFailure("No internet access"));
    }
  }

  @override
  Future<Either<Failure, String>> rateOrder({token, order_id, score}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await MyOrderApi()
            .rateOrder(token: token, score: score, order_id: order_id);

        if (res["error"] == false) {
          return Right(res["message"]);
        } else {
          return Left(ServerFailure(res["message"] ?? "An Error Occurred"));
        }
      } catch (e) {
        return Left(ServerFailure(e));
      }
    } else {
      return Left(ServerFailure("No internet access"));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/error/failures.dart';
import '../makePaymentApi.dart';

abstract class AbstractMakePaymentRepository {
  Future<Either<Failure, String>> updatePaymentDetails(
      {payment_method, reference_number, price, order_id, token});
}

class MakePaymentRepoImpl implements AbstractMakePaymentRepository {
  @override
  Future<Either<Failure, String>> updatePaymentDetails(
      {payment_method, reference_number, price, order_id, token}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await MakePaymentImpl().updatePaymentDetails(
            payment_method: payment_method,
            reference_number: reference_number,
            price: price,
            order_id: order_id,
            token: token);

        if (res["error"] == false) {
          return Right(res["deliveryTime"]);
        } else {
          return Left(ServerFailure(res["message"]));
        }
      } catch (e) {
        print("eeee${e}");
        return Left(ServerFailure(e));
      }
    } else {
      return Left(ServerFailure("No internet acesss"));
    }
  }
}

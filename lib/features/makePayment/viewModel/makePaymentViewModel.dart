import 'package:dartz/dartz.dart';

import '../../../core/GlobalState/baseState.dart';
import '../../../core/error/failures.dart';
import '../api/repository/makePaymentRepo.dart';

abstract class AbstractMakePaymentViewModel extends BaseViewModel {
  Future<Either<Failure, String>> updatePaymentDetails(
      {payment_method, reference_number, price, order_id, token});
}

class MakePaymentViewModel extends AbstractMakePaymentViewModel {
  @override
  Future<Either<Failure, String>> updatePaymentDetails(
      {payment_method, reference_number, price, order_id, token}) async {
    setBusy(true);
    var res = await MakePaymentRepoImpl().updatePaymentDetails(
        price: price,
        payment_method: payment_method,
        reference_number: reference_number,
        order_id: order_id,
        token: token);
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {});

    return res;
  }
}

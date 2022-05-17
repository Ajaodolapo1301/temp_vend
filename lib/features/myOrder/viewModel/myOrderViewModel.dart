import 'package:dartz/dartz.dart';

import '../../../core/GlobalState/baseState.dart';
import '../../../core/error/failures.dart';
import '../datasource/repository.dart';
import '../model/myOrderModel.dart';

abstract class AbstractMyOrderViewModel extends BaseViewModel {
  Future<Either<Failure, List<MyOrderModel>>> getMyOrders({filtered_by});
  Future<Either<Failure, String>> rateOrder({token, order_id, score});
}

class MyOrderViewModel extends AbstractMyOrderViewModel {
  List<MyOrderModel> _myOrder = [];
  List<MyOrderModel> get myOrder => _myOrder;
  set myOrder(List<MyOrderModel> myOrder1) {
    _myOrder = myOrder1;
    notifyListeners();
  }

  @override
  Future<Either<Failure, List<MyOrderModel>>> getMyOrders(
      {filtered_by, token}) async {
    setBusy(true);
    var res = await MyOrderRepoImpl()
        .getMyOrders(filtered_by: filtered_by, token: token);
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {
      _myOrder = r;
    });

    return res;
  }

  @override
  Future<Either<Failure, String>> rateOrder({token, order_id, score}) async {
    setBusy(true);
    var res = await MyOrderRepoImpl()
        .rateOrder(token: token, score: score, order_id: order_id);
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {});

    return res;
  }
}

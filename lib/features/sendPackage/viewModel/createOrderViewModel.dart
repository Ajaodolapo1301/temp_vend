import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../../core/GlobalState/baseState.dart';
import '../../../core/error/failures.dart';
import '../../authentication/model/initialModel.dart';
import '../../checkPrice/model/checkPriceModel.dart';
import '../api/data_source/local_data_source/create_order_hive.dart';
import '../api/repository/repo.dart';
import '../model/createOrderResponse.dart';

abstract class AbstractCreateOrderViewModel extends BaseViewModel {
  Future<Either<Failure, List<PackageSize>>> getPackageSize();
  Future<Either<Failure, List<DeliveryTime>>> getDeliveryTime();
  Future<Either<Failure, List<DeliveryType>>> getDeliveryType();

  Future<Either<Failure, CreateResponse>> createOrder(
      {sender_name,
      sender_phone_number,
      receiver_name,
      receiver_phone_number,
      delivery_type_id,
      delivery_time_id,
      package_size_id,
      pickup_type,
      pickup_time,
      pickup_lat,
      pickup_long,
      item_description,
      pickup_address,
      coupon_code,
      additional_info,
      token,
      pickup_raw_response,
      destination_lat,
      destination_long,
      destination_address,
      destination_raw_response});
  Future<Either<Failure, CreateResponse>> redeemCoupon(
      {order_id, coupon, token});

  Future<Either<Failure, CheckPriceModel>> checkPrice(
      {delivery_type_id,
      delivery_time_id,
      sender_id,
      package_size_id,
      pickup_type,
      pickup_time,
      pickup_lat,
      pickup_long,
      item_description,
      pickup_address,
      token,
      pickup_raw_response,
      destination_lat,
      destination_long,
      destination_address,
      destination_raw_response});
}

class CreateOrderState extends AbstractCreateOrderViewModel {
  CreateOrderHive createOrderHive = CreateOrderHive(hive: Hive);

  List<DeliveryTime> _deliveryTime = [];
  List<DeliveryTime> get deliveryTime => _deliveryTime;
  set deliveryTime(List<DeliveryTime> deliveryTime1) {
    _deliveryTime = deliveryTime1;
    notifyListeners();
  }

  List<PackageSize> _packageSize = [];
  List<PackageSize> get packageSize => _packageSize;
  set packageSize(List<PackageSize> packageSize1) {
    _packageSize = packageSize1;
    notifyListeners();
  }

  List<DeliveryType> _deliveryType = [];
  List<DeliveryType> get deliveryType => _deliveryType;
  set deliveryType(List<DeliveryType> deliveryType1) {
    _deliveryType = deliveryType1;
    notifyListeners();
  }

  @override
  Future<Either<Failure, List<DeliveryTime>>> getDeliveryTime() async {
    setBusy(true);
    var res = await CreateOrderRepoImpl().getDeliveryTime();
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {
      _deliveryTime = r as List<DeliveryTime>;
    });

    return res;
  }

  @override
  Future<Either<Failure, List<DeliveryType>>> getDeliveryType() async {
    setBusy(true);
    var res = await CreateOrderRepoImpl().getDeliveryType();
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {
      _deliveryType = r as List<DeliveryType>;

      return r;
    });

    return res;
  }

  @override
  Future<Either<Failure, List<PackageSize>>> getPackageSize() async {
    setBusy(true);
    var res = await CreateOrderRepoImpl().getPackageSize();
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {
      _packageSize = r;

      return r;
    });

    return res;
  }

  @override
  Future<Either<Failure, CreateResponse>> createOrder(
      {sender_name,
      sender_phone_number,
      receiver_name,
      receiver_phone_number,
      delivery_type_id,
      delivery_time_id,
      package_size_id,
      pickup_type,
      pickup_time,
      pickup_lat,
      pickup_long,
      item_description,
      pickup_address,
      coupon_code,
      additional_info,
      token,
      pickup_raw_response,
      destination_lat,
      destination_long,
      destination_address,
      destination_raw_response}) async {
    setBusy(true);
    var res = await CreateOrderRepoImpl().createOrder(
      sender_name: sender_name,
      token: token,
      sender_phone_number: sender_phone_number,
      receiver_name: receiver_name,
      receiver_phone_number: receiver_phone_number,
      delivery_time_id: delivery_time_id,
      delivery_type_id: delivery_type_id,
      package_size_id: package_size_id,
      pickup_type: pickup_type,
      pickup_time: pickup_time,
      pickup_lat: pickup_lat,
      pickup_long: pickup_long,
      item_description: item_description,
      pickup_address: pickup_address,
      coupon_code: coupon_code,
      additional_info: additional_info,
      destination_address: destination_address,
      destination_long: destination_long,
      pickup_raw_response: pickup_raw_response,
      destination_raw_response: destination_raw_response,
      destination_lat: destination_lat,
    );
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {
      return r;
    });

    return res;
  }

  @override
  Future<Either<Failure, CreateResponse>> redeemCoupon(
      {order_id, coupon, token}) async {
    setBusy(true);
    var res = await CreateOrderRepoImpl()
        .redeemCoupon(order_id: order_id, token: token, coupon: coupon);
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {
      return r;
    });

    return res;
  }

  @override
  Future<Either<Failure, CheckPriceModel>> checkPrice(
      {delivery_type_id,
      delivery_time_id,
      sender_id,
      package_size_id,
      pickup_type,
      pickup_time,
      pickup_lat,
      pickup_long,
      item_description,
      pickup_address,
      token,
      pickup_raw_response,
      destination_lat,
      destination_long,
      destination_address,
      destination_raw_response}) async {
    setBusy(true);
    var res = await CreateOrderRepoImpl().checkPrice(
      sender_id: sender_id,
      token: token,
      delivery_time_id: delivery_time_id,
      delivery_type_id: delivery_type_id,
      package_size_id: package_size_id,
      pickup_type: pickup_type,
      pickup_time: pickup_time,
      pickup_lat: pickup_lat,
      pickup_long: pickup_long,
      pickup_address: pickup_address,
      destination_address: destination_address,
      destination_long: destination_long,
      pickup_raw_response: pickup_raw_response,
      destination_raw_response: destination_raw_response,
      destination_lat: destination_lat,
    );
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {
      return r;
    });

    return res;
  }
}

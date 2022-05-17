import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:vend_express/core/error/failures.dart';

import '../../../authentication/model/initialModel.dart';
import '../../../checkPrice/model/checkPriceModel.dart';
import '../../model/createOrderResponse.dart';
import '../data_source/local_data_source/create_order_hive.dart';
import '../data_source/remote_data_source/create_order_api.dart';

abstract class AbstractCreateOrderRepository {
  Future<Either<Failure, List<PackageSize>>> getPackageSize();
  Future<Either<Failure, List<DeliveryTime>>> getDeliveryTime();
  Future<Either<Failure, List<DeliveryType>>> getDeliveryType();
  Future<Either<Failure, CreateResponse>> createOrder({
    sender_name,
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
    destination_raw_response,
  });

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

class CreateOrderRepoImpl implements AbstractCreateOrderRepository {
  CreateOrderHive createOrderHive = CreateOrderHive(hive: Hive);

  @override
  Future<Either<Failure, List<DeliveryTime>>> getDeliveryTime() async {
    List<DeliveryTime>? cacheDeliveryTime =
        await createOrderHive.getCacheDeliveryTime();
    if (cacheDeliveryTime != null) {
      return Right(cacheDeliveryTime);
    } else {
      if (await InternetConnectionChecker().hasConnection) {
        try {
          final res = await CreateOrderImpl().getDeliveryTime();

          if (res["error"] == false) {
            await createOrderHive.cacheDeliveryTime(time: res["deliveryTime"]);
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

  @override
  Future<Either<Failure, List<DeliveryType>>> getDeliveryType() async {
    List<DeliveryType>? cacheDeliveryType =
        await createOrderHive.getCacheDeliveryType();
    if (cacheDeliveryType != null) {
      return Right(cacheDeliveryType);
    } else {
      if (await InternetConnectionChecker().hasConnection) {
        try {
          final res = await CreateOrderImpl().getDeliveryType();

          if (res["error"] == false) {
            await createOrderHive.cacheDeliveryType(type: res["deliveryType"]);
            return Right(res["deliveryType"]);
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

  @override
  Future<Either<Failure, List<PackageSize>>> getPackageSize() async {
    var cachePackageSize = await createOrderHive.getCachePackgeSie();
    if (cachePackageSize != null && cachePackageSize.isNotEmpty) {
      return Right(cachePackageSize);
    } else {
      if (await InternetConnectionChecker().hasConnection) {
        try {
          final res = await CreateOrderImpl().getPackageSize();

          if (res["error"] == false) {
            await createOrderHive.cachePackgeSie(size: res["packageSizes"]);
            return Right(res["packageSizes"]);
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

  @override
  Future<Either<Failure, CreateResponse>> createOrder(
      {sender_name,
      sender_phone_number,
      receiver_name,
      receiver_phone_number,
      delivery_type_id,
      delivery_time_id,
      package_size_id,
      token,
      pickup_raw_response,
      destination_lat,
      destination_long,
      destination_address,
      destination_raw_response,
      pickup_type,
      pickup_time,
      pickup_lat,
      pickup_long,
      item_description,
      pickup_address,
      coupon_code,
      additional_info}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await CreateOrderImpl().createOrder(
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

        if (res["error"] == false) {
          return Right(res["createOrder"]);
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
  Future<Either<Failure, CreateResponse>> redeemCoupon(
      {order_id, coupon, token}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await CreateOrderImpl()
            .redeemCoupon(order_id: order_id, token: token, coupon: coupon);

        if (res["error"] == false) {
          return Right(res["createOrder"]);
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
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await CreateOrderImpl().checkPrice(
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

        if (res["error"] == false) {
          return Right(res["checkPrice"]);
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
}

import 'package:hive/hive.dart';

import '../../../../authentication/model/initialModel.dart';

abstract class HiveCreatOrderAbstract {
  Future<List<PackageSize?>?> getCachePackgeSie();
  Future<List<DeliveryTime?>?> getCacheDeliveryTime();
  Future<List<DeliveryType?>?> getCacheDeliveryType();

  Future<void> cachePackgeSie({List<PackageSize>? size});

  Future<void> cacheDeliveryTime({List<DeliveryTime>? time});
  Future<void> cacheDeliveryType({List<DeliveryType>? type});
}

class CreateOrderHive implements HiveCreatOrderAbstract {
  final HiveInterface hive;

  CreateOrderHive({required this.hive});

  Future<Box> _openBox(String type) async {
    try {
      final box = await hive.openBox(type);
      return box;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> cacheDeliveryTime({List<DeliveryTime>? time}) async {
    try {
      final deliveryTime = await _openBox("delivery_time");
      deliveryTime.put("delivery_time", time);
      // print("added");
    } catch (e) {
      // throw e;
    }
  }

  @override
  Future<void> cacheDeliveryType({List<DeliveryType>? type}) async {
    try {
      final deliveryType = await _openBox("delivery_type");
      deliveryType.put("delivery_type", type);
      // print("added");
    } catch (e) {
      // throw e;
    }
  }

  @override
  Future<void> cachePackgeSie({List<PackageSize>? size}) async {
    try {
      final packageSize = await _openBox("packageSize");
      packageSize.put("packageSize", size);
      // print("added");
    } catch (e) {
      // throw e;
    }
  }

  @override
  Future<List<DeliveryTime>?> getCacheDeliveryTime() async {
    try {
      final deliveryTime = await _openBox("delivery_time");

      List<DeliveryTime>? list = await deliveryTime.get("delivery_time");
      if (list != null) {
        return list;
      }

      // }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<DeliveryType>?> getCacheDeliveryType() async {
    try {
      final deliveryType = await _openBox("delivery_type");

      List<DeliveryType>? list = await deliveryType.get("delivery_type");
      if (list != null) {
        return list;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<PackageSize>?> getCachePackgeSie() async {
    try {
      final packageSize = await _openBox("packageSize");
      // if (newsBox.containsKey("news")) {
      // print("got here");
      print(await packageSize.get("packageSize"));
      List<PackageSize>? list = await packageSize.get("packageSize");
      if (list != null || list!.isNotEmpty) {
        return list;
      }

      // }
      return null;
    } catch (e) {
      return null;
    }
  }
}

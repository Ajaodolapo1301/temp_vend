import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../../core/utils/apiUrls/env.dart';
import '../../../../authentication/model/initialModel.dart';
import '../../../../checkPrice/model/checkPriceModel.dart';
import '../../../model/createOrderResponse.dart';

abstract class AbstractCreateOrder {
  Future<Map<String, dynamic>> getPackageSize();
  Future<Map<String, dynamic>> getDeliveryTime();
  Future<Map<String, dynamic>> getDeliveryType();

  Future<Map<String, dynamic>> redeemCoupon({order_id, coupon, token});
  Future<Map<String, dynamic>> createOrder(
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
  Future<Map<String, dynamic>> getRawResponse({apiKey, lat, lon});

  Future<Map<String, dynamic>> checkPrice(
      {delivery_type_id,
      delivery_time_id,
      sender_id,
      package_size_id,
      pickup_type,
      pickup_time,
      pickup_lat,
      pickup_long,
      pickup_address,
      token,
      pickup_raw_response,
      destination_lat,
      destination_long,
      destination_address,
      destination_raw_response});
}

class CreateOrderImpl implements AbstractCreateOrder {
  @override
  Future<Map<String, dynamic>> getDeliveryTime() async {
    Map<String, dynamic> result = {};
    const String uri = "$orderApi/delivery-times";

    final url = Uri.parse(uri);
    var headers = {"Content-type": "application/json"};

// print(url);
    try {
      var response =
          await http.get(url, headers: headers).timeout(Duration(seconds: 30));
      int statusCode = response.statusCode;

      // print(jsonDecode(response.body));

      if (statusCode == 200) {
        result["error"] = false;

        List<DeliveryTime> deliveryTime = [];
        (jsonDecode(response.body) as List).forEach((dat) {
          // print(dat);
          deliveryTime.add(DeliveryTime.fromJson(dat));
        });

        result['deliveryTime'] = deliveryTime;
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result["message"] = "An error occurred";
        result["statusCode"] = statusCode;
        result['error'] = true;
      }
    } catch (error) {}

    // print(result);
    return result;
  }

  @override
  Future<Map<String, dynamic>> getDeliveryType() async {
    Map<String, dynamic> result = {};
    const String uri = "$orderApi/delivery-types";

    final url = Uri.parse(uri);
    var headers = {"content-type": "application/json"};

    try {
      var response =
          await http.get(url, headers: headers).timeout(Duration(seconds: 30));
      int statusCode = response.statusCode;

      // print(response.body);

      if (statusCode == 200) {
        result["error"] = false;

        List<DeliveryType> deliveryType = [];
        (jsonDecode(response.body) as List).forEach((dat) {
          deliveryType.add(DeliveryType.fromJson(dat));
        });

        result['deliveryType'] = deliveryType;
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result["message"] = "An error occurred";
        result["statusCode"] = statusCode;
        result['error'] = true;
      }
    } catch (error) {
      // print(error.toString());

    }
    return result;
  }

  @override
  Future<Map<String, dynamic>> getPackageSize() async {
    // print("called");
    Map<String, dynamic> result = {};
    const String uri = "$orderApi/package-sizes";

    final url = Uri.parse(uri);
    var headers = {"content-type": "application/json"};

    try {
      var response =
          await http.get(url, headers: headers).timeout(Duration(seconds: 30));
      int statusCode = response.statusCode;

      // print("gsgsgs ${response.body}");

      if (statusCode == 200) {
        result["error"] = false;

        List<PackageSize> packageSizes = [];
        (jsonDecode(response.body) as List).forEach((dat) {
          packageSizes.add(PackageSize.fromJson(dat));
        });

        result['packageSizes'] = packageSizes;
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result["message"] = "An error occurred";
        result["statusCode"] = statusCode;
        result['error'] = true;
      }
    } catch (error) {}
    // print(result);
    return result;
  }

  @override
  Future<Map<String, dynamic>> createOrder(
      {token,
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
      pickup_raw_response,
      destination_lat,
      destination_long,
      destination_address,
      destination_raw_response}) async {
    Map<String, dynamic> result = {};
    const String uri = "$orderApi/orders";

    final url = Uri.parse(uri);
    var headers = {
      "content-type": "application/json",
      "Authorization": "Bearer $token"
    };

    var body = jsonEncode({
      "delivery_type_id": delivery_type_id,
      "delivery_time_id": delivery_time_id,
      "package_size_id": package_size_id,
      "pickup_type": pickup_type,
      "pickup_lat": pickup_lat,
      "pickup_long": pickup_long,
      "pickup_address": pickup_address,
      "coupon_code": coupon_code,
      "sender_name": sender_name,
      "sender_phone_number": sender_phone_number,
      "receiver_name": receiver_name,
      "receiver_phone_number": receiver_phone_number,
      "pickup_time": pickup_time,
      "item_description": item_description,
      "additional_info": additional_info,
      "pickup_raw_response": pickup_raw_response,
      "destination_lat": destination_lat,
      "destination_long": destination_long,
      "destination_address": destination_address,
      "destination_raw_response": destination_raw_response
    });
    // print(url);
// print(headers);
//     log(body);
    try {
      var response = await http
          .post(url, body: body, headers: headers)
          .timeout(Duration(seconds: 30));
      int statusCode = response.statusCode;
// print(statusCode);
//       print((response.body));

      if (statusCode == 200) {
        result["error"] = false;
        var res = CreateResponse.fromJson(jsonDecode(response.body));
        // print("res$res");
        result["createOrder"] = res;
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result["message"] = jsonDecode(response.body)["message"];
        result["statusCode"] = statusCode;
        result['error'] = true;
      }
    } catch (error) {
      // print(error.toString());

    }

    // print("yyaya $result");
    return result;
  }

  @override
  Future<Map<String, dynamic>> getRawResponse({apiKey, lat, lon}) async {
    Map<String, dynamic> result = {};
    final String uri =
        "https://maps.googleapis.com/maps/api/geocode/json?address=$lat, $lon&key=$apiKey";

    // 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$place_id&key=$apiKey';

    final url = Uri.parse(uri);
    var headers = {"content-type": "application/json"};

    try {
      var response =
          await http.get(url, headers: headers).timeout(Duration(seconds: 30));
      int statusCode = response.statusCode;

      // log(response.body);

      if (statusCode == 200) {
        result["error"] = false;
        result['rawResponse'] = jsonDecode(response.body);
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result["message"] = "An error occurred";
        result["statusCode"] = statusCode;
        result['error'] = true;
      }
    } catch (error) {
      // print(error.toString());

    }
    return result;
  }

  @override
  Future<Map<String, dynamic>> redeemCoupon({order_id, coupon, token}) async {
    Map<String, dynamic> result = {};
    const String uri = "$orderApi/coupons/redeem";

    final url = Uri.parse(uri);
    var headers = {
      "content-type": "application/json",
      "Authorization": "Bearer $token"
    };

    var body = jsonEncode({"coupon": coupon, "order_id": order_id});

    try {
      var response = await http
          .post(url, body: body, headers: headers)
          .timeout(Duration(seconds: 30));
      int statusCode = response.statusCode;
      print(statusCode);
      print((response.body));
      if (statusCode == 200) {
        result["error"] = false;
        var res = CreateResponse.fromJson(jsonDecode(response.body));
        result["createOrder"] = res;
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result["message"] = jsonDecode(response.body)["message"];
        result["statusCode"] = statusCode;
        result['error'] = true;
      }
    } catch (error) {
      // print(error.toString());

    }
    return result;
  }

  @override
  Future<Map<String, dynamic>> checkPrice(
      {delivery_type_id,
      delivery_time_id,
      sender_id,
      package_size_id,
      pickup_type,
      pickup_time,
      pickup_lat,
      pickup_long,
      pickup_address,
      token,
      pickup_raw_response,
      destination_lat,
      destination_long,
      destination_address,
      destination_raw_response}) async {
    Map<String, dynamic> result = {};
    const String uri = "$orderApi/orders/calculate-price";

    final url = Uri.parse(uri);
    var headers = {
      "content-type": "application/json",
      "Authorization": "Bearer $token"
    };

    var body = jsonEncode({
      // "delivery_type_id" : delivery_type_id,
      // "delivery_time_id" :delivery_time_id,
      // "package_size_id" : package_size_id,
      // "pickup_type" : pickup_type,
      // "pickup_lat" : pickup_lat,
      // "pickup_long" : pickup_long,
      // "pickup_address" : pickup_address,
      // "coupon_code" : "",
      //
      // "pickup_time": pickup_time,
      // "item_description": item_description,
      //
      // "pickup_raw_response": pickup_raw_response,
      // "destination_lat":destination_lat,
      // "destination_long":destination_long,
      // "destination_address":destination_address,
      // "destination_raw_response":destination_raw_response

      "sender_id": sender_id,
      "delivery_type_id": delivery_type_id,
      "delivery_time_id": delivery_time_id,
      "package_size_id": package_size_id,
      "pickup_type": pickup_type,
      "pickup_lat": pickup_lat,
      "pickup_long": pickup_long,
      "pickup_address": pickup_address,
      "destination_lat": destination_lat,
      "destination_long": destination_long,
      "coupon_code": "",
      "order_id": "",
      "bonus_id": "",
      "pickup_raw_response": pickup_raw_response,
      "destination_raw_response": destination_raw_response
    });
    // print(url);
// print(headers);
//     print(delivery_time_id);
    try {
      var response = await http
          .post(url, body: body, headers: headers)
          .timeout(Duration(seconds: 30));
      int statusCode = response.statusCode;
      // print(statusCode);
      // print(jsonDecode(response.body));

      if (statusCode == 200) {
        result["error"] = false;
        var res = CheckPriceModel.fromJson(jsonDecode(response.body));
        result["checkPrice"] = res;
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result["message"] = jsonDecode(response.body)["message"];
        result["statusCode"] = statusCode;
        result['error'] = true;
      }
    } catch (error) {
      // print(error.toString());

    }

    // print("yyaya $result");
    return result;
  }
}

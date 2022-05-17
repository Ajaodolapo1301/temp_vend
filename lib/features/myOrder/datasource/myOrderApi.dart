import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/utils/apiUrls/env.dart';
import '../model/myOrderModel.dart';

abstract class AbstractMyOrder {
  Future<Map<String, dynamic>> getMyOrders({filtered_by, token});
  Future<Map<String, dynamic>> rateOrder({token, order_id, score});
}

class MyOrderApi implements AbstractMyOrder {
  @override
  Future<Map<String, dynamic>> getMyOrders({filtered_by, token}) async {
    Map<String, dynamic> result = {};
    final String uri = "$orderApi/orders/my-orders?s=$filtered_by&rows=10";

    final url = Uri.parse(uri);
    var headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    };

    // print(url);
    // print(headers);
    try {
      var response = await http
          .get(url, headers: headers)
          .timeout(const Duration(seconds: 30));
      int statusCode = response.statusCode;

      // log(response.body);
      // print(response.body);
      if (statusCode == 200) {
        result["error"] = false;
        List<MyOrderModel> myOrderModel = [];
        for (var dat in (jsonDecode(response.body)["data"] as List)) {
          // print(dat);
          myOrderModel.add(MyOrderModel.fromJson(dat));
        }

        result['myOrderModel'] = myOrderModel;
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result["message"] = "An error occurred";
        result["statusCode"] = statusCode;
        result['error'] = true;
      }
    } catch (error) {
// print(error);
    }

    return result;
  }

  @override
  Future<Map<String, dynamic>> rateOrder({token, order_id, score}) async {
    Map<String, dynamic> result = {};
    const String uri = "$orderApi/orders/rating";

    final url = Uri.parse(uri);
    var headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    };
    var body = jsonEncode({"order_id": order_id, "score": score});
    try {
      var response = await http
          .post(url, body: body, headers: headers)
          .timeout(const Duration(seconds: 30));
      int statusCode = response.statusCode;
// print(statusCode);
//         print(response.body);
      if (statusCode == 200) {
        result['error'] = false;
        result["message"] = jsonDecode(response.body)["message"];
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result["message"] = "An error occurred";
        result["statusCode"] = statusCode;
        result['error'] = true;
      }
    } catch (error) {
// print(error);
    }

    return result;
  }
}

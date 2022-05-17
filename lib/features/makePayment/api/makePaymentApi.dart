import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/utils/apiUrls/env.dart';

abstract class AbstractMakePayment {
  Future<Map<String, dynamic>> updatePaymentDetails(
      {payment_method, reference_number, price, order_id, token});
}

class MakePaymentImpl implements AbstractMakePayment {
  @override
  Future<Map<String, dynamic>> updatePaymentDetails(
      {payment_method, reference_number, price, order_id, token}) async {
    Map<String, dynamic> result = {};
    const String uri = "$orderApi/orders/update-payment";

    final url = Uri.parse(uri);
    var headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    };

    var body = jsonEncode({
      "payment_method": payment_method,
      "reference_number": reference_number,
      "price": price,
      "order_id": order_id
    });

    try {
      var response = await http
          .put(url, body: body, headers: headers)
          .timeout(Duration(minutes: 1));
      int statusCode = response.statusCode;
      print(statusCode);
      print(jsonDecode(response.body));

      if (statusCode == 201) {
        result["message"] = jsonDecode(response.body)["message"];
        result["error"] = false;
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result["message"] = jsonDecode(response.body)["message"];
        result["statusCode"] = statusCode;
        result['error'] = true;
      }
    } catch (error) {}

    // print(result);
    return result;
  }
}

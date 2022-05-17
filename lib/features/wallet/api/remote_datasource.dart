import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/utils/apiUrls/env.dart';
import '../model/initateModel.dart';
import '../model/walletHistoryModel.dart';
import '../model/walletbalance.dart';

abstract class AbstractWallet {
  Future<Map<String, dynamic>> confirmPayment({transaction_id, gateway, token});

  Future<Map<String, dynamic>> getTransaction({token});
  Future<Map<String, dynamic>> fetchWalletBalance({token});

  Future<Map<String, dynamic>> initiatePayment(
      {token, transaction_id, amount, type, previous_balance});

  Future<Map<String, dynamic>> paymentWithWallet({
    token,
    transaction_id,
    amount,
    title,
    user_id,
  });
  // title
  // Testing payment
  // amount
  // 2500
  // transaction_id
  // 1234567
  // user_id
  // 110

}

class WalletApi implements AbstractWallet {
  @override
  Future<Map<String, dynamic>> confirmPayment(
      {transaction_id, gateway, token}) async {
    Map<String, dynamic> result = {};
    const String uri = "$authService/confirm-payment";

    final url = Uri.parse(uri);
    var headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    };
    var body =
        jsonEncode({"transaction_id": transaction_id, "gateway": gateway});
    // print(url);
    // print(headers);
    try {
      var response = await http
          .post(url, body: body, headers: headers)
          .timeout(Duration(seconds: 30));
      int statusCode = response.statusCode;

      // print(jsonDecode(response.body));

      if (jsonDecode(response.body)["status"]) {
        result["error"] = false;

        result["message"] = jsonDecode(response.body)["message"];
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

  @override
  Future<Map<String, dynamic>> getTransaction({token}) async {
    Map<String, dynamic> result = {};
    const String uri = "$authService/wallet-history";

    final url = Uri.parse(uri);
    var headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    };

    // print(url);
    // print(headers);
    try {
      var response =
          await http.get(url, headers: headers).timeout(Duration(seconds: 30));
      int statusCode = response.statusCode;
      // print(jsonDecode(response.body));
      // print(statusCode);
      if (statusCode == 200) {
        result["error"] = false;
        List<WalletHistoryModel> walletHistoryModel = [];
        (jsonDecode(response.body)["pagination"]["data"] as List)
            .forEach((dat) {
          walletHistoryModel.add(WalletHistoryModel.fromJson(dat));
        });

        result['walletHistoryModel'] = walletHistoryModel;
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

  @override
  Future<Map<String, dynamic>> fetchWalletBalance({token}) async {
    Map<String, dynamic> result = {};
    const String uri = "$authService/fetch-balance";

    final url = Uri.parse(uri);
    var headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    };
    // print(url);
    try {
      var response =
          await http.get(url, headers: headers).timeout(Duration(seconds: 30));
      int statusCode = response.statusCode;
      if (statusCode == 200) {
        result["error"] = false;
        result["message"] = jsonDecode(response.body)["message"];
        result["balance"] = WalletBalance.fromJson(jsonDecode(response.body));
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
  Future<Map<String, dynamic>> initiatePayment(
      {token, transaction_id, amount, type, previous_balance}) async {
    Map<String, dynamic> result = {};
    const String uri = "$authService/initiate-payment";

    final url = Uri.parse(uri);
    var headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    };

    var body = jsonEncode({
      "transaction_id": transaction_id,
      "amount": amount,
      "type": type,
      "previous_balance": previous_balance
    });
    // print(url);
    // print(body);
    try {
      var response = await http
          .post(url, body: body, headers: headers)
          .timeout(Duration(seconds: 30));
      int statusCode = response.statusCode;
      // print(statusCode);
      // print(response.body);
      if (jsonDecode(response.body)["status"] == true) {
        result["error"] = false;
        result["message"] =
            InitiateModel.fromJson(jsonDecode(response.body)["data"]);
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result["message"] = jsonDecode(response.body)["message"];
        result["statusCode"] = statusCode;
        result['error'] = true;
      }
    } catch (error) {}

    return result;
  }

  @override
  Future<Map<String, dynamic>> paymentWithWallet(
      {token, transaction_id, amount, title, user_id}) async {
    Map<String, dynamic> result = {};
    final String uri = "$authService/payment-via-wallet";

    final url = Uri.parse(uri);
    var headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    };

    var body = jsonEncode({
      "transaction_id": transaction_id,
      "amount": amount,
      "title": title,
      "user_id": user_id
    });
    // print(url);
    // print(body);
    try {
      var response = await http
          .post(url, body: body, headers: headers)
          .timeout(Duration(seconds: 30));
      int statusCode = response.statusCode;
      // print(statusCode);
      // print(response.body);
      if (jsonDecode(response.body)["status"] == true) {
        result["error"] = false;
        // result["message"] = InitiateModel.fromJson(jsonDecode(response.body)["data"]);

      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result["message"] = jsonDecode(response.body)["message"];
        result["statusCode"] = statusCode;
        result['error'] = true;
      }
    } catch (error) {}

    return result;
  }
}

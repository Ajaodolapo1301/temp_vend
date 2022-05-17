import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../core/utils/apiUrls/env.dart';
import '../model/trackOrderModel.dart';

abstract class AbstractTrackOrder {
  Future<Map<String, dynamic>> trackOrder({id, token});
}

class TrackOrderApi implements AbstractTrackOrder {
  @override
  Future<Map<String, dynamic>> trackOrder({id, token}) async {
    Map<String, dynamic> result = {};
    final String uri = "$orderApi/tracking/$id";

    final url = Uri.parse(uri);
    var headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    };

    print(url);
    // print(headers);
    try {
      var response =
          await http.get(url, headers: headers).timeout(Duration(seconds: 30));
      int statusCode = response.statusCode;
      log(response.body);

      if (statusCode == 200) {
        result["error"] = false;

        // List<TrackOrderModel> trackModel = [];
        // (jsonDecode(response.body)["data"] as List).forEach((dat){
        //   print(dat);
        //   trackModel.add(TrackOrderModel.fromJson(dat));
        // });
        var trackModel = TrackOrderModel.fromJson(jsonDecode(response.body));
        result['trackModel'] = trackModel;
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result["message"] = jsonDecode(response.body)["message"];
        result["statusCode"] = statusCode;
        result['error'] = true;
      }
    } catch (error) {
      print(error);
    }

    print(result);
    return result;
  }
}

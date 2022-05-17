import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vend_express/features/chat/model/agora_token.dart';

import '../../../core/utils/apiUrls/env.dart';

abstract class AbstractChat {
  Future<Map<String, dynamic>> getCallToken({channel, token});
  Future<Map<String, dynamic>> getMessageToken({channel, token});
  Future<Map<String, dynamic>> sendFCMNotification(
      {String receiverToken,
      String myToken,
      String action,
      String senderName,
      String channelName,
      String message,
      String senderId,
      String body,
      String title});
}

class ChatImpl implements AbstractChat {
  @override
  Future<Map<String, dynamic>> getCallToken({channel, token}) async {
    Map<String, dynamic> result = {};
    const String uri = "$orderApi/messaging/token";

    final url = Uri.parse(uri);
    var headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    };
    var body = jsonEncode({
      "channel_name": channel,
    });
    //
    // print(url);
    // print(headers);
    //
    // print(body);
    try {
      var response = await http
          .post(url, body: body, headers: headers)
          .timeout(const Duration(seconds: 30));
      int statusCode = response.statusCode;
      // print(statusCode);
      // print(jsonDecode(response.body));

      if (statusCode == 200) {
        result["error"] = false;
        var token = AgoraToken.fromJson(jsonDecode(response.body));
        result["token"] = token;
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result['message'] = jsonDecode(response.body)["message"];
        result["statusCode"] = statusCode;
        result['error'] = true;
      }
    } catch (error) {}

    return result;
  }

  @override
  Future<Map<String, dynamic>> sendFCMNotification(
      {String? receiverToken,
      String? myToken,
      String? action,
      String? senderName,
      String? channelName,
      String? message,
      String? senderId,
      String? body,
      String? title}) async {
    Map<String, dynamic> result = {};
    var header = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=${SystemProperties.fcm}',
    };
    http.Response response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: header,
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body,
            'title': title,
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'channelName': channelName,
            'action': action,
            'message': message,
            'fcmToken': myToken,
            'senderId': senderId,
            'senderName': senderName
          },
          'to': receiverToken,
        },
      ),
    );
    // print(jsonEncode(
    //   <String, dynamic>{
    //     'notification': <String, dynamic>{
    //       'body': body,
    //       'title': title,
    //       "click_action": "FLUTTER_NOTIFICATION_CLICK",
    //     },
    //     'priority': 'high',
    //     'data': <String, dynamic>{
    //       'channelName': channelName,
    //       'action': action,
    //       'message': message,
    //       'fcmToken': myToken,
    //       'senderId': senderId,
    //       'senderName': senderName
    //     },
    //     'to': receiverToken,
    //   },
    // ));
    // print(header);
    // print("got here");
    // print(response.statusCode);
    result["status"] = response.statusCode;
    return result;
  }

  @override
  Future<Map<String, dynamic>> getMessageToken({channel, token}) async {
    Map<String, dynamic> result = {};
    const String uri = "$orderApi/messaging/message-token";

    final url = Uri.parse(uri);
    var headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    };
    var body = jsonEncode({
      "channel_name": channel,
    });

    // print(url);
    // print(headers);
    //
    // print(body);
    try {
      var response = await http
          .post(url, body: body, headers: headers)
          .timeout(const Duration(seconds: 30));
      int statusCode = response.statusCode;
      // print(statusCode);
      // print(jsonDecode(response.body));

      if (statusCode == 200) {
        result["error"] = false;
        var token = AgoraToken.fromJson(jsonDecode(response.body));
        result["token"] = token;
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result['message'] = jsonDecode(response.body)["message"];
        result["statusCode"] = statusCode;
        result['error'] = true;
      }
    } catch (error) {}

    return result;
  }
}

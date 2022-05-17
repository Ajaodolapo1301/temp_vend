import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../../../core/utils/apiUrls/env.dart';
import '../../../model/initialModel.dart';
import '../../../model/notification_model.dart';
import '../../../model/user.dart';

abstract class AbstractAuth {
  Future<Map<String, dynamic>> login({email, password});

  Future<Map<String, dynamic>> register1({
    role_id,
    email,
    password,
    full_name,
    phone,
    dob,
    home_address,
  });
  Future<Map<String, dynamic>> verifyOtp({phone, pin_id, id, otp});
  Future<Map<String, dynamic>> getUser({token, id});

  Future<Map<String, dynamic>> resendOtp({phone});
  Future<Map<String, dynamic>> requestPasswordchange({phone});

  Future<Map<String, dynamic>> passwordchange({password, phone, pin_id, otp});
  Future<Map<String, dynamic>> phoneInfo({
    token,
    device_token,
  });
  Future<Map<String, dynamic>> getNotification({token, id});
  Future<Map<String, dynamic>> getInitials();
}

class AuthImpl implements AbstractAuth {
  @override
  Future<Map<String, dynamic>> login({email, password}) async {
    Map<String, dynamic> result = {};
    const String uri = "$authService/login?platform=web&type=user";
    final url = Uri.parse(uri);
    var headers = {"content-type": "application/json"};

    var body = ({
      "email": email.trim(),
      "password": password.trim(),
    });

    // print(body);

    try {
      var response = await http
          .post(
            url,
            body: body,
          )
          .timeout(const Duration(seconds: 30));
      int statusCode = response.statusCode;
      // log(response.body);
      // print(jsonDecode(response.body));
      if (statusCode == 200) {
        if (jsonDecode(response.body)["status"] == false) {
          result['error'] = true;
          result["message"] = jsonDecode(response.body)["message"];
          if (jsonDecode(response.body)["data"]["email"] != null) {
            result["otherMessage"] =
                jsonDecode(response.body)["data"]["email"][0];
          } else if (jsonDecode(response.body)["data"]["password"] != null) {
            result["otherMessage"] =
                jsonDecode(response.body)["data"]["password"][0];
          }
        } else if (statusCode == 500) {
          result['error'] = true;
          result["message"] = "Internal Server Error";
        } else {
          result["error"] = false;
          var user = User.fromJson(json.decode(response.body)["data"]);
          result['user'] = user;
        }
      } else {
        result['error'] = true;
        result["message"] = jsonDecode(response.body)["message"];
      }
    } catch (error) {}

    return result;
  }

  @override
  Future<Map<String, dynamic>> register1(
      {role_id, email, password, full_name, phone, dob, home_address}) async {
    Map<String, dynamic> result = {};
    const String uri = "$authService/signup?type=user&platform=web";
    final url = Uri.parse(uri);
    var headers = {"content-type": "application/json"};

    var body = ({
      "role_id": role_id.trim(),
      "email": email.trim(),
      "password": password.trim(),
      "full_name": full_name.trim(),
      "phone": phone.trim(),
      // "dob": "2021-01-21",
      // "home_address": "homepage"
    });

    // print(body);

    try {
      var response = await http
          .post(url, body: jsonEncode(body), headers: headers)
          .timeout(const Duration(seconds: 30));
      int statusCode = response.statusCode;
      // print(statusCode);
      // print(response.body);
      if (jsonDecode(response.body)["status"] == false) {
        result["message"] = jsonDecode(response.body)["message"];
        result['error'] = true;
        result["statusCode"] = statusCode;
        if (jsonDecode(response.body)["data"]["email"] != null) {
          result["otherMessage"] =
              jsonDecode(response.body)["data"]["email"][0];
        } else if (jsonDecode(response.body)["data"]["phone"] != null) {
          result["otherMessage"] =
              jsonDecode(response.body)["data"]["phone"][0];
        }
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result["error"] = false;
        var user = User.fromJson(json.decode(response.body)["data"]);
        result['user'] = user;
      }
    } catch (error) {
      // print(error.toString());
      result["message"] = error.toString();
    }

    return result;
  }

  @override
  Future<Map<String, dynamic>> requestPasswordchange({phone}) async {
    Map<String, dynamic> result = {};
    const String uri =
        "$authService/password/reset-request?via=phone&type=user";
    final url = Uri.parse(uri);
    var headers = {"content-type": "application/json"};

    var body = ({
      "phone": phone,
    });

    // print(body);

    try {
      var response = await http
          .post(url, body: jsonEncode(body), headers: headers)
          .timeout(const Duration(seconds: 30));
      int statusCode = response.statusCode;
      // print(statusCode);
      // print(response.body);
      if (jsonDecode(response.body)["status"] == false) {
        result["message"] = jsonDecode(response.body)["message"];
        result['error'] = true;
        result["statusCode"] = statusCode;
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result["error"] = false;
        result["message"] = jsonDecode(response.body)["data"]["pin_id"];
      }
    } catch (error) {
      // print(error.toString());
      result["message"] = error.toString();
    }

    return result;
  }

  @override
  Future<Map<String, dynamic>> passwordchange(
      {password, phone, pin_id, otp}) async {
    Map<String, dynamic> result = {};
    const String uri = "$authService/password/reset?type=phone";
    final url = Uri.parse(uri);
    var headers = {"content-type": "application/json"};

    var body = ({
      "password": password,
      "phone": phone,
      "pin_id": pin_id,
      "otp": otp,
      "password_confirmation": password
    });

    // print(body);

    try {
      var response = await http
          .post(url, body: jsonEncode(body), headers: headers)
          .timeout(const Duration(seconds: 30));
      int statusCode = response.statusCode;
      print(statusCode);
      print(response.body);
      if (jsonDecode(response.body)["status"] == false) {
        result["message"] = jsonDecode(response.body)["message"];
        result['error'] = true;
        result["statusCode"] = statusCode;
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result["error"] = false;
        result["message"] = jsonDecode(response.body)["message"];
      }
    } catch (error) {
      // print(error.toString());
      result["message"] = error.toString();
    }

    return result;
  }

  @override
  Future<Map<String, dynamic>> verifyOtp({phone, pin_id, id, otp}) async {
    Map<String, dynamic> result = {};
    const String uri = "$authService/verify-otp";
    final url = Uri.parse(uri);
    var headers = {"content-type": "application/json"};

    var body = ({
      "phone": phone,
      "id": id,
      "pin_id": pin_id,
      "otp": otp,
    });

    // print(body);

    try {
      var response = await http
          .post(url, body: jsonEncode(body), headers: headers)
          .timeout(const Duration(seconds: 30));
      int statusCode = response.statusCode;
      // print(statusCode);
      // print(response.body);
      if (jsonDecode(response.body)["status"] == false) {
        result["message"] = jsonDecode(response.body)["message"];
        result['error'] = true;
        result["statusCode"] = statusCode;
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result["error"] = false;
        result["message"] = jsonDecode(response.body)["message"];
      }
    } catch (error) {
      // print(error.toString());
      result["message"] = error.toString();
    }

    return result;
  }

  @override
  Future<Map<String, dynamic>> resendOtp({phone}) async {
    Map<String, dynamic> result = {};
    const String uri = "$authService/user/fcm";
    final url = Uri.parse(uri);
    var headers = {"content-type": "application/json"};

    var body = ({
      "phone": phone,
    });

    // print(body);
    // print(url);
    try {
      var response = await http
          .post(url, body: jsonEncode(body), headers: headers)
          .timeout(const Duration(seconds: 30));
      int statusCode = response.statusCode;
      // print(statusCode);
      // print(response.body);
      if (jsonDecode(response.body)["status"] == false) {
        result["message"] = jsonDecode(response.body)["message"];
        result['error'] = true;
        result["statusCode"] = statusCode;
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result["error"] = false;
        result["message"] = jsonDecode(response.body)["message"];
      }
    } catch (error) {
      // print(error.toString());
      result["message"] = error.toString();
    }

    return result;
  }

  @override
  Future<Map<String, dynamic>> phoneInfo({token, device_token}) async {
    Map<String, dynamic> result = {};
    const String uri = "$authService/user/fcm";
    final url = Uri.parse(uri);
    var headers = {"Authorization": "Bearer $token"};

    var body = {
      "fcm_token": device_token,
    };

    // print(body);
    // print(url);
    // print(headers);
    try {
      var response = await http
          .post(url, body: body, headers: headers)
          .timeout(const Duration(seconds: 30));
      int statusCode = response.statusCode;
      // print(response.body);
      if (statusCode != 200 && statusCode != 500) {
        result["message"] = jsonDecode(response.body)["message"];
        result["statusCode"] = statusCode;
        result['error'] = true;
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result["error"] = false;
        result["message"] = jsonDecode(response.body)["message"];
      }
    } catch (error) {
      // print(error.toString());
    }

    return result;
  }

  @override
  Future<Map<String, dynamic>> getUser({token, id}) async {
    Map<String, dynamic> result = {};
    final String uri = "$authService/user/profile?id=$id";
    final url = Uri.parse(uri);
    var headers = {
      "content-type": "application/json",
      "Authorization": "Bearer $token"
    };

    try {
      var response = await http
          .get(url, headers: headers)
          .timeout(const Duration(seconds: 30));
      int statusCode = response.statusCode;
      // log(response.body);
      // print(jsonDecode(response.body));
      if (statusCode == 200) {
        if (jsonDecode(response.body)["status"] == false) {
          result['error'] = true;
          result["message"] = jsonDecode(response.body)["message"];
          if (jsonDecode(response.body)["data"]["email"] != null) {
            result["otherMessage"] = jsonDecode(response.body)["data"]["email"];
          } else if (jsonDecode(response.body)["data"]["password"] != null) {
            result["otherMessage"] =
                jsonDecode(response.body)["data"]["password"];
          }
        } else if (statusCode == 500) {
          result['error'] = true;
          result["message"] = "Internal Server Error";
        } else {
          result["error"] = false;
          var user = User.fromJson(json.decode(response.body)["data"]);
          result['user'] = user;
        }
      } else {
        result['error'] = true;
        result["message"] = jsonDecode(response.body)["message"];
      }
    } catch (error) {}

    return result;
  }

  @override
  Future<Map<String, dynamic>> getNotification({token, id}) async {
    Map<String, dynamic> result = {};
    final String uri =
        "https://tapi.hexlogistics.ng/notification/api/notification?user_id=$id";
    final url = Uri.parse(uri);
    var headers = {
      "content-type": "application/json",
      "Authorization": "Bearer $token"
    };

    try {
      var response = await http
          .get(url, headers: headers)
          .timeout(const Duration(seconds: 30));
      int statusCode = response.statusCode;
      // print(jsonDecode(response.body));
      // print(statusCode);
      if (statusCode == 200) {
        result["error"] = false;
        List<NotificationModel> notif = [];
        (jsonDecode(response.body)["data"] as List).forEach((dat) {
          notif.add(NotificationModel.fromJson(dat));
        });

        result['notif'] = notif;
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
  Future<Map<String, dynamic>> getInitials() async {
    Map<String, dynamic> result = {};
    const String uri = "$orderApi/initials";
    final url = Uri.parse(uri);
    var headers = {
      "content-type": "application/json",
    };

    try {
      var response = await http
          .get(url, headers: headers)
          .timeout(const Duration(seconds: 30));
      int statusCode = response.statusCode;
      log(response.body);
      // print(statusCode);
      if (statusCode == 200) {
        var init = InitialModel.fromJson(jsonDecode(response.body));
        result["init"] = init;
        result['error'] = false;
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


import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:http/http.dart'as http;
import 'package:http_parser/http_parser.dart';

import '../../../core/utils/apiUrls/env.dart';
import '../model/analyticsModel.dart';
import '../model/primehexFaq.dart';


abstract class AbstractProfile {
  Future <Map<String, dynamic>> appRatings({rate , message, token});
  Future <Map<String, dynamic>> reportIssues({message, token});
  Future <Map<String, dynamic>> analytics({token});
  Future <Map<String, dynamic>> editprofile({  gender, dob, full_name, home_address,token, city, state});

  Future <Map<String, dynamic>> notificationSettings({  new_update_notification, push_notification, sms_notification, email_notification, in_app_sound, in_app_vibrate, token});

  Future <Map<String, dynamic>> uploadimage({File profile_image, token});
  Future <Map<String, dynamic>> changePassword({currentPass, password_confirmation, password, token});
  Future <Map<String, dynamic>> faq({token});

}


class ProfileApi implements AbstractProfile{
  @override
  Future<Map<String, dynamic>> appRatings({rate, message, token}) async{
    Map<String, dynamic> result = {};
    const String uri = "$authService/app-ratings";


    final  url  =   Uri.parse(uri);
    var headers = {
      "Content-type" :"application/json",
      "Authorization" : "Bearer $token"
    };
    var body = jsonEncode( {
      "rate" : rate.toString(),
      "message" : message
    });

    // print(url);
    // print(headers);
    //
    // print(body);
    try {
      var response = await http.post(url, body: body, headers: headers).timeout(const Duration(seconds: 30));
      int statusCode = response.statusCode;
// print(statusCode);
      // print(jsonDecode(response.body));

      if (jsonDecode(response.body)["status"] == true) {

        result["error"] = false;
result['message'] = jsonDecode(response.body)["message"];


      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {

        result['message'] = jsonDecode(response.body)["message"];
        result["statusCode"] = statusCode;
        result['error'] = true;





      }
    } catch (error) {

    }

    // print(result);
    return result;
  }

  @override
  Future<Map<String, dynamic>> changePassword({currentPass, password_confirmation, password, token}) async{
    Map<String, dynamic> result = {};
    const String uri = "$authService/change-password";


    final  url  =   Uri.parse(uri);
    var headers = {
      "Content-type" :"application/json",
      "Authorization" : "Bearer $token"


    };
var body = jsonEncode({
  "current_password" : currentPass,

  "password": password,

  "password_confirmation" : password_confirmation
});
    // print(url);
    // print(body);
    try {
      var response = await http.post(url, body: body, headers: headers).timeout(const Duration(seconds: 30));
      int statusCode = response.statusCode;

      // print(jsonDecode(response.body));

      if (statusCode == 200) {

        result["error"] = false;
        result['message'] = jsonDecode(response.body)["message"];


      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {

        result['message'] = jsonDecode(response.body)["current_password"];

        result["statusCode"] = statusCode;
        result['error'] = true;





      }
    } catch (error) {

    }

    // print(result);
    return result;
  }

  @override
  Future<Map<String, dynamic>> reportIssues({message, token}) async{
    Map<String, dynamic> result = {};
    const String uri = "$authService/report-issue";


    final  url  =   Uri.parse(uri);
    var headers = {
      "Content-type" :"application/json",
      "Authorization" : "Bearer $token"

    };

    var body = jsonEncode({
      "message" : message
    });

    // print(url);
    // print(headers);
    try {
      var response = await http.post(url,body: body, headers: headers ).timeout(const Duration(seconds: 30));
      int statusCode = response.statusCode;

      // print(jsonDecode(response.body));

      if (statusCode == 200) {

        result["error"] = false;
        result['message'] = jsonDecode(response.body)["message"];


      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {

        result["message"] = "An error occurred";
        result["statusCode"] = statusCode;
        result['error'] = true;





      }
    } catch (error) {}


    return result;
  }

  @override
  Future<Map<String, dynamic>> editprofile({gender, dob, full_name,token, home_address, city, state,})async {

    Dio dio = Dio();
    Map<String, dynamic> result = {};


    var formData = FormData.fromMap({
      "full_name": full_name,
      // "profile_image" : profile_image == null ? "" : await MultipartFile ?.fromFile(profile_image?.path, filename: profile_image.path.split("/").last, contentType:  MediaType("application", "png"),),

    });

    // print(formData.fields);
    // print(formData.files);
    print( {
      "authorization": "Bearer $token",
      // "Content-type" : "application/json",
    });
    try{
      var resp =  await dio.post('$authService/user/profile', data: formData,  options:  Options(
        headers: {
          "authorization": "Bearer $token",
          "content-type" : "multipart/form-data",
          // "business-uuid" : business_uuid

        },

      ) ,
        onSendProgress: (int sent, int total) {
          print("sent${sent.toString()}" + " total${total.toString()}");
        },
      ).whenComplete(() {
        print("complete:");
      }).catchError((onError) {
        print("error:${onError.toString()}");
      });


      // print(resp);
      int statusCode = resp.statusCode!;

      if (statusCode != 200 && statusCode != 500) {
        result["message"] = resp.data["message"];
        result['error'] = true;
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "An Error occured";
      } else {
        result["error"] = false;
        result["message"] = resp.data["message"];
      }
    } catch (error) {
      // print("from here ${error.toString()}");

    }

    return result;

  }

  @override
  Future<Map<String, dynamic>> analytics({token}) async{
    Map<String, dynamic> result = {};
    const String uri = "$orderApi/order-analytics/my-analytics";


    final  url  =   Uri.parse(uri);
    var headers = {
      "Content-type" :"application/json",
      "Authorization" : "Bearer $token"


    };

    // print(url);
    // print(headers);
    try {
      var response = await http.get(url, headers: headers ).timeout(const Duration(seconds: 30));
      int statusCode = response.statusCode;

      print(jsonDecode(response.body));

      if (statusCode == 200) {

        result["error"] = false;
        var analytics = AnalyticsModel.fromJson(jsonDecode(response.body));
      result["analytics"] = analytics;

      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {

        result["message"] = jsonDecode(response.body)["message"] ?? "An error occurred";
        result["statusCode"] = statusCode;
        result['error'] = true;





      }
    } catch (error) {

    }

    // print(result);
    return result;
  }

  @override
  Future<Map<String, dynamic>> uploadimage({File? profile_image, token})async {


    Dio dio = Dio();
    Map<String, dynamic> result = {};


    var formData = FormData.fromMap({
      "profile_image" : await MultipartFile.fromFile(profile_image!.path, filename: profile_image.path.split("/").last, contentType:  MediaType("application", "png"),),

    });

    // print(formData.fields);
    // print(formData.files);
    print( {
      "authorization": "Bearer $token",
      // "Content-type" : "application/json",
    });
    try{
      var resp =  await dio.post('$authService/user/profile/image?type=user', data: formData,  options:  Options(
        headers: {
          "authorization": "Bearer $token",
          "content-type" : "multipart/form-data",
          // "business-uuid" : business_uuid

        },

      ) ,
        onSendProgress: (int sent, int total) {
          print("sent${sent.toString()}" + " total${total.toString()}");
        },
      ).whenComplete(() {
        // print("complete:");
      }).catchError((onError) {
        // print("error:${onError.toString()}");
      });


      // print(resp);
      int statusCode = resp.statusCode!;

      if (statusCode != 200 && statusCode != 500) {
        result["message"] = resp.data["message"];
        result['error'] = true;
      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "An Error occured";
      } else {
        result["error"] = false;
        result["message"] = resp.data["message"];
      }
    } catch (error) {
      // print("from here ${error.toString()}");

    }

    return result;
  }

  @override
  Future<Map<String, dynamic>> notificationSettings({new_update_notification, push_notification, sms_notification, email_notification, in_app_sound, in_app_vibrate, token}) async{
    Map<String, dynamic> result = {};
    final String uri = "$authService/notification";


    final  url  =   Uri.parse(uri);
    var headers = {
      "Content-type" :"application/json",
      "Authorization" : "Bearer $token"

    };

    var body = jsonEncode({
      "new_update_notification": new_update_notification,
      "push_notification" : push_notification,
      "sms_notification":sms_notification,
      "email_notification" :email_notification,
      "in_app_sound" : in_app_sound,
      "in_app_vibrate": in_app_vibrate
    });

    print(url);
    print(headers);
    try {
      var response = await http.post(url,body: body, headers: headers ).timeout(const Duration(seconds: 30));
      int statusCode = response.statusCode;

      // print(jsonDecode(response.body));

      if (statusCode == 200) {

        result["error"] = false;
        result['message'] = jsonDecode(response.body)["message"];


      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result["message"] = "An error occurred";
        result["statusCode"] = statusCode;
        result['error'] = true;


      }
    } catch (error) {

    }


    return result;
  }

  @override
  Future<Map<String, dynamic>> faq({token}) async{
    Map<String, dynamic> result = {};
    const String uri = "$merchantService/faqs?type=user";


    final  url  =   Uri.parse(uri);
    var headers = {
      "Content-type" :"application/json",
      "Authorization" : "Bearer $token"

    };


// print(url);
    try {
      var response = await http.get(url,headers: headers ).timeout(const Duration(seconds: 30));
      int statusCode = response.statusCode;

      // print(jsonDecode(response.body));

      if (statusCode == 200) {

        result["error"] = false;
        List<Faq> faq = [];
        for (var dat in (jsonDecode(response.body) as List)) {

          faq.add(Faq.fromJson(dat));
        }
      result["faq"] = faq;

      } else if (statusCode == 500) {
        result['error'] = true;
        result["message"] = "Internal Server Error";
      } else {
        result["message"] = "An error occurred";
        result["statusCode"] = statusCode;
        result['error'] = true;


      }
    } catch (error) {

    }

// print(result);
    return result;
  }

}



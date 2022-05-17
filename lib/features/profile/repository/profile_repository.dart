import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../core/error/failures.dart';
import '../datasource/remote_data_source.dart';
import '../model/analyticsModel.dart';
import '../model/primehexFaq.dart';

abstract class AbstractProfileRepository {
  Future<Either<Failure, String>> appRatings({rate, message, token});
  Future<Either<Failure, String>> reportIssues({message, token});
  Future<Either<Failure, String>> editprofile({
    gender,
    dob,
    full_name,
    home_address,
    token,
    city,
    state,
  });
  Future<Either<Failure, String>> changePassword(
      {currentPass, password_confirmation, password, token});
  Future<Either<Failure, AnalyticsModel>> analytics({token});
  Future<Either<Failure, String>> uploadimage({File profile_image, token});
  Future<Either<Failure, String>> notificationSettings(
      {new_update_notification,
      push_notification,
      sms_notification,
      email_notification,
      in_app_sound,
      in_app_vibrate,
      token});
  Future<Either<Failure, List<Faq>>> faq({token});
}

class ProfileRepoImpl implements AbstractProfileRepository {
  @override
  Future<Either<Failure, String>> appRatings({rate, message, token}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await ProfileApi()
            .appRatings(rate: rate, message: message, token: token);

        if (res["error"] == false) {
          return Right(res["message"]);
        } else {
          return Left(ServerFailure(res["message"]));
        }
      } catch (e) {
        return Left(ServerFailure(e));
      }
    }
    return Left(ServerFailure("No internet acesss"));
  }

  @override
  Future<Either<Failure, String>> changePassword(
      {currentPass, password_confirmation, password, token}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await ProfileApi().changePassword(
            currentPass: currentPass,
            password: password,
            token: token,
            password_confirmation: password_confirmation);

        if (res["error"] == false) {
          return Right(res["message"]);
        } else {
          return Left(ServerFailure(res["message"]));
        }
      } catch (e) {
        return Left(ServerFailure(e));
      }
    }
    return Left(ServerFailure("No internet acesss"));
  }

  @override
  Future<Either<Failure, String>> editprofile({
    gender,
    dob,
    full_name,
    home_address,
    token,
    city,
    state,
  }) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await ProfileApi().editprofile(
          gender: gender,
          dob: dob,
          token: token,
          full_name: full_name,
          home_address: home_address,
          city: city,
          state: state,
        );

        if (res["error"] == false) {
          return Right(res["message"]);
        } else {
          return Left(ServerFailure(res["message"]));
        }
      } catch (e) {
        return Left(ServerFailure(e));
      }
    }
    return Left(ServerFailure("No internet acesss"));
  }

  @override
  Future<Either<Failure, String>> reportIssues({message, token}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res =
            await ProfileApi().reportIssues(message: message, token: token);

        if (res["error"] == false) {
          return Right(res["message"]);
        } else {
          return Left(ServerFailure(res["message"]));
        }
      } catch (e) {
        return Left(ServerFailure(e));
      }
    }
    return Left(ServerFailure("No internet acesss"));
  }

  @override
  Future<Either<Failure, AnalyticsModel>> analytics({token}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await ProfileApi().analytics(token: token);

        if (res["error"] == false) {
          return Right(res["analytics"]);
        } else {
          return Left(ServerFailure(res["message"]));
        }
      } catch (e) {
        return Left(ServerFailure(e));
      }
    }
    return Left(ServerFailure("No internet acesss"));
  }

  @override
  Future<Either<Failure, String>> uploadimage(
      {File? profile_image, token}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await ProfileApi()
            .uploadimage(token: token, profile_image: profile_image);

        if (res["error"] == false) {
          return Right(res["message"]);
        } else {
          return Left(ServerFailure(res["message"]));
        }
      } catch (e) {
        return Left(ServerFailure(e));
      }
    }
    return Left(ServerFailure("No internet access"));
  }

  @override
  Future<Either<Failure, String>> notificationSettings(
      {new_update_notification,
      push_notification,
      sms_notification,
      email_notification,
      in_app_sound,
      in_app_vibrate,
      token}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await ProfileApi().notificationSettings(
            token: token,
            new_update_notification: new_update_notification,
            push_notification: push_notification,
            email_notification: email_notification,
            in_app_sound: in_app_sound,
            in_app_vibrate: in_app_vibrate,
            sms_notification: sms_notification);

        if (res["error"] == false) {
          return Right(res["message"]);
        } else {
          return Left(ServerFailure(res["message"]));
        }
      } catch (e) {
        return Left(ServerFailure(e));
      }
    }
    return Left(ServerFailure("No internet access"));
  }

  @override
  Future<Either<Failure, List<Faq>>> faq({token}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await ProfileApi().faq(token: token);

        if (res["error"] == false) {
          return Right(res["faq"]);
        } else {
          return Left(ServerFailure(res["message"]));
        }
      } catch (e) {
        return Left(ServerFailure(e));
      }
    }
    return Left(ServerFailure("No internet access"));
  }
}

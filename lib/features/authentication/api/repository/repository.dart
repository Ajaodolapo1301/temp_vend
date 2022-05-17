import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../model/initialModel.dart';
import '../../model/notification_model.dart';
import '../../model/user.dart';
import '../data_source/remote_data_source/remote_data.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> login(email, password);

  Future<Either<Failure, User>> register1({
    role_id,
    email,
    password,
    full_name,
    phone,
    dob,
    home_address,
  });
  Future<Either<Failure, String>> verifyOtp({phone, pin_id, id, otp});

  Future<Either<Failure, String>> requestPasswordchange({phone});

  Future<Either<Failure, String>> passwordchange(
      {password, phone, pin_id, otp});
  Future<Either<Failure, String>> resendOtp({phone});

  Future<Either<Failure, String>> phoneInfo({
    token,
    device_token,
  });
  Future<Either<Failure, User>> getUser({token, id});
  Future<Either<Failure, List<NotificationModel>>> getNotification({token, id});

  Future<Either<Failure, InitialModel>> getInitials();
}

class UserRepositoryImpl implements UserRepository {
  final NetworkInfo? networkInfo;

  UserRepositoryImpl({this.networkInfo});

  @override
  Future<Either<Failure, User>> login(email, password) async {
    bool result = await InternetConnectionChecker().hasConnection;
    // print("con result$result");
    if (result) {
      try {
        final res = await AuthImpl().login(email: email, password: password);

        if (res["error"] == false) {
          return Right(res["user"]);
        } else {
          return Left(
              ServerFailure(res["message"], otherMessage: res["otherMessage"]));
        }
      } catch (e) {
        // print(e);
        return Left(ServerFailure(e));
      }
    }
    return Left(ServerFailure("No internet acesss"));
  }

  @override
  Future<Either<Failure, User>> register1(
      {role_id, email, password, full_name, phone, dob, home_address}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await AuthImpl().register1(
            email: email,
            password: password,
            full_name: full_name,
            dob: dob,
            home_address: home_address,
            phone: phone,
            role_id: role_id);

        if (res["error"] == false) {
          return Right(res["user"]);
        } else {
          return Left(
              ServerFailure(res["message"], otherMessage: res["otherMessage"]));
        }
      } catch (e) {
        return Left(ServerFailure(e));
      }
    }
    return Left(ServerFailure("No internet acesss"));
  }

  @override
  Future<Either<Failure, String>> verifyOtp({phone, pin_id, id, otp}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await AuthImpl()
            .verifyOtp(id: id, otp: otp, phone: phone, pin_id: pin_id);

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
  Future<Either<Failure, String>> requestPasswordchange({phone}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await AuthImpl().requestPasswordchange(
          phone: phone,
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
  Future<Either<Failure, String>> passwordchange(
      {password, phone, pin_id, otp}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await AuthImpl().passwordchange(
            phone: phone, password: password, pin_id: pin_id, otp: otp);

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
  Future<Either<Failure, String>> resendOtp({phone}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await AuthImpl().resendOtp(
          phone: phone,
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
  Future<Either<Failure, String>> phoneInfo({token, device_token}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await AuthImpl()
            .phoneInfo(token: token, device_token: device_token);

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
  Future<Either<Failure, User>> getUser({token, id}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await AuthImpl().getUser(token: token, id: id);

        if (res["error"] == false) {
          return Right(res["user"]);
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
  Future<Either<Failure, List<NotificationModel>>> getNotification(
      {token, id}) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await AuthImpl().getNotification(token: token, id: id);

        if (res["error"] == false) {
          return Right(res["notif"]);
        } else {
          return Left(ServerFailure(res["message"] ?? "An error occurred"));
        }
      } catch (e) {
        // print(e);
        return Left(ServerFailure(e));
      }
    }
    return Left(ServerFailure("No internet access"));
  }

  @override
  Future<Either<Failure, InitialModel>> getInitials() async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final res = await AuthImpl().getInitials();

        if (res["error"] == false) {
          return Right(res["init"]);
        } else {
          return Left(ServerFailure(res["message"] ?? "An error occurred"));
        }
      } catch (e) {
        print(e);
        return Left(ServerFailure(e));
      }
    }
    return Left(ServerFailure("No internet access"));
  }
}

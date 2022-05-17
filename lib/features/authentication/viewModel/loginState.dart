import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../../core/GlobalState/baseState.dart';
import '../../../core/error/failures.dart';
import '../api/data_source/local_data_source/user_hive.dart';
import '../api/repository/repository.dart';
import '../model/initialModel.dart';
import '../model/notification_model.dart';
import '../model/user.dart';

abstract class AbstractLoginViewModel extends BaseViewModel {
  Future<Either<Failure, User>> login({email, password});
  Future<Either<Failure, User>> register({
    email,
    role_id,
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

class LoginState extends AbstractLoginViewModel {
  User? _user;
  // UserRepository userRepository;
  //
  // LoginState({ this.userRepository});
  UserHive hive = UserHive(hive: Hive);

  User get user => _user!;
  set user(User? value) {
    _user = value;
    notifyListeners();
  }

  LoginState({User? value}) {
    if (value != null) {
      user = value;
    }
  }

  List<NotificationModel> _notificationList = [];
  List<NotificationModel> get notificationList => _notificationList;
  set notificationList(List<NotificationModel> value) {
    _notificationList = value;
    notifyListeners();
  }

  @override
  Future<Either<Failure, User>> login({email, password}) async {
    setBusy(true);
    var res = await UserRepositoryImpl().login(email, password);
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (user1) {
      user = user1 as User;
    });
    await hive.cacheUser(user: user);
    var user1 = await hive.getUser();
    user = user1;
    return res;
  }

  @override
  Future<Either<Failure, User>> register(
      {role_id, email, password, full_name, phone, dob, home_address}) async {
    setBusy(true);
    var res = await UserRepositoryImpl().register1(
        email: email,
        phone: phone,
        role_id: role_id,
        full_name: full_name,
        home_address: home_address,
        dob: dob,
        password: password);
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (user1) {
      user = user1 as User;
    });
    await hive.cacheUser(user: user);
    var user1 = await hive.getUser();
    user = user1;
    return res;
  }

  @override
  Future<Either<Failure, String>> verifyOtp({phone, pin_id, id, otp}) async {
    setBusy(true);
    var res = await UserRepositoryImpl().verifyOtp(
      otp: otp,
      phone: phone,
      pin_id: pin_id,
      id: id,
    );
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (message) {
      return message;
    });
    return res;
  }

  @override
  Future<Either<Failure, String>> requestPasswordchange({phone}) async {
    setBusy(true);
    var res = await UserRepositoryImpl().requestPasswordchange(
      phone: phone,
    );
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (message) {
      return message;
    });
    return res;
  }

  @override
  Future<Either<Failure, String>> passwordchange(
      {password, phone, pin_id, otp}) async {
    setBusy(true);
    var res = await UserRepositoryImpl().passwordchange(
      pin_id: pin_id,
      password: password,
      otp: otp,
      phone: phone,
    );
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (message) {
      return message;
    });
    return res;
  }

  @override
  Future<Either<Failure, String>> resendOtp({phone}) async {
    setBusy(true);
    var res = await UserRepositoryImpl().resendOtp(
      phone: phone,
    );
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (message) {
      return message;
    });
    return res;
  }

  @override
  Future<Either<Failure, String>> phoneInfo({token, device_token}) async {
    setBusy(true);
    var res = await UserRepositoryImpl().phoneInfo(
      token: token,
      device_token: device_token,
    );
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (message) {
      return message;
    });
    return res;
  }

  @override
  Future<Either<Failure, User>> getUser({token, id}) async {
    setBusy(true);
    var res = await UserRepositoryImpl().getUser(token: token, id: id);
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (user1) async {
      await hive.cacheUser(
          user: User(
              id: user1.id,
              ratings: user1.ratings,
              roleId: user1.roleId,
              fullName: user1.fullName,
              email: user1.email,
              phone: user1.phone,
              profileImageUrl: user1.profileImageUrl,
              language: user1.language,
              dob: user1.dob,
              homeAddress: user1.homeAddress,
              onboard: user1.onboard!,
              otp: user1.otp,
              fcmToken: user1.fcmToken,
              emailNotification: user1!.emailNotification!,
              newUpdateNotification: user1.newUpdateNotification,
              inAppSound: user1.inAppSound,
              inAppVibrate: user1.inAppVibrate,
              pushNotification: user1.pushNotification,
              smsNotification: user1.smsNotification,
              token: user.token));
      // return user;
    });

    var user1 = await hive.getUser();
    user = user1;
    return res;
  }

  @override
  Future<Either<Failure, List<NotificationModel>>> getNotification(
      {token, id}) async {
    setBusy(true);
    var res = await UserRepositoryImpl().getNotification(token: token, id: id);
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (message) {
      _notificationList = message;
      return message;
    });
    return res;
  }

  @override
  Future<Either<Failure, InitialModel>> getInitials() async {
    setBusy(true);
    var res = await UserRepositoryImpl().getInitials();
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (message) {
      return message;
    });
    print("resss$res");
    return res;
  }
}

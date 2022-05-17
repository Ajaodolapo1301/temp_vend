import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/GlobalState/baseState.dart';
import '../../../core/error/failures.dart';
import '../model/analyticsModel.dart';
import '../model/primehexFaq.dart';
import '../repository/profile_repository.dart';

abstract class AbstractProfileViewModel extends BaseViewModel {
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

class ProfileState extends AbstractProfileViewModel {
  List<Faq> _faq = [];
  List<Faq> get faqList => _faq;
  set faqList(List<Faq> faq1) {
    _faq = faq1;
    notifyListeners();
  }

  @override
  Future<Either<Failure, String>> appRatings({rate, message, token}) async {
    setBusy(true);
    var res = await ProfileRepoImpl()
        .appRatings(rate: rate, message: message, token: token);
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {
      return r;
    });

    return res;
  }

  @override
  Future<Either<Failure, String>> changePassword(
      {currentPass, password_confirmation, password, token}) async {
    setBusy(true);
    var res = await ProfileRepoImpl().changePassword(
        password: password,
        password_confirmation: password_confirmation,
        currentPass: currentPass,
        token: token);
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {});

    return res;
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
    setBusy(true);
    var res = await ProfileRepoImpl().editprofile(
      token: token,
      gender: gender,
      dob: dob,
      full_name: full_name,
      home_address: home_address,
      city: city,
      state: state,
    );
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {});

    return res;
  }

  @override
  Future<Either<Failure, String>> reportIssues({message, token}) async {
    setBusy(true);
    var res =
        await ProfileRepoImpl().reportIssues(message: message, token: token);
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {});

    return res;
  }

  @override
  Future<Either<Failure, AnalyticsModel>> analytics({token}) async {
    setBusy(true);
    var res = await ProfileRepoImpl().analytics(token: token);
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {});

    return res;
  }

  @override
  Future<Either<Failure, String>> uploadimage(
      {File? profile_image, token}) async {
    setBusy(true);
    var res = await ProfileRepoImpl()
        .uploadimage(token: token, profile_image: profile_image!);
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {});

    return res;
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
    setBusy(true);
    var res = await ProfileRepoImpl().notificationSettings(
        token: token,
        new_update_notification: new_update_notification,
        push_notification: push_notification,
        sms_notification: sms_notification,
        email_notification: email_notification,
        in_app_vibrate: in_app_vibrate,
        in_app_sound: in_app_sound);
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {});

    return res;
  }

  @override
  Future<Either<Failure, List<Faq>>> faq({token}) async {
    setBusy(true);
    var res = await ProfileRepoImpl().faq(
      token: token,
    );
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {
      _faq = r;
    });

    return res;
  }
}

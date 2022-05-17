import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 4, adapterName: "UserAdap")
class User {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? roleId;
  @HiveField(2)
  String? fullName;
  @HiveField(3)
  String? email;
  @HiveField(4)
  String? phone;
  @HiveField(5)
  String? profileImageUrl;
  @HiveField(6)
  String? language;
  @HiveField(7)
  String? dob;
  @HiveField(8)
  String? homeAddress;
  @HiveField(9)
  String? ratings;
  @HiveField(10)
  bool? onboard;
  @HiveField(11)
  String? token;
  @HiveField(12)
  String? pinId;
  @HiveField(13)
  String? otp;
  @HiveField(14)
  String? fcmToken;
  @HiveField(15)
  bool? newUpdateNotification;
  @HiveField(16)
  bool? pushNotification;
  @HiveField(17)
  bool? smsNotification;
  @HiveField(18)
  bool? emailNotification;
  @HiveField(19)
  bool? inAppSound;
  @HiveField(20)
  bool? inAppVibrate;

  User(
      {this.id,
      this.roleId,
      this.fullName,
      this.email,
      this.phone,
      this.profileImageUrl,
      this.language,
      this.dob,
      this.homeAddress,
      this.ratings,
      this.onboard,
      this.token,
      this.pinId,
      this.otp,
      this.fcmToken,
      this.newUpdateNotification,
      this.pushNotification,
      this.smsNotification,
      this.emailNotification,
      this.inAppSound,
      this.inAppVibrate});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    fullName = json['full_name'];
    email = json['email'];
    phone = json['phone'];
    if (json['profile_image_url'] == null) {
      profileImageUrl = "";
    } else {
      profileImageUrl = json['profile_image_url'];
    }

    language = json['language'];
    dob = json['dob'];
    homeAddress = json['home_address'];
    ratings = json['ratings'];
    onboard = json['onboard'];
    token = json['token'];
    pinId = json['pin_id'];
    otp = json['otp'];
    if (json['fcm_token'] == null) {
      fcmToken = "";
    } else {
      fcmToken = json["fcm_token"];
    }
    if (json['new_update_notification'] == null) {
      newUpdateNotification = false;
    } else {
      newUpdateNotification = json['new_update_notification'];
    }

    if (json['new_update_notification'] == null) {
      newUpdateNotification = false;
    } else {
      newUpdateNotification = json['new_update_notification'];
    }

    if (json['push_notification'] == null) {
      pushNotification = false;
    } else {
      pushNotification = json['push_notification'];
    }

    if (json['sms_notification'] == null) {
      smsNotification = false;
    } else {
      smsNotification = json['sms_notification'];
    }

    if (json['email_notification'] == null) {
      emailNotification = false;
    } else {
      emailNotification = json['email_notification'];
    }

    if (json['in_app_sound'] == null) {
      inAppSound = false;
    } else {
      inAppSound = json['in_app_sound'];
    }

    if (json['in_app_vibrate'] == null) {
      inAppVibrate = false;
    } else {
      inAppVibrate = json['in_app_vibrate'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['role_id'] = roleId;
    data['full_name'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    data['profile_image_url'] = profileImageUrl;
    data['language'] = language;
    data['dob'] = dob;
    data['home_address'] = homeAddress;
    data['ratings'] = ratings;
    data['onboard'] = onboard;
    data['token'] = token;
    data['pin_id'] = pinId;
    data['otp'] = otp;
    data['fcm_token'] = fcmToken;
    data['new_update_notification'] = newUpdateNotification;
    data['push_notification'] = pushNotification;
    data['sms_notification'] = smsNotification;
    data['email_notification'] = emailNotification;
    data['in_app_sound'] = inAppSound;
    data['in_app_vibrate'] = inAppVibrate;
    return data;
  }
}

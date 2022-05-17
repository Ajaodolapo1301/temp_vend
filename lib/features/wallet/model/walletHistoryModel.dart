class WalletHistoryModel {
  int? id;
  int? userId;
  int? walletId;
  String? transactionId;
  String? amount;
  String? type;
  String? status;
  String? paymentChannel;
  String? paidAt;
  String? message;
  String? title;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  UserWallet? user;

  WalletHistoryModel(
      {this.id,
      this.userId,
      this.walletId,
      this.transactionId,
      this.amount,
      this.type,
      this.status,
      this.paymentChannel,
      this.paidAt,
      this.message,
      this.title,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.user});

  WalletHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    walletId = json['wallet_id'];
    transactionId = json['transaction_id'];
    amount = json['amount'];
    type = json['type'];
    status = json['status'];
    paymentChannel = json['payment_channel'];
    paidAt = json['paid_at'];
    message = json['message'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    user = json['user'] != null ? UserWallet.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['wallet_id'] = walletId;
    data['transaction_id'] = transactionId;
    data['amount'] = amount;
    data['type'] = type;
    data['status'] = status;
    data['payment_channel'] = paymentChannel;
    data['paid_at'] = paidAt;
    data['message'] = message;
    data['title'] = title;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class UserWallet {
  int? id;
  int? roleId;
  String? email;
  String? fullName;
  String? phone;
  String? onboard;
  String? status;
  String? gender;
  String? notificationChannel;
  String? language;

  String? createdAt;
  String? updatedAt;

  UserWallet({
    this.id,
    this.roleId,
    this.email,
    this.fullName,
    this.phone,
    this.onboard,
    this.status,
    this.gender,
    this.notificationChannel,
    this.language,
    this.createdAt,
    this.updatedAt,
  });

  UserWallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    email = json['email'];
    fullName = json['full_name'];
    phone = json['phone'];
    onboard = json['onboard'];
    status = json['status'];
    gender = json['gender'];
    notificationChannel = json['notification_channel'];
    language = json['language'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['role_id'] = roleId;
    data['email'] = email;
    data['full_name'] = fullName;
    data['phone'] = phone;
    data['onboard'] = onboard;
    data['status'] = status;
    data['gender'] = gender;
    data['notification_channel'] = notificationChannel;
    data['language'] = language;

    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    return data;
  }
}

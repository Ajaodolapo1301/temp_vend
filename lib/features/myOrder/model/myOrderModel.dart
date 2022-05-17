//
//
//
// import 'package:primhex/features/sendPackage/model/deliveryType.dart';
// import 'package:primhex/features/sendPackage/model/delivery_time.dart';
// import 'package:primhex/features/sendPackage/model/packageSize.dart';
//
// class MyOrderModel {
//   String id;
//   int senderId;
//   String tracking_id;
//   DeliveryType deliveryType;
//   DeliveryTime deliveryTime;
//   SenderInfo senderInfo;
//   ReceiverInfo receiverInfo;
//   Payment payment;
//   PackageSize packageSize;
//   String itemDescription;
//   String additionalInfo;
//   String pickupType;
//     // RiderInfo riderInfo;
//   MyOrderModel(
//       {this.id,
//         this.senderId,
//         this.tracking_id,
//         this.deliveryType,
//         this.deliveryTime,
//         this.senderInfo,
//         this.receiverInfo,
//         this.packageSize,
//         this.itemDescription,
//         this.additionalInfo,
//         // this.riderInfo,
//         this.payment,
//         this.pickupType});
//
//   MyOrderModel.fromJson(Map<String, dynamic> json) {
//     // if(json["rider_info"] == []){
//     //   riderInfo = null;
//     // }else if(json["rider_info"] == null){
//     //   riderInfo = null;
//     // }else
//     //   if(json["rider_info"]["full_name"] != null ){
//     //   riderInfo = RiderInfo.fromJson(json['rider_info']);
//     // }
//
//     id = json['id'];
//     senderId = json['sender_id'];
//     deliveryType = json['delivery_type'] != null
//         ? new DeliveryType.fromJson(json['delivery_type'])
//         : null;
//
//     payment = json['payment'] != null
//         ? new Payment.fromJson(json['payment'])
//         : null;
//
//     deliveryTime = json['delivery_time'] != null
//         ? new DeliveryTime.fromJson(json['delivery_time'])
//         : null;
//     senderInfo = json['sender_info'] != null
//         ? new SenderInfo.fromJson(json['sender_info'])
//         : null;
//     receiverInfo = json['receiver_info'] != null
//         ? new ReceiverInfo.fromJson(json['receiver_info'])
//         : null;
//     packageSize = json['package-size'] != null
//         ? new PackageSize.fromJson(json['package-size'])
//         : null;
//
//
//           // riderInfo = json['rider_info'] == null ||  json['rider_info'] == [] ? null
//           //     : new RiderInfo.fromJson(json['rider_info']);
//
//
//     itemDescription = json['item_description'] ?? "";
//     additionalInfo = json['additional_info'] ?? "";
//     pickupType = json['pickup_type'] ?? "";
//     tracking_id = json["tracking_id"] ?? "";
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['sender_id'] = this.senderId;
//     if (this.deliveryType != null) {
//       data['delivery_type'] = this.deliveryType.toJson();
//     }
//     if (this.deliveryTime != null) {
//       data['delivery_time'] = this.deliveryTime.toJson();
//     }
//     if (this.senderInfo != null) {
//       data['sender_info'] = this.senderInfo.toJson();
//     }
//     if (this.receiverInfo != null) {
//       data['receiver_info'] = this.receiverInfo.toJson();
//     }
//     // if (this.riderInfo != null) {
//     //   data['rider_info'] = this.riderInfo.toJson();
//     // }
//     if (this.packageSize != null) {
//       data['package-size'] = this.packageSize.toJson();
//     }
//     data['item_description'] = this.itemDescription;
//     data['additional_info'] = this.additionalInfo;
//     data['pickup_type'] = this.pickupType;
//     return data;
//   }
// }
//
//
// class SenderInfo {
//   String senderName;
//   String senderPhoneNumber;
//   String pickupLong;
//   String pickupLat;
//   String pickupAddress;
//
//   SenderInfo(
//       {this.senderName,
//         this.senderPhoneNumber,
//         this.pickupLong,
//         this.pickupLat,
//         this.pickupAddress});
//
//   SenderInfo.fromJson(Map<String, dynamic> json) {
//     senderName = json['sender_name'];
//     senderPhoneNumber = json['sender_phone_number'];
//     pickupLong = json['pickup_long'];
//     pickupLat = json['pickup_lat'];
//     pickupAddress = json['pickup_address'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['sender_name'] = this.senderName;
//     data['sender_phone_number'] = this.senderPhoneNumber;
//     data['pickup_long'] = this.pickupLong;
//     data['pickup_lat'] = this.pickupLat;
//     data['pickup_address'] = this.pickupAddress;
//     return data;
//   }
// }
//
// class ReceiverInfo {
//   String receiverName;
//   String receiverPhoneNumber;
//   String destinationLong;
//   String destinationLat;
//   String destinationAddress;
//
//   ReceiverInfo(
//       {this.receiverName,
//         this.receiverPhoneNumber,
//         this.destinationLong,
//         this.destinationLat,
//         this.destinationAddress});
//
//   ReceiverInfo.fromJson(Map<String, dynamic> json) {
//     receiverName = json['receiver_name'];
//     receiverPhoneNumber = json['receiver_phone_number'];
//     destinationLong = json['destination_long'];
//     destinationLat = json['destination_lat'];
//     destinationAddress = json['destination_address'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['receiver_name'] = this.receiverName;
//     data['receiver_phone_number'] = this.receiverPhoneNumber;
//     data['destination_long'] = this.destinationLong;
//     data['destination_lat'] = this.destinationLat;
//     data['destination_address'] = this.destinationAddress;
//     return data;
//   }
// }
//
// class Payment {
//   String method;
//   int status;
//   String referenceNumber;
//   int price;
//
//   Payment({this.method, this.status, this.referenceNumber, this.price});
//
//   Payment.fromJson(Map<String, dynamic> json) {
//     method = json['method'];
//     status = json['status'];
//     referenceNumber = json['reference_number'];
//     price = json['price'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['method'] = this.method;
//     data['status'] = this.status;
//     data['reference_number'] = this.referenceNumber;
//     data['price'] = this.price;
//     return data;
//   }
// }
//
//
// class RiderInfo {
//   int id;
//   String full_name;
//   String phone;
//   String email;
//   String profile_image_url;
//   String fcm_token;
//
//   RiderInfo({this.full_name, this.phone, this.email, this.profile_image_url, this.id, this.fcm_token});
//
//   RiderInfo.fromJson(Map<String, dynamic> json) {
//     id = json["id"];
//     full_name = json['full_name'];
//     phone = json['phone'];
//     email = json['email'];
//     profile_image_url = json['profile_image_url'];
//     fcm_token = json["fcm_token"];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data["id"] = this.id;
//     data['full_name'] = this.full_name;
//     data['profile_image_url'] = this.profile_image_url;
//     data['phone'] = this.phone;
//     data['email'] = this.email;
//     data["fcm_token"] = this.fcm_token;
//     return data;
//   }
// }
//

class MyOrderModel {
  String? id;
  String? trackingId;
  int? senderId;
  DeliveryType? deliveryType;
  DeliveryTime? deliveryTime;
  SenderInfo? senderInfo;
  ReceiverInfo? receiverInfo;
  PackageSize? packageSize;
  String? itemDescription;
  String? additionalInfo;
  String? pickupType;
  // Null pickupTime;
  String? status;
  Payment? payment;
  String? createdAt;
  // Null riderPickupTime;
  // Null pickupTimeF;
  int? rating;
  String? pickupAddress;
  String? destinationAddress;
  // Null deliveredAt;
  // Null deliveredAtF;
  String? price;
  RiderInfo? riderInfo;

  MyOrderModel(
      {this.id,
      this.trackingId,
      this.senderId,
      this.deliveryType,
      this.deliveryTime,
      this.senderInfo,
      this.receiverInfo,
      this.packageSize,
      this.itemDescription,
      this.additionalInfo,
      this.pickupType,
      // this.pickupTime,
      this.status,
      this.payment,
      this.createdAt,
      // this.riderPickupTime,
      // this.pickupTimeF,
      this.rating,
      this.pickupAddress,
      this.destinationAddress,
      // this.deliveredAt,
      // this.deliveredAtF,
      this.price,
      this.riderInfo});

  MyOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trackingId = json['tracking_id'];
    senderId = json['sender_id'];
    deliveryType = json['delivery_type'] != null
        ? DeliveryType.fromJson(json['delivery_type'])
        : null;
    deliveryTime = json['delivery_time'] != null
        ? DeliveryTime.fromJson(json['delivery_time'])
        : null;
    senderInfo = json['sender_info'] != null
        ? SenderInfo.fromJson(json['sender_info'])
        : null;
    receiverInfo = json['receiver_info'] != null
        ? ReceiverInfo.fromJson(json['receiver_info'])
        : null;
    packageSize = json['package-size'] != null
        ? PackageSize.fromJson(json['package-size'])
        : null;
    itemDescription = json['item_description'];
    additionalInfo = json['additional_info'];
    pickupType = json['pickup_type'];
    // pickupTime = json['pickup_time'];
    status = json['status'];
    payment =
        json['payment'] != null ? Payment.fromJson(json['payment']) : null;
    createdAt = json['created_at'];
    // riderPickupTime = json['rider_pickup_time'];
    // pickupTimeF = json['pickup_time_f'];
    rating = json['rating'];
    pickupAddress = json['pickup_address'];
    destinationAddress = json['destination_address'];
    // deliveredAt = json['delivered_at'];
    // deliveredAtF = json['delivered_at_f'];
    price = json['price'];
    riderInfo = json['rider_info'] != null
        ? RiderInfo.fromJson(json['rider_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tracking_id'] = trackingId;
    data['sender_id'] = senderId;
    if (deliveryType != null) {
      data['delivery_type'] = deliveryType!.toJson();
    }
    if (deliveryTime != null) {
      data['delivery_time'] = deliveryTime!.toJson();
    }
    if (senderInfo != null) {
      data['sender_info'] = senderInfo!.toJson();
    }
    if (receiverInfo != null) {
      data['receiver_info'] = receiverInfo!.toJson();
    }
    if (packageSize != null) {
      data['package-size'] = packageSize!.toJson();
    }
    data['item_description'] = itemDescription;
    data['additional_info'] = additionalInfo;
    data['pickup_type'] = pickupType;
    // data['pickup_time'] = this.pickupTime;
    data['status'] = status;
    if (payment != null) {
      data['payment'] = payment!.toJson();
    }
    data['created_at'] = createdAt;
    // data['rider_pickup_time'] = this.riderPickupTime;
    // data['pickup_time_f'] = this.pickupTimeF;
    data['rating'] = rating;
    data['pickup_address'] = pickupAddress;
    data['destination_address'] = destinationAddress;
    // data['delivered_at'] = this.deliveredAt;
    // data['delivered_at_f'] = this.deliveredAtF;
    data['price'] = price;
    if (riderInfo != null) {
      data['rider_info'] = riderInfo!.toJson();
    }
    return data;
  }
}

class DeliveryType {
  int? id;
  String? name;
  String? imageUrl;

  DeliveryType({this.id, this.name, this.imageUrl});

  DeliveryType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image_url'] = imageUrl;
    return data;
  }
}

class DeliveryTime {
  int? id;
  String? name;
  String? description;

  DeliveryTime({this.id, this.name, this.description});

  DeliveryTime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}

class SenderInfo {
  String? senderName;
  String? senderPhoneNumber;
  String? pickupLong;
  String? pickupLat;
  String? pickupAddress;
  String? pickupFormattedAddress;
  String? fcmToken;

  SenderInfo(
      {this.senderName,
      this.senderPhoneNumber,
      this.pickupLong,
      this.pickupLat,
      this.pickupAddress,
      this.pickupFormattedAddress,
      this.fcmToken});

  SenderInfo.fromJson(Map<String, dynamic> json) {
    senderName = json['sender_name'];
    senderPhoneNumber = json['sender_phone_number'];
    pickupLong = json['pickup_long'];
    pickupLat = json['pickup_lat'];
    pickupAddress = json['pickup_address'];
    pickupFormattedAddress = json['pickup_formatted_address'];
    fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sender_name'] = senderName;
    data['sender_phone_number'] = senderPhoneNumber;
    data['pickup_long'] = pickupLong;
    data['pickup_lat'] = pickupLat;
    data['pickup_address'] = pickupAddress;
    data['pickup_formatted_address'] = pickupFormattedAddress;
    data['fcm_token'] = fcmToken;
    return data;
  }
}

class ReceiverInfo {
  String? receiverName;
  String? receiverPhoneNumber;
  String? destinationLong;
  String? destinationLat;
  String? destinationAddress;
  String? destinationFormattedAddress;

  ReceiverInfo(
      {this.receiverName,
      this.receiverPhoneNumber,
      this.destinationLong,
      this.destinationLat,
      this.destinationAddress,
      this.destinationFormattedAddress});

  ReceiverInfo.fromJson(Map<String, dynamic> json) {
    receiverName = json['receiver_name'];
    receiverPhoneNumber = json['receiver_phone_number'];
    destinationLong = json['destination_long'];
    destinationLat = json['destination_lat'];
    destinationAddress = json['destination_address'];
    destinationFormattedAddress = json['destination_formatted_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['receiver_name'] = receiverName;
    data['receiver_phone_number'] = receiverPhoneNumber;
    data['destination_long'] = destinationLong;
    data['destination_lat'] = destinationLat;
    data['destination_address'] = destinationAddress;
    data['destination_formatted_address'] = destinationFormattedAddress;
    return data;
  }
}

class PackageSize {
  int? id;
  String? title;
  String? imageUrl;

  PackageSize({this.id, this.title, this.imageUrl});

  PackageSize.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image_url'] = imageUrl;
    return data;
  }
}

class Payment {
  String? method;
  int? status;
  String? referenceNumber;
  String? price;

  Payment({this.method, this.status, this.referenceNumber, this.price});

  Payment.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    status = json['status'];
    referenceNumber = json['reference_number'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['method'] = method;
    data['status'] = status;
    data['reference_number'] = referenceNumber;
    data['price'] = price;
    return data;
  }
}

class RiderInfo {
  int? id;
  String? fullName;
  String? phone;
  String? email;
  String? profileImageUrl;
  String? fcmToken;
  String? plateNo;

  RiderInfo(
      {this.id,
      this.fullName,
      this.phone,
      this.email,
      this.profileImageUrl,
      this.plateNo,
      this.fcmToken});

  RiderInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    phone = json['phone'];
    email = json['email'];
    profileImageUrl = json['profile_image_url'];
    fcmToken = json['fcm_token'];
    plateNo = json["plate_no"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['phone'] = phone;
    data['email'] = email;
    data['profile_image_url'] = profileImageUrl;
    data['fcm_token'] = fcmToken;
    return data;
  }
}

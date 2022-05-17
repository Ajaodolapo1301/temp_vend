// class TrackOrderModel {
//   String id;
//   int senderId;
//   DeliveryType deliveryType;
//   DeliveryTime deliveryTime;
//   SenderInfo senderInfo;
//   ReceiverInfo receiverInfo;
//   PackageSize packageSize;
//   String itemDescription;
//   String additionalInfo;
//   String pickupType;
//   String status;
//   Payment payment;
//   String createdAt;
//   String pickupTime;
//   // List<dynamic> riderInfo;
//   // List<dynamic> riderCoordinate;
//
//   TrackOrderModel(
//       {this.id,
//         this.senderId,
//         this.deliveryType,
//         this.deliveryTime,
//         this.senderInfo,
//         this.receiverInfo,
//         this.packageSize,
//         this.itemDescription,
//         this.additionalInfo,
//         this.pickupType,
//         this.status,
//         this.payment,
//         this.createdAt,
//         this.pickupTime,
//         // this.riderInfo,
//         // this.riderCoordinate
//
//       });
//
//   TrackOrderModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     senderId = json['sender_id'];
//     deliveryType = json['delivery_type'] != null
//         ? new DeliveryType.fromJson(json['delivery_type'])
//         : null;
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
//     itemDescription = json['item_description'];
//     additionalInfo = json['additional_info'];
//     pickupType = json['pickup_type'];
//     status = json['status'];
//     payment =
//     json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
//     createdAt = json['created_at'];
//     pickupTime = json['pickup_time'];
//     // if (json['rider_info'] != null) {
//     //   riderInfo = <dynamic>[];
//     //   json['rider_info'].forEach((v) {
//     //     riderInfo.add(new dynamic.fromJson(v));
//     //   });
//     // }
//     // if (json['rider_coordinate'] != null) {
//     //   riderCoordinate = new List<Null>();
//     //   json['rider_coordinate'].forEach((v) {
//     //     riderCoordinate.add(new Null.fromJson(v));
//     //   });
//     // }
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
//     if (this.packageSize != null) {
//       data['package-size'] = this.packageSize.toJson();
//     }
//     data['item_description'] = this.itemDescription;
//     data['additional_info'] = this.additionalInfo;
//     data['pickup_type'] = this.pickupType;
//     data['status'] = this.status;
//     if (this.payment != null) {
//       data['payment'] = this.payment.toJson();
//     }
//     data['created_at'] = this.createdAt;
//     data['pickup_time'] = this.pickupTime;
//     // if (this.riderInfo != null) {
//     //   data['rider_info'] = this.riderInfo.map((v) => v.toJson()).toList();
//     // }
//   //   if (this.riderCoordinate != null) {
//   //     data['rider_coordinate'] =
//   //         this.riderCoordinate.map((v) => v.toJson()).toList();
//   //   }
//   //   return data;
//   }
// }
//
// class DeliveryType {
//   int id;
//   int minWeight;
//   int maxWeight;
//   int status;
//   int priceEffect;
//   String imageUrl;
//
//   DeliveryType(
//       {this.id,
//         this.minWeight,
//         this.maxWeight,
//         this.status,
//         this.priceEffect,
//         this.imageUrl});
//
//   DeliveryType.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     minWeight = json['min_weight'];
//     maxWeight = json['max_weight'];
//     status = json['status'];
//     priceEffect = json['price_effect'];
//     imageUrl = json['image_url'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['min_weight'] = this.minWeight;
//     data['max_weight'] = this.maxWeight;
//     data['status'] = this.status;
//     data['price_effect'] = this.priceEffect;
//     data['image_url'] = this.imageUrl;
//     return data;
//   }
// }
//
// class DeliveryTime {
//   int id;
//   String name;
//   String description;
//   int priceEffect;
//
//   DeliveryTime({this.id, this.name, this.description, this.priceEffect});
//
//   DeliveryTime.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     description = json['description'];
//     priceEffect = json['price_effect'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     data['price_effect'] = this.priceEffect;
//     return data;
//   }
// }
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
//   Null receiverPhoneNumber;
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
// class PackageSize {
//   int id;
//   String title;
//   String weightUnit;
//   int minWeight;
//   int maxWeight;
//   String range;
//   String imageUrl;
//   int status;
//   int priceEffect;
//
//   PackageSize(
//       {this.id,
//         this.title,
//         this.weightUnit,
//         this.minWeight,
//         this.maxWeight,
//         this.range,
//         this.imageUrl,
//         this.status,
//         this.priceEffect});
//
//   PackageSize.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     weightUnit = json['weight_unit'];
//     minWeight = json['min_weight'];
//     maxWeight = json['max_weight'];
//     range = json['range'];
//     imageUrl = json['image_url'];
//     status = json['status'];
//     priceEffect = json['price_effect'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['weight_unit'] = this.weightUnit;
//     data['min_weight'] = this.minWeight;
//     data['max_weight'] = this.maxWeight;
//     data['range'] = this.range;
//     data['image_url'] = this.imageUrl;
//     data['status'] = this.status;
//     data['price_effect'] = this.priceEffect;
//     return data;
//   }
// }
//
// class Payment {
//   String method;
//   int status;
//   String referenceNumber;
//
//   Payment({this.method, this.status, this.referenceNumber});
//
//   Payment.fromJson(Map<String, dynamic> json) {
//     method = json['method'];
//     status = json['status'];
//     referenceNumber = json['reference_number'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['method'] = this.method;
//     data['status'] = this.status;
//     data['reference_number'] = this.referenceNumber;
//     return data;
//   }
// }

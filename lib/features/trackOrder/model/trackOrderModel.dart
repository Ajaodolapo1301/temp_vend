class TrackOrderModel {
  String? id;
  int? senderId;
  DeliveryType? deliveryType;
  DeliveryTime? deliveryTime;
  SenderInfo? senderInfo;
  ReceiverInfo? receiverInfo;
  PackageSize? packageSize;
  String? itemDescription;
  String? additionalInfo;
  String? pickupType;
  String? status;
  Payment? payment;
  num? progress;
  // Null createdAt;
  // Null pickupTime;
  // List<Null> riderInfo;
  RiderCoordinate? riderCoordinate;
  String? eta;

  TrackOrderModel(
      {this.id,
      this.senderId,
      this.deliveryType,
      this.deliveryTime,
      this.senderInfo,
      this.receiverInfo,
      this.packageSize,
      this.itemDescription,
      this.additionalInfo,
      this.pickupType,
      this.status,
      this.payment,
      this.progress,
      // this.createdAt,
      // this.pickupTime,
      // this.riderInfo,
      this.riderCoordinate,
      this.eta});

  TrackOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    status = json['status'];
    payment =
        json['payment'] != null ? Payment.fromJson(json['payment']) : null;
    progress = json["progress"];
    riderCoordinate = json['rider_coordinate'] != null
        ? RiderCoordinate.fromJson(json['rider_coordinate'])
        : null;
    // createdAt = json['created_at'];
    // pickupTime = json['pickup_time'];
    // if (json['rider_info'] != null) {
    //   riderInfo = new List<Null>();
    //   json['rider_info'].forEach((v) {
    //     riderInfo.add(new Null.fromJson(v));
    //   });
    // }

    eta = json['eta'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id;
  //   data['sender_id'] = senderId;
  //   if (deliveryType != null) {
  //     data['delivery_type'] = deliveryType!.toJson();
  //   }
  //   if (deliveryTime != null) {
  //     data['delivery_time'] = deliveryTime!.toJson();
  //   }
  //   if (senderInfo != null) {
  //     data['sender_info'] = senderInfo!.toJson();
  //   }
  //   if (receiverInfo != null) {
  //     data['receiver_info'] = receiverInfo!.toJson();
  //   }
  //   if (packageSize != null) {
  //     data['package-size'] = packageSize!.toJson();
  //   }
  //   data['item_description'] = itemDescription;
  //   data['additional_info'] = additionalInfo;
  //   data['pickup_type'] = pickupType;
  //   data['status'] = status;
  //   if (riderCoordinate != null) {
  //     data['rider_coordinate'] = riderCoordinate!.toJson();
  //   }
  // //   if (this.payment != null) {
  // //     data['payment'] = this.payment.toJson();
  // //   }
  // //   data['created_at'] = this.createdAt;
  // //   data['pickup_time'] = this.pickupTime;
  // //   if (this.riderInfo != null) {
  // //     data['rider_info'] = this.riderInfo.map((v) => v.toJson()).toList();
  // //   }
  // //   if (this.riderCoordinate != null) {
  // //     data['rider_coordinate'] =
  // //         this.riderCoordinate.map((v) => v.toJson()).toList();
  // //   }
  // //   data['eta'] = this.eta;
  // //   return data;
  // }
}

class DeliveryType {
  int? id;
  String? name;
  int? minWeight;
  int? maxWeight;
  int? status;
  String? priceEffect;
  String? imageUrl;

  DeliveryType(
      {this.id,
      this.name,
      this.minWeight,
      this.maxWeight,
      this.status,
      this.priceEffect,
      this.imageUrl});

  DeliveryType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    minWeight = json['min_weight'];
    maxWeight = json['max_weight'];
    status = json['status'];
    priceEffect = json['price_effect'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['min_weight'] = minWeight;
    data['max_weight'] = maxWeight;
    data['status'] = status;
    data['price_effect'] = priceEffect;
    data['image_url'] = imageUrl;
    return data;
  }
}

class DeliveryTime {
  int? id;
  String? name;
  String? description;
  int? priceEffect;

  DeliveryTime({this.id, this.name, this.description, this.priceEffect});

  DeliveryTime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    priceEffect = json['price_effect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price_effect'] = priceEffect;
    return data;
  }
}

class SenderInfo {
  String? senderName;
  String? senderPhoneNumber;
  String? pickupLong;
  String? pickupLat;
  String? pickupAddress;

  SenderInfo(
      {this.senderName,
      this.senderPhoneNumber,
      this.pickupLong,
      this.pickupLat,
      this.pickupAddress});

  SenderInfo.fromJson(Map<String, dynamic> json) {
    senderName = json['sender_name'];
    senderPhoneNumber = json['sender_phone_number'];
    pickupLong = json['pickup_long'];
    pickupLat = json['pickup_lat'];
    pickupAddress = json['pickup_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sender_name'] = senderName;
    data['sender_phone_number'] = senderPhoneNumber;
    data['pickup_long'] = pickupLong;
    data['pickup_lat'] = pickupLat;
    data['pickup_address'] = pickupAddress;
    return data;
  }
}

class ReceiverInfo {
  String? receiverName;
  String? receiverPhoneNumber;
  String? destinationLong;
  String? destinationLat;
  String? destinationAddress;

  ReceiverInfo(
      {this.receiverName,
      this.receiverPhoneNumber,
      this.destinationLong,
      this.destinationLat,
      this.destinationAddress});

  ReceiverInfo.fromJson(Map<String, dynamic> json) {
    receiverName = json['receiver_name'];
    receiverPhoneNumber = json['receiver_phone_number'];
    destinationLong = json['destination_long'];
    destinationLat = json['destination_lat'];
    destinationAddress = json['destination_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['receiver_name'] = receiverName;
    data['receiver_phone_number'] = receiverPhoneNumber;
    data['destination_long'] = destinationLong;
    data['destination_lat'] = destinationLat;
    data['destination_address'] = destinationAddress;
    return data;
  }
}

class PackageSize {
  int? id;
  String? title;
  String? weightUnit;
  int? minWeight;
  int? maxWeight;
  String? range;
  String? imageUrl;
  int? status;
  String? priceEffect;

  PackageSize(
      {this.id,
      this.title,
      this.weightUnit,
      this.minWeight,
      this.maxWeight,
      this.range,
      this.imageUrl,
      this.status,
      this.priceEffect});

  PackageSize.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    weightUnit = json['weight_unit'];
    minWeight = json['min_weight'];
    maxWeight = json['max_weight'];
    range = json['range'];
    imageUrl = json['image_url'];
    status = json['status'];
    priceEffect = json['price_effect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['weight_unit'] = weightUnit;
    data['min_weight'] = minWeight;
    data['max_weight'] = maxWeight;
    data['range'] = range;
    data['image_url'] = imageUrl;
    data['status'] = status;
    data['price_effect'] = priceEffect;
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

class RiderCoordinate {
  String? riderLat;
  String? riderLong;

  RiderCoordinate({this.riderLat, this.riderLong});

  RiderCoordinate.fromJson(Map<String, dynamic> json) {
    riderLat = json['rider_lat'];
    riderLong = json['rider_long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rider_lat'] = riderLat;
    data['rider_long'] = riderLong;
    return data;
  }
}

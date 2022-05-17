class CreateResponse {
  String? id;
  int? senderId;
  String? trackingId;
  String? createdAt;
  String? referenceNumber;
  Price? price;

  CreateResponse(
      {this.id,
      this.senderId,
      this.trackingId,
      this.createdAt,
      this.referenceNumber,
      this.price});

  CreateResponse.fromJson(Map<String, dynamic> json) {
    print("json$json");
    id = json['id'];
    senderId = json['sender_id'];
    trackingId = json['tracking_id'];
    createdAt = json['created_at'];
    referenceNumber = json['reference_number'].toString();
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sender_id'] = senderId;
    data['tracking_id'] = trackingId;
    data['created_at'] = createdAt;
    data['reference_number'] = referenceNumber;
    if (price != null) {
      data['price'] = price!.toJson();
    }
    return data;
  }
}

class Price {
  num? shippingFee;
  Coupon? coupon;
  Bonus? bonus;
  num? total;

  Price({this.shippingFee, this.coupon, this.bonus, this.total});

  Price.fromJson(Map<String, dynamic> json) {
    shippingFee = json['shipping_fee'];
    coupon = coupon =
        json['coupon'] != null ? Coupon.fromJson(json['coupon']) : null;
    bonus = json['bonus'] != null ? Bonus.fromJson(json['bonus']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shipping_fee'] = shippingFee;
    data['coupon'] = coupon;
    if (bonus != null) {
      data['bonus'] = bonus!.toJson();
    }
    data['total'] = total;
    return data;
  }
}

class Bonus {
  String? amount;
  String? calculatedBy;
  String? priceEffect;

  Bonus({this.amount, this.calculatedBy, this.priceEffect});

  Bonus.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    calculatedBy = json['calculated_by'];
    priceEffect = json['price_effect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['calculated_by'] = calculatedBy;
    data['price_effect'] = priceEffect;
    return data;
  }
}

// class CreateResponse {
//   String id;
//   int senderId;
//   String trackingId;
//   String createdAt;
//   String referenceNumber;
//   Price price;
//
//   CreateResponse(
//       {this.id,
//         this.senderId,
//         this.trackingId,
//         this.createdAt,
//         this.referenceNumber,
//         this.price});
//
//   CreateResponse.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     senderId = json['sender_id'];
//     trackingId = json['tracking_id'];
//     createdAt = json['created_at'];
//     referenceNumber = json['reference_number'];
//     price = json['price'] != null ? new Price.fromJson(json['price']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['sender_id'] = this.senderId;
//     data['tracking_id'] = this.trackingId;
//     data['created_at'] = this.createdAt;
//     data['reference_number'] = this.referenceNumber;
//     if (this.price != null) {
//       data['price'] = this.price.toJson();
//     }
//     return data;
//   }
// }
//
// class Price {
//   num shippingFee;
//   Coupon coupon;
//   Bonus bonus;
//   num total;
//
//   Price({this.shippingFee, this.coupon, this.bonus, this.total});
//
//   Price.fromJson(Map<String, dynamic> json) {
//     shippingFee = json['shipping_fee'];
//     coupon = json['coupon'] != null ? new Coupon.fromJson(json['coupon']) : null;
//     bonus = json['bonus'] != null ? new Bonus.fromJson(json['bonus']) : null;
//     total = json['total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['shipping_fee'] = this.shippingFee;
//     if (this.coupon != null) {
//       data['coupon'] = this.coupon.toJson();
//     }
//     data['bonus'] = this.bonus;
//     data['total'] = this.total;
//     return data;
//   }
// }
//
class Coupon {
  num? amount;
  String? calculatedBy;
  num? priceEffect;

  Coupon({this.amount, this.calculatedBy, this.priceEffect});

  Coupon.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    calculatedBy = json['calculated_by'];
    priceEffect = json['price_effect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['calculated_by'] = calculatedBy;
    data['price_effect'] = priceEffect;
    return data;
  }
}
//
// class Bonus {
//   String amount;
//   String calculatedBy;
//   String priceEffect;
//
//   Bonus({this.amount, this.calculatedBy, this.priceEffect});
//
//   Bonus.fromJson(Map<String, dynamic> json) {
//     amount = json['amount'];
//     calculatedBy = json['calculated_by'];
//     priceEffect = json['price_effect'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['amount'] = this.amount;
//     data['calculated_by'] = this.calculatedBy;
//     data['price_effect'] = this.priceEffect;
//     return data;
//   }
// }

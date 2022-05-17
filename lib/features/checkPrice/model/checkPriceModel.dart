class CheckPriceModel {
  num? shippingFee;
  Null? coupon;
  Bonus? bonus;
  num? total;

  CheckPriceModel({this.shippingFee, this.coupon, this.bonus, this.total});

  CheckPriceModel.fromJson(Map<String, dynamic> json) {
    shippingFee = json['shipping_fee'];
    coupon = json['coupon'];
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
  num? amount;
  String? calculatedBy;
  num? priceEffect;

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

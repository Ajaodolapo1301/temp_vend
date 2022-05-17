class InitialModel {
  List<String>? pickUp;
  List<PackageSize>? packageSize;
  List<DeliveryType>? deliveryType;
  List<DeliveryTime>? deliveryTime;
  List<String>? paymentPoint;
  List<String>? paymentGateway;
  List<BrandColor>? brandColor;

  InitialModel(
      {this.pickUp,
      this.packageSize,
      this.deliveryType,
      this.deliveryTime,
      this.paymentPoint,
      this.paymentGateway,
      this.brandColor});

  InitialModel.fromJson(Map<String, dynamic> json) {
    pickUp = json['pick_up'].cast<String>();
    if (json['package_size'] != null) {
      packageSize = <PackageSize>[];
      json['package_size'].forEach((v) {
        packageSize!.add(PackageSize.fromJson(v));
      });
    }
    if (json['delivery_type'] != null) {
      deliveryType = <DeliveryType>[];
      json['delivery_type'].forEach((v) {
        deliveryType!.add(DeliveryType.fromJson(v));
      });
    }
    if (json['delivery_time'] != null) {
      deliveryTime = <DeliveryTime>[];
      json['delivery_time'].forEach((v) {
        deliveryTime!.add(DeliveryTime.fromJson(v));
      });
    }
    paymentPoint = json['payment_point'].cast<String>();
    // if (json['payment_gateway'] != null) {
    //   paymentGateway = <Null>[];
    //   json['payment_gateway'].forEach((v) {
    //     paymentGateway!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['brand_color'] != null) {
      brandColor = <BrandColor>[];
      json['brand_color'].forEach((v) {
        brandColor!.add(BrandColor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pick_up'] = pickUp;
    if (packageSize != null) {
      data['package_size'] = packageSize!.map((v) => v.toJson()).toList();
    }
    if (deliveryType != null) {
      data['delivery_type'] = deliveryType!.map((v) => v.toJson()).toList();
    }
    if (deliveryTime != null) {
      data['delivery_time'] = deliveryTime!.map((v) => v.toJson()).toList();
    }
    data['payment_point'] = paymentPoint;
    // if (this.paymentGateway != null) {
    //   data['payment_gateway'] =
    //       this.paymentGateway.map((v) => v.toJson()).toList();
    // }
    if (brandColor != null) {
      data['brand_color'] = brandColor!.map((v) => v.toJson()).toList();
    }
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
  String? deletedAt;

  DeliveryTime(
      {this.id, this.name, this.description, this.priceEffect, this.deletedAt});

  DeliveryTime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    priceEffect = json['price_effect'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price_effect'] = priceEffect;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class BrandColor {
  String? name;
  String? value;

  BrandColor({this.name, this.value});

  BrandColor.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}

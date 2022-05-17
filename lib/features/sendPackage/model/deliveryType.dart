import 'package:hive/hive.dart';

part 'deliveryType.g.dart';

@HiveType(typeId: 2)
class DeliveryType {
  @HiveField(0)
  var id;
  @HiveField(1)
  var minWeight;
  @HiveField(2)
  var maxWeight;
  @HiveField(3)
  var status;
  @HiveField(4)
  var priceEffect;
  @HiveField(5)
  String? imageUrl;
  @HiveField(6)
  String? name;

  DeliveryType(
      {this.id,
      this.minWeight,
      this.maxWeight,
      this.status,
      this.priceEffect,
      this.imageUrl,
      this.name});

  DeliveryType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    minWeight = json['min_weight'];
    maxWeight = json['max_weight'];
    status = json['status'];
    priceEffect = json['price_effect'];
    imageUrl = json['image_url'];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['min_weight'] = minWeight;
    data['max_weight'] = maxWeight;
    data['status'] = status;
    data['price_effect'] = priceEffect;
    data['image_url'] = imageUrl;
    data["name"] = name;
    return data;
  }
}

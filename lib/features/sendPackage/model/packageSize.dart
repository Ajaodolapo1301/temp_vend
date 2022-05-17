import 'package:hive/hive.dart';

part 'packageSize.g.dart';

@HiveType(typeId: 3)
class PackageSize {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? weightUnit;
  @HiveField(2)
  int? minWeight;
  @HiveField(3)
  int? maxWeight;
  @HiveField(4)
  String? range;
  @HiveField(5)
  String? imageUrl;
  @HiveField(6)
  int? status;
  @HiveField(7)
  String? priceEffect;
  @HiveField(8)
  int? id;
  PackageSize(
      {this.title,
      this.weightUnit,
      this.minWeight,
      this.maxWeight,
      this.range,
      this.imageUrl,
      this.status,
      this.priceEffect,
      this.id});

  PackageSize.fromJson(Map<String, dynamic> json) {
    id = json["id"];
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
    data['title'] = title;
    data['weight_unit'] = weightUnit;
    data['min_weight'] = minWeight;
    data['max_weight'] = maxWeight;
    data['range'] = range;
    data['image_url'] = imageUrl;
    data['status'] = status;
    data['price_effect'] = priceEffect;
    data["id"] = id;
    return data;
  }
}

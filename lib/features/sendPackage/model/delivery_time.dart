
import 'package:hive/hive.dart';
part 'delivery_time.g.dart';
@HiveType(typeId: 1)

class DeliveryTime {
  @HiveField(0)
  var id;
  @HiveField(1)
  var name;
  @HiveField(2)
  var description;
  @HiveField(3)
  var priceEffect;

  DeliveryTime({this.id, this.name, this.description, this.priceEffect});

  DeliveryTime.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    name = json['name'];
    description = json['description'];
    priceEffect = json['price_effect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price_effect'] = this.priceEffect;
    return data;
  }
}
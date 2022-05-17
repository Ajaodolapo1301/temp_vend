import 'package:hive/hive.dart';

part 'addressModel.g.dart';

@HiveType(typeId: 0)
class AddressModel extends HiveObject {
  @HiveField(0)
  double? latitude;

  @HiveField(1)
  double? longitude;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? title;

  @HiveField(4)
  Map<String, dynamic>? rawResponse;

  AddressModel(
      this.latitude, this.longitude, this.description, this.rawResponse);

  @override
  String toString() {
    return 'lat: $latitude, long: $longitude, desc: $description, raw: $rawResponse';
  }

  String getCommaString() {
    return '$latitude,$longitude';
  }

  AddressModel.frmJSON(dynamic jsonObject) {
    var latitude = jsonObject['latitude'];
    var longitude = jsonObject['longitude'];
    this.latitude = latitude is double ? latitude : double.parse(latitude);
    this.longitude = longitude is double ? longitude : double.parse(longitude);
    description = jsonObject['description'];
  }

  AddressModel.fromDb(dynamic jsonObject) {
    latitude = jsonObject['latitude'];
    longitude = jsonObject['longitude'];
    description = jsonObject['description'];

    title = jsonObject['title'];
    var checked = jsonObject['isChecked'];
    // this.isChecked = checked == null ? null : checked == 1 ? true : false;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
    };
    if (title != null && title!.isNotEmpty) {
      map['title'] = title;
    }

    // if (isChecked != null) {
    //   map['isChecked'] = isChecked ? 1 : 0;
    // }
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressModel &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          description == other.description;

  @override
  int get hashCode =>
      latitude.hashCode ^ longitude.hashCode ^ description.hashCode;
}

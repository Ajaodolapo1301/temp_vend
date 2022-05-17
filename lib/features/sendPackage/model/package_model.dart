import '../../../core/constants/textStyleConstants.dart';

class PackageModel {
  String? image;
  String? text;
  bool? selected;
  PackageModel({this.image, this.text, this.selected});

  static List<PackageModel> packageList = [
    PackageModel(
      selected: true,
      text: "< 1kg",
      image: "${imagePath}order/envelope.png",
    ),
    PackageModel(
      selected: false,
      text: "2kg - 5kg",
      image: "${imagePath}order/box.png",
    ),
    PackageModel(
      selected: false,
      text: "> 5kg",
      image: "${imagePath}order/bigBox.png",
    )
  ];

  static List<PackageModel> deliveryList = [
    PackageModel(
      selected: true,
      text: "Bike",
      image: "${imagePath}order/bike.png",
    ),
    PackageModel(
      selected: false,
      text: "Car",
      image: "${imagePath}order/car.png",
    ),
    PackageModel(
      selected: false,
      text: "Truck",
      image: "${imagePath}order/truck.png",
    )
  ];
}

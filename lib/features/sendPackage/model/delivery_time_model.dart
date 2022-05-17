class DeliveryTimeModel {
  String? mainText;
  String? text;
  bool? selected;
  DeliveryTimeModel({this.mainText, this.text, this.selected});

  static List<DeliveryTimeModel> deliveryTimeList = [
    DeliveryTimeModel(
        selected: true, text: "(1 -2 days)", mainText: "Standard Delivery"),
    DeliveryTimeModel(
        selected: true, text: "(Same day)", mainText: "Express Delivery"),
  ];
}

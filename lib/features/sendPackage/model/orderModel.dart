import '../../authentication/model/initialModel.dart';
import 'addressModel.dart';

class OrderPayloadModel {
  String? senderName;
  AddressModel? senderAddress;
  String? senderPhone;
  String? whatAreUSending;
  PackageSize? packageSize;
  DeliveryType? deliveryType;
  DeliveryTime? deliveryTime;
  DateTime? pickUpTime;
  String? pickUpType;
  String? receiverName;
  AddressModel? receiverAddress;
  String? receiverPhone;
  String? addInfo;

  OrderPayloadModel(
      {this.senderPhone,
      this.senderAddress,
      this.deliveryTime,
      this.deliveryType,
      this.packageSize,
      this.pickUpTime,
      this.senderName,
      this.whatAreUSending,
      this.receiverPhone,
      this.receiverAddress,
      this.receiverName,
      this.addInfo,
      this.pickUpType});
}

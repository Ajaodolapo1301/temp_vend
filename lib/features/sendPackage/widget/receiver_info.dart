import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../core/utils/widgets/custom_text_field.dart';
import '../model/orderModel.dart';
import '../pages/enter_address.dart';
import '../viewModel/sendPackageViewModel.dart';

class ReceiverInfo extends StatefulWidget {
  final int? processIndex;
  final Function(Map<String, dynamic> v)? onpress;
  Map? formField;
  final OrderPayloadModel? orderPayloadModel;
  ReceiverInfo(
      {Key? key,
      this.onpress,
      this.processIndex,
      this.formField,
      this.orderPayloadModel})
      : super(key: key);

  @override
  _ReceiverInfoState createState() => _ReceiverInfoState();
}

class _ReceiverInfoState extends State<ReceiverInfo>
    with AfterLayoutMixin<ReceiverInfo> {
  String? receiverName;
  String? receiverAddress;
  String? receiverPhone;
  String? receiverAddInfo;
  bool timeSelectedExpress = false;
  bool standard = true;
  int _processIndex = 0;
  bool scheduleLater = false;
  SendPackageViewModel? sendPackageViewModel;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _processIndex = widget.processIndex!;

    super.initState();
  }

  // TextEditingController _receiverAddress = TextEditingController();
  // TextEditingController receivername = TextEditingController();
  // TextEditingController receiverPhoneController = TextEditingController();
  // TextEditingController addInfo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    sendPackageViewModel = Provider.of<SendPackageViewModel>(context);
    // _receiverAddress.text = sendPackageViewModel.receiverAddress?.description;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                textEditingController: sendPackageViewModel?.receiverName,
                header: "Receiver’s Name",
                hint: "John Doe",
                type: FieldType.text,
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Name is Required";
                  }
                  receiverName = v;
                  return null;
                },
              ),
              CustomTextField(
                onTap: () async {
                  pushTo(
                      context,
                      EnterAddress(
                        fromReceiver: true,
                      ));
                },
                header: "Receiver’s Address",
                hint: "Input Address",
                type: FieldType.text,
                textEditingController:
                    sendPackageViewModel?.receiverAddressController,
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Address is Required";
                  }
                  receiverAddress = v;
                  return null;
                },
              ),
              CustomTextField(
                textEditingController:
                    sendPackageViewModel?.receiverPhoneController,
                header: "Receiver’s Phone Number",
                hint: "08065083711",
                type: FieldType.phone,
                textInputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Phone is Required";
                  }
                  receiverPhone = v;
                  return null;
                },
              ),
              Container(
                child: CustomTextField(
                  textEditingController: sendPackageViewModel?.addInfo,
                  header: "Additional Information",
                  hint: "Additional Information...",
                  maxLines: 10,
                  maxLength: 300,
                  minLines: 5,
                  type: FieldType.multiline,
                  onChanged: (v) {
                    setState(() {
                      receiverAddInfo = v;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 4.5 * SizeConfig.heightMultiplier,
              ),
              CustomButton(
                  text: "Next",
                  type: ButtonType.outlined,
                  textColor: Colors.white,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      OrderPayloadModel orderPayLoad = OrderPayloadModel(
                          receiverAddress:
                              sendPackageViewModel?.receiverAddress,
                          receiverName: receiverName,
                          receiverPhone: receiverPhone,
                          addInfo: receiverAddInfo,
                          senderName: widget.formField!["senderName"],
                          senderAddress: widget.formField!["senderAddress"],
                          senderPhone: widget.formField!["senderPhone"],
                          packageSize: widget.formField!["packageSize"],
                          deliveryTime: widget.formField!["deliveryTime"],
                          deliveryType: widget.formField!["deliveryType"],
                          whatAreUSending: widget.formField!["whatAreUSending"],
                          pickUpTime: widget.formField!["pickUpTime"],
                          pickUpType: widget.formField!["pickUpType"]);
                      // print(widget.formField);
                      //        print(orderPayLoad.senderName);
                      _processIndex++;
                      widget.onpress!(
                          {"index": _processIndex, "orderModel": orderPayLoad});
                    }
                  }),
              SizedBox(
                height: 4.5 * SizeConfig.heightMultiplier,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (widget.orderPayloadModel == null) {
      sendPackageViewModel?.receiverAddressController.text = "";
      sendPackageViewModel?.receiverPhoneController.text = "";
      sendPackageViewModel?.receiverName.text = "";

      sendPackageViewModel?.addInfo.text = "";
      // sendPackageViewModel.whatAreYouSending.text = "";

    }
  }
}

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/function/timePicker.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../core/utils/widgets/custom_text_field.dart';
import '../../authentication/model/initialModel.dart';
import '../../authentication/viewModel/loginState.dart';
import '../model/orderModel.dart';
import '../model/radioModel.dart';
import '../pages/enter_address.dart';
import '../viewModel/createOrderViewModel.dart';
import '../viewModel/sendPackageViewModel.dart';
import 'delivery_time.dart';
import 'delivery_type.dart';
import 'item_box.dart';
import 'radioWidget.dart';

class SenderWidget extends StatefulWidget {
  final int? processIndex;
  final Function(Map<String, dynamic> v)? onpress;
  final OrderPayloadModel? orderPayloadModel;
  final Map? indexes;
  const SenderWidget(
      {Key? key,
      this.processIndex,
      this.onpress,
      this.orderPayloadModel,
      this.indexes})
      : super(key: key);

  @override
  _SenderWidgetState createState() => _SenderWidgetState();
}

class _SenderWidgetState extends State<SenderWidget>
    with AutomaticKeepAliveClientMixin, AfterLayoutMixin<SenderWidget> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Pages pages = Pages.Order;
  bool timeSelectedExpress = false;
  bool standard = true;
  String? sendersName;
  String? senderAddress;
  String? senderPhone;
  String? senderSending;

  String? _setTime, _setDate;
  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);
  String? _hour, _minute, _time;
  DeliveryType? deliveryType;
  PackageSize? packageSize;
  DeliveryTime? deliveryTime;
  Map<String, dynamic>? formField = {};

  // int selectedDeliveryTimeIndex = 0;
  // // int selectedPackageSizeIndex = 0;
  // int selectedDeliveryTypeIndex = 0;
  // bool scheduleLater = false;
  // DateTime  toUTC;
  int _processIndex = 0;
  CreateOrderState? createOrderState;
  SendPackageViewModel? sendPackageViewModel;
  // TextEditingController _scheduleController = TextEditingController();

  TextEditingController senderNameController = TextEditingController();
  TextEditingController senderPhoneController = TextEditingController();
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  LoginState? loginState;
  OrderPayloadModel? orderPayloadModel;
  @override
  void dispose() {
    // _senderAddress.dispose();
    super.dispose();
  }

  @override
  void initState() {
    orderPayloadModel = widget.orderPayloadModel;
    _processIndex = widget.processIndex!;

    if (orderPayloadModel != null) {
      print("uuuuu${orderPayloadModel!.receiverAddress}");
      senderNameController.text = orderPayloadModel!.senderName!;
      // sendPackageViewModel.senderAddress.text = orderPayloadModel.senderAddress.description;
      senderPhoneController.text = orderPayloadModel!.senderPhone!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sendPackageViewModel =
        Provider.of<SendPackageViewModel>(context, listen: true);
    createOrderState = Provider.of<CreateOrderState>(
      context,
    );
    loginState = Provider.of<LoginState>(
      context,
    );
    sendPackageViewModel!.senderNameController.text =
        loginState!.user.fullName!;
    sendPackageViewModel!.senderPhoneController.text = loginState!.user.phone!;
    print(sendPackageViewModel!.scheduleLater);
    super.build(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CustomTextField(
                      header: "Sender’s Name",
                      hint: "John Doe",
                      textEditingController:
                          sendPackageViewModel!.senderNameController,
                      type: FieldType.text,
                      validator: (v) {
                        if (v!.isEmpty) {
                          //Todo validate first and last name
                          return "Name is Required";
                        }
                        sendersName = v;
                        return null;
                      },
                    ),
                    CustomTextField(
                      onTap: () async {
                        pushTo(context, const EnterAddress()).then((value) {
                          setState(() {
                            // _senderAddress.text =
                            //     sendPackageViewModel.currentAddress?.description;
                          });
                        });
                      },
                      textEditingController:
                          sendPackageViewModel?.senderAddress,
                      header: "Sender’s Address",
                      readOnly: true,
                      hint: "Input Address",
                      type: FieldType.text,
                      suffix: sendPackageViewModel!.busy
                          ? const CupertinoActivityIndicator()
                          : const Icon(Icons.keyboard_arrow_right_rounded),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Address is Required";
                        }
                        senderAddress = v;
                        return null;
                      },
                    ),
                    CustomTextField(
                      header: "Sender’s Phone Number",
                      hint: "08065083711",
                      textEditingController:
                          sendPackageViewModel?.senderPhoneController,
                      type: FieldType.phone,
                      textInputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Phone is Required";
                        }
                        senderPhone = v;
                        return null;
                      },
                    ),
                    CustomTextField(
                      textEditingController:
                          sendPackageViewModel?.whatAreYouSending,
                      header: "What are you sending",
                      hint: "Describe your package",
                      type: FieldType.text,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Field is Required";
                        }
                        senderSending = v;
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 1.0 * SizeConfig.heightMultiplier,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text("Package Size",
                        style: TextStyle(
                            color: kTitleTextfieldColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 1.7 * SizeConfig.textMultiplier)),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 14.6 * SizeConfig.heightMultiplier,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: createOrderState?.packageSize.length,
                        itemBuilder: (context, index) {
                          return ItemBox(
                              onTap: () {
                                setState(() {
                                  sendPackageViewModel
                                      ?.selectedPackageSizeIndex = index;
                                  sendPackageViewModel?.packageSize =
                                      createOrderState!.packageSize[
                                          sendPackageViewModel!
                                              .selectedPackageSizeIndex];
                                });
                              },
                              text: createOrderState!.packageSize[index].title,
                              image:
                                  createOrderState!.packageSize[index].imageUrl,
                              selected: sendPackageViewModel!
                                          .selectedPackageSizeIndex ==
                                      index
                                  ? true
                                  : false);
                        }),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.5 * SizeConfig.heightMultiplier,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Delivery Type",
                          style: TextStyle(
                              color: kTitleTextfieldColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 1.7 * SizeConfig.textMultiplier),
                        ),
                        const SizedBox(height: 8),
                        createOrderState!.deliveryType.isNotEmpty
                            ? SizedBox(
                                height: 6.4 * SizeConfig.heightMultiplier,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      createOrderState!.deliveryType.length,
                                  itemBuilder: (context, index) {
                                    return DeliveryTypeWidget(
                                        onTap: () {
                                          setState(() {
                                            sendPackageViewModel!
                                                    .selectedDeliveryTypeIndex =
                                                index;
                                            deliveryType = createOrderState!
                                                    .deliveryType[
                                                sendPackageViewModel!
                                                    .selectedDeliveryTypeIndex];
                                          });
                                        },
                                        text: createOrderState!
                                            .deliveryType[index].name,
                                        image: createOrderState!
                                            .deliveryType[index].imageUrl,
                                        selected: sendPackageViewModel!
                                                    .selectedDeliveryTypeIndex ==
                                                index
                                            ? true
                                            : false);
                                  },
                                ),
                              )
                            : Container()
                      ],
                    ),
                    SizedBox(
                      height: 2.5 * SizeConfig.heightMultiplier,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Delivery Time",
                          style: TextStyle(
                              color: kTitleTextfieldColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 1.7 * SizeConfig.textMultiplier),
                        ),
                        const SizedBox(height: 8),
                        createOrderState!.deliveryTime.isNotEmpty
                            ? Row(
                                children: createOrderState!.deliveryTime
                                    .asMap()
                                    .keys
                                    .toList()
                                    .map((index) {
                                  // deliveryTime  =  createOrderState.deliveryTime[0];

                                  return Expanded(
                                      child: DeliveryTimeWidget(
                                    onTap: () {
                                      setState(() {
                                        print(index);
                                        sendPackageViewModel!
                                            .selectedDeliveryTimeIndex = index;
                                        deliveryTime =
                                            createOrderState!.deliveryTime[
                                                sendPackageViewModel!
                                                    .selectedDeliveryTimeIndex];
                                      });
                                    },
                                    text: createOrderState!
                                        .deliveryTime[index].description,
                                    mainText: createOrderState!
                                        .deliveryTime[index].name,
                                    selected: sendPackageViewModel!
                                                .selectedDeliveryTimeIndex ==
                                            index
                                        ? true
                                        : false,
                                  ));
                                }).toList(),
                              )
                            : Container(),
                      ],
                    ),
                    SizedBox(
                      height: 2.5 * SizeConfig.heightMultiplier,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pick Up Time",
                          style: TextStyle(
                              color: kTitleTextfieldColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 1.7 * SizeConfig.textMultiplier),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        sendPackageViewModel!.scheduleLater =
                                            false;
                                        RadioModel.sampleData[0].isSelected =
                                            true;
                                        RadioModel.sampleData[1].isSelected =
                                            false;
                                      });
                                    },
                                    child: ColorSelectorItem(
                                      items: RadioModel.sampleData[0],
                                    ))),
                            const SizedBox(width: 8),
                            Expanded(
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        sendPackageViewModel!.scheduleLater =
                                            true;
                                        RadioModel.sampleData[1].isSelected =
                                            true;
                                        RadioModel.sampleData[0].isSelected =
                                            false;
                                      });
                                    },
                                    child: ColorSelectorItem(
                                      items: RadioModel.sampleData[1],
                                    ))),
                          ],
                        ),
                        sendPackageViewModel!.scheduleLater
                            ? CustomTextField(
                                readOnly: true,
                                prefix: const Icon(
                                  Icons.calendar_today_outlined,
                                  color: kTitleTextfieldColor,
                                ),
                                hint: "Select Date and Time",
                                textEditingController:
                                    sendPackageViewModel!.scheduleController,
                                onTap: () async {
                                  var date = await selectDate(context);
                                  if (date != null) {
                                    print(date);
                                    TimeOfDay time = await selectTime(context);
                                    if (time != null) {
                                      setState(() {
                                        sendPackageViewModel!
                                                .scheduleController.text =
                                            "${dateFormat.format(date)} - ${time.hour}:${time.minute} ${time.period}";
                                      });
                                      sendPackageViewModel!.toUTC = DateTime(
                                          date.year,
                                          date.month,
                                          date.day,
                                          time.hour,
                                          time.minute);
                                      // print("www$toUTC");
                                    }
                                  }
                                },
                              )
                            : const SizedBox()
                      ],
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
                            formField = {
                              "senderName": sendersName,
                              "senderAddress":
                                  sendPackageViewModel!.currentAddress,
                              "senderPhone": senderPhone,
                              "packageSize": packageSize ??
                                  createOrderState!.packageSize[0],
                              "deliveryTime": deliveryTime ??
                                  createOrderState!.deliveryTime[0],
                              "deliveryType": deliveryType ??
                                  createOrderState!.deliveryType[0],
                              "whatAreUSending": senderSending,
                              "pickUpTime": sendPackageViewModel!.toUTC,
                              "pickUpType": sendPackageViewModel!.scheduleLater
                                  ? RadioModel.sampleData[1].textToServer
                                  : RadioModel.sampleData[0].textToServer
                            };

                            setState(() {
                              _processIndex++;
                              widget.onpress!({
                                "index": _processIndex,
                                "orderModel": formField
                              });
                            });
                          }
                        }),
                    SizedBox(
                      height: 4.5 * SizeConfig.heightMultiplier,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // sendPackageViewModel.packageSize = createOrderState.packageSize[createOrderState.packageSize.indexWhere((b) =>
    // "${b.id}" == "${widget.orderPayloadModel.packageSize.id}")];
    createOrderState!.getDeliveryTime();
    createOrderState!.getDeliveryType();
    createOrderState!.getPackageSize();
    if (orderPayloadModel == null) {
      print("eee$orderPayloadModel");
      sendPackageViewModel!.senderAddress.text = "";
      sendPackageViewModel!.senderNameController.text = "";
      sendPackageViewModel!.senderPhoneController.text = "";
      sendPackageViewModel!.senderPhoneController.text = "";
      sendPackageViewModel!.whatAreYouSending.text = "";
      sendPackageViewModel!.selectedPackageSizeIndex = 0;
      sendPackageViewModel!.selectedDeliveryTypeIndex = 0;
      sendPackageViewModel!.selectedDeliveryTimeIndex = 0;
      sendPackageViewModel!.scheduleLater = false;
      sendPackageViewModel!.scheduleController.text = "";
      sendPackageViewModel!.toUTC = null;
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

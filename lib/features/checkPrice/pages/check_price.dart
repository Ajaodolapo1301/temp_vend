import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/preloader/preLoadr.dart';
import '../../../core/utils/function/bottom_sheet/bottom_sheet.dart';
import '../../../core/utils/function/snaks.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../core/utils/widgets/custom_text_field.dart';
import '../../authentication/model/initialModel.dart';
import '../../authentication/viewModel/loginState.dart';
import '../../sendPackage/model/orderModel.dart';
import '../../sendPackage/model/radioModel.dart';
import '../../sendPackage/pages/enter_address.dart';
import '../../sendPackage/viewModel/createOrderViewModel.dart';
import '../../sendPackage/viewModel/sendPackageViewModel.dart';
import '../../sendPackage/widget/delivery_time.dart';
import '../../sendPackage/widget/delivery_type.dart';
import '../../sendPackage/widget/item_box.dart';

class CheckPrice extends StatefulWidget {
  const CheckPrice({Key? key}) : super(key: key);

  @override
  _CheckPriceState createState() => _CheckPriceState();
}

class _CheckPriceState extends State<CheckPrice>
    with AfterLayoutMixin<CheckPrice> {
  int upperBound = 2;
  StepperType stepperType = StepperType.horizontal;
  int activeStep = 2;
  String? sendersName;
  String? senderAddress;
  String? senderPhone;
  String? senderSending;

  DeliveryType? deliveryType;
  PackageSize? packageSize;
  DeliveryTime? deliveryTime;

  String? receiverName;
  String? receiverAddress;
  String? receiverPhone;
  String? receiverAddInfo;
  bool timeSelectedExpress = false;
  bool standard = true;
  bool scheduleLater = false;
  String? scheduleDate;
  TextEditingController scheduleController = TextEditingController();

  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  List<RadioModel> sampleData = [];

  SendPackageViewModel? sendPackageViewModel;
  CreateOrderState? createOrderState;
  TextEditingController receiverAddressController = TextEditingController();
  // int selectedDeliveryTimeIndex = 0;
  // int selectedPackageSizeIndex = 0;
  // int selectedDeliveryTypeIndex = 0;
  LoginState? loginState;
  Map<String, dynamic> indexes = {};
  @override
  void initState() {
    sampleData.add(RadioModel(
        isSelected: true, button: Colors.black, text: "Immediately"));
    sampleData.add(RadioModel(
        isSelected: false,
        button: const Color(0xffFEB816),
        text: "Scheduled for later"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sendPackageViewModel =
        Provider.of<SendPackageViewModel>(context, listen: true);
    createOrderState = Provider.of<CreateOrderState>(
      context,
    );
    loginState = Provider.of<LoginState>(context);
    // _receiverAddress.text = sendPackageViewModel.receiverAddress?.description;
    return Scaffold(
      // backgroundColor: kBackground,
      // appBar: kAppBar("Check Price", showLead: true, onPress: ()=> pop(context)),

      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 2.5 * SizeConfig.heightMultiplier,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CustomTextField(
                      onTap: () async {
                        pushTo(context, EnterAddress()).then((value) {
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
                          sendPackageViewModel!.receiverAddressController,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Address is Required";
                        }
                        receiverAddress = v;
                        return null;
                      },
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
                        itemCount: createOrderState!.packageSize.length,
                        itemBuilder: (context, index) {
                          return ItemBox(
                              onTap: () {
                                setState(() {
                                  sendPackageViewModel!
                                      .selectedPackageSizeIndex = index;
                                  sendPackageViewModel!.packageSize =
                                      createOrderState!.packageSize[
                                          sendPackageViewModel!
                                              .selectedPackageSizeIndex];
                                });
                              },
                              text: createOrderState!.packageSize[index].title!,
                              image: createOrderState!
                                  .packageSize[index].imageUrl!,
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
                                    deliveryType =
                                        createOrderState!.deliveryType[index];
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
                                        text: deliveryType!.name.toString(),
                                        image: deliveryType!.imageUrl!,
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
                                        // print("second${deliveryTime.name}");
                                      });
                                    },
                                    text: createOrderState!
                                        .deliveryTime[index].description!,
                                    mainText: createOrderState!
                                        .deliveryTime[index].name!,
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
                    SizedBox(
                      height: 4.5 * SizeConfig.heightMultiplier,
                    ),
                    CustomButton(
                        text: "Check Price",
                        type: ButtonType.outlined,
                        textColor: Colors.white,
                        onPressed: () {
                          checkpriceFunc();
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void checkpriceFunc() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Preloader();
        });

    var res = await createOrderState!.checkPrice(
      token: loginState!.user.token,
      sender_id: loginState!.user.id,
      package_size_id: packageSize == null
          ? createOrderState!.packageSize[0].id
          : packageSize!.id,
      delivery_time_id: deliveryTime == null
          ? createOrderState!.deliveryTime[0].id
          : deliveryTime!.id,
      delivery_type_id: deliveryType == null
          ? createOrderState!.deliveryType[0].id
          : deliveryType!.id,
      pickup_address: sendPackageViewModel!.currentAddress.description,
      pickup_lat: sendPackageViewModel!.currentAddress.latitude,
      pickup_long: sendPackageViewModel!.currentAddress.longitude,
      pickup_raw_response: sendPackageViewModel!.currentAddress.rawResponse,
      destination_address: sendPackageViewModel!.receiverAddress.description,
      destination_lat: sendPackageViewModel!.receiverAddress.latitude,
      destination_long: sendPackageViewModel!.receiverAddress.longitude,
      destination_raw_response:
          sendPackageViewModel!.receiverAddress.rawResponse,
      pickup_type: "1",
    );
    pop(context);
    res.fold((l) {
      kShowSnackBar(context, l.props.first.toString());
    }, (r) {
      showCheckPriceSheet2(
        context: context,
        checkPriceModel: r,
        orderPayloadModel: OrderPayloadModel(
          senderAddress: sendPackageViewModel!.currentAddress,
          receiverAddress: sendPackageViewModel!.receiverAddress,
          packageSize: packageSize == null
              ? createOrderState!.packageSize[0]
              : packageSize,
          deliveryTime: deliveryTime == null
              ? createOrderState!.deliveryTime[0]
              : deliveryTime,
          deliveryType: deliveryType == null
              ? createOrderState!.deliveryType[0]
              : deliveryType,
        ),
      );
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    createOrderState!.getDeliveryTime();
    createOrderState!.getDeliveryType();
    createOrderState!.getPackageSize();
    setState(() {
      sendPackageViewModel!.selectedPackageSizeIndex = 0;
      sendPackageViewModel!.selectedDeliveryTypeIndex = 0;
      sendPackageViewModel!.selectedDeliveryTimeIndex = 0;
      sendPackageViewModel!.receiverAddressController.clear();
      sendPackageViewModel!.senderAddress.clear();
    });
  }
}

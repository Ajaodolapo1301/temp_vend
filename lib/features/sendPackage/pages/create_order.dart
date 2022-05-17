import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:status_change/status_change.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/preloader/preLoadr.dart';
import '../../../core/utils/function/snaks.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../core/widget/loading_overlay_widget.dart';
import '../../authentication/viewModel/loginState.dart';
import '../../makePayment/pages/make_payment.dart';
import '../model/orderModel.dart';
import '../model/radioModel.dart';
import '../viewModel/createOrderViewModel.dart';
import '../viewModel/sendPackageViewModel.dart';
import '../widget/order_Info.dart';
import '../widget/receiver_info.dart';

class CreateOrder extends StatefulWidget {
  final Map? indexes;
  final OrderPayloadModel? orderPayloadModel;
  const CreateOrder({Key? key, this.orderPayloadModel, this.indexes})
      : super(key: key);

  @override
  _CreateOrderState createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder>
    with AfterLayoutMixin<CreateOrder> {
  int _processIndex = 0;
  Pages pages = Pages.Order;
  int upperBound = 2;

  bool fromCheckPrice = false;

  StepperType stepperType = StepperType.horizontal;
  int activeStep = 2;
  // var sendersName;
  // var senderAddress;
  // var senderPhone;
  // var senderSending;
  // var packageSize;
  LoginState? loginState;
  // var receiverName;
  // var receiverAddress;
  // var receiverPhone;
  // var receiverAddInfo;
  bool timeSelectedExpress = false;
  bool standard = true;
  bool scheduleLater = false;
  String? _scheduleDate;
  TextEditingController scheduleController = TextEditingController();

  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  List<RadioModel> sampleData = [];
  OrderPayloadModel? orderPayloadModel;
  Map<String, dynamic> formField = {};

  SendPackageViewModel? sendPackageViewModel;

  CreateOrderState? createOrderState;
  List process = ["Order Info", "Receiver Info", "Review"];

  @override
  void initState() {
    if (widget.orderPayloadModel != null) {
      orderPayloadModel = widget.orderPayloadModel;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sendPackageViewModel = Provider.of<SendPackageViewModel>(context);
    createOrderState = Provider.of<CreateOrderState>(context);
    loginState = Provider.of<LoginState>(context);
    return LoadingOverlayWidget(
      loading: sendPackageViewModel?.busy,
      child: Scaffold(
        // appBar:
        // kAppBar("Create Order", showLead: true, onPress: () => pop(context)),

        body: SafeArea(
          bottom: false,
          child: Container(
            // padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 12.3 * SizeConfig.textMultiplier,
                    child: StatusChange.tileBuilder(
                        theme: StatusChangeThemeData(
                          direction: Axis.horizontal,
                          connectorTheme: const ConnectorThemeData(
                              space: 1.0, thickness: 1.0),
                        ),
                        builder: StatusChangeTileBuilder.connected(
                            itemWidth: (_) =>
                                MediaQuery.of(context).size.width /
                                process.length,
                            nameWidgetBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  process[index],
                                  style: kBold500.copyWith(
                                      color: getColor(index, _processIndex)),
                                ),
                              );
                            },
                            indicatorWidgetBuilder: (_, index) {
                              if (index <= _processIndex) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (index == 0) {
                                        _processIndex = 0;
                                        pages = Pages.Order;
                                      } else if (index == 1) {
                                        _processIndex--;
                                        pages = Pages.Receiver;
                                      } else if (index == 2) {
                                        _processIndex--;
                                        pages = Pages.Review;
                                      }
                                    });
                                  },
                                  child: DotIndicator(
                                    size: 35.0,
                                    color: const Color(0xffEAEAEA),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: primaryColor),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return DotIndicator(
                                  size: 35.0,
                                  color: const Color(0xffEAEAEA),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                    ),
                                  ),
                                );
                              }
                            },
                            lineWidgetBuilder: (index) {
                              if (index > 0) {
                                if (index == _processIndex) {
                                  final prevColor =
                                      getColor(index - 1, _processIndex);
                                  final color = getColor(index, _processIndex);
                                  var gradientColors;
                                  gradientColors = [
                                    prevColor,
                                    Color.lerp(prevColor, color, 0.5)
                                  ];
                                  return DecoratedLineConnector(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: gradientColors,
                                      ),
                                    ),
                                  );
                                } else {
                                  return SolidLineConnector(
                                    color: getColor(index, _processIndex),
                                  );
                                }
                              } else {
                                return null;
                              }
                            },
                            itemCount: process.length)),
                  ),
                  pages == Pages.Order
                      ? SenderWidget(
                          processIndex: _processIndex,
                          indexes: widget.indexes!,
                          orderPayloadModel: orderPayloadModel,
                          onpress: (value) {
                            setState(() {
                              var v = value["index"];
                              formField = value["orderModel"];

                              _processIndex = v;
                              move(
                                v: v,
                              );
                            });
                          },
                        )
                      : pages == Pages.Receiver
                          ? ReceiverInfo(
                              processIndex: _processIndex,
                              formField: formField,
                              orderPayloadModel: orderPayloadModel,
                              onpress: (value) {
                                setState(() {
                                  var v = value["index"];
                                  orderPayloadModel = value["orderModel"];
                                  // print(orderPayloadModel);
                                  _processIndex = v;
                                  move(v: v);
                                });
                              },
                            )
                          : reviewWidget(orderPayloadModel: orderPayloadModel)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void move({
    v,
  }) {
    if (v == 1) {
      pages = Pages.Receiver;
    } else if (v == 2) {
      pages = Pages.Review;
    } else if (v == 3) {
      createOrder();
    }
  }

  void createOrder() async {
    // print(orderPayloadModel.pickUpTime);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Preloader();
        });
    var result = await createOrderState!.createOrder(
        token: loginState!.user.token,
        sender_name: orderPayloadModel!.senderName,
        sender_phone_number: orderPayloadModel!.senderPhone,
        receiver_phone_number: orderPayloadModel!.receiverPhone,
        receiver_name: orderPayloadModel!.receiverName,
        delivery_type_id: orderPayloadModel!.deliveryType!.id,
        delivery_time_id: orderPayloadModel!.deliveryTime!.id,
        pickup_address: orderPayloadModel!.senderAddress!.description,
        pickup_long: orderPayloadModel!.senderAddress!.longitude,
        pickup_lat: orderPayloadModel!.senderAddress!.latitude,
        pickup_raw_response: orderPayloadModel!.senderAddress!.rawResponse,
        item_description: orderPayloadModel!.whatAreUSending,
        additional_info: orderPayloadModel!.addInfo,
        coupon_code: "",
        destination_raw_response:
            orderPayloadModel!.receiverAddress!.rawResponse,
        destination_long: orderPayloadModel!.receiverAddress!.longitude,
        destination_address: orderPayloadModel!.receiverAddress!.description,
        destination_lat: orderPayloadModel!.receiverAddress!.latitude,
        pickup_time: orderPayloadModel!.pickUpType == "immediate"
            ? null
            : orderPayloadModel!.pickUpTime!.toIso8601String(),
        // orderPayloadModel.pickUpTime.toUtc(),
        package_size_id: orderPayloadModel!.packageSize!.id,
        pickup_type: orderPayloadModel!.pickUpType);
    pop(context);
    result.fold(
        (l) => kShowSnackBar(context, l.props.first.toString()),
        (r) => pushTo(
            context,
            MakePayment(
              createResponse: r,
            )));
  }

  Widget reviewWidget({OrderPayloadModel? orderPayloadModel}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sender’s Info",
                style: TextStyle(
                    color: kTitleTextfieldColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 1.7 * SizeConfig.textMultiplier),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 20),
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          orderPayloadModel!.senderName!,
                          style: kBold700.copyWith(
                              fontSize: 1.9 * SizeConfig.textMultiplier,
                              color: kTitleTextfieldColor),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 15,
                          ),
                          onPressed: () {
                            setState(() {
                              pages = Pages.Order;
                              _processIndex = 0;
                            });
                          },
                        )
                      ],
                    ),
                    Text(
                      orderPayloadModel.senderAddress!.description!,
                      style: kBold400.copyWith(
                          fontSize: 1.4 * SizeConfig.textMultiplier,
                          color: kTitleTextfieldColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      orderPayloadModel.senderPhone!,
                      style: kBold400.copyWith(
                          fontSize: 1.4 * SizeConfig.textMultiplier,
                          color: kTitleTextfieldColor),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Receiver Info",
                style: TextStyle(
                    color: kTitleTextfieldColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 1.7 * SizeConfig.textMultiplier),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 20),
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          orderPayloadModel.receiverName!,
                          style: kBold700.copyWith(
                              fontSize: 1.9 * SizeConfig.textMultiplier,
                              color: kTitleTextfieldColor),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 15,
                          ),
                          onPressed: () {
                            setState(() {
                              pages = Pages.Receiver;
                              _processIndex = 1;
                            });
                          },
                        )
                      ],
                    ),
                    Text(
                      orderPayloadModel.receiverAddress!.description!,
                      style: kBold400.copyWith(
                          fontSize: 1.4 * SizeConfig.textMultiplier,
                          color: kTitleTextfieldColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      orderPayloadModel.receiverPhone!,
                      style: kBold400.copyWith(
                          fontSize: 1.4 * SizeConfig.textMultiplier,
                          color: kTitleTextfieldColor),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Package Info",
                style: TextStyle(
                    color: kTitleTextfieldColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 1.7 * SizeConfig.textMultiplier),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          orderPayloadModel.deliveryType!.name!.toString(),
                          style: kBold700.copyWith(
                              fontSize: 1.9 * SizeConfig.textMultiplier,
                              color: kTitleTextfieldColor),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 15,
                          ),
                          onPressed: () {
                            setState(() {
                              pages = Pages.Order;
                              _processIndex = 0;
                            });
                          },
                        )
                      ],
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          orderPayloadModel.addInfo ?? "",
                          style: kBold400.copyWith(
                              fontSize: 1.4 * SizeConfig.textMultiplier,
                              color: kTitleTextfieldColor),
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${orderPayloadModel.deliveryTime!.name} (${orderPayloadModel.deliveryTime!.description})",
                      style: kBold400.copyWith(
                          fontSize: 1.4 * SizeConfig.textMultiplier,
                          color: kTitleTextfieldColor),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pickup Time",
                style: TextStyle(
                    color: kTitleTextfieldColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 1.7 * SizeConfig.textMultiplier),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                    left: 24, right: 24, bottom: 20, top: 20),
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  orderPayloadModel.pickUpType! == "scheduled"
                      ? "${orderPayloadModel.pickUpType} ${dateFormat.format(orderPayloadModel.pickUpTime!)}"
                      : orderPayloadModel.pickUpType!,
                  style: kBold400.copyWith(
                      fontSize: 1.9 * SizeConfig.textMultiplier,
                      color: kTitleTextfieldColor),
                ),
              ),

              SizedBox(
                height: 4.5 * SizeConfig.heightMultiplier,
              ),

              // SizedBox(
              //   height: 4.5 * SizeConfig.heightMultiplier,
              // ),
            ],
          ),
          Row(
            children: [
              // Expanded(
              //   child: CustomButton(
              //       text: "Check price",
              //       type: ButtonType.outlined,
              //       color: Colors.white,
              //       textColor: Colors.grey,
              //       onPressed: () {
              //         setState(() {
              //           fromCheckPrice = true;
              //         });
              //           createOrder();
              //         // print(_processIndex);
              //         // setState(() {
              //         //   _processIndex++;
              //         //   move(v: 3);
              //         // });
              //       }),
              // ),
              // SizedBox(width: 20),
              Expanded(
                child: CustomButton(
                    text: "Next",
                    type: ButtonType.outlined,
                    textColor: Colors.white,
                    onPressed: () {
                      // print(_processIndex);
                      setState(() {
                        _processIndex++;
                        move(v: 3);
                      });
                    }),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {}
}

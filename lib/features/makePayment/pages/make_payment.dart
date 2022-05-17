import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/preloader/preLoadr.dart';
import '../../../core/utils/apiUrls/env.dart';
import '../../../core/utils/function/logo.dart';
import '../../../core/utils/function/snaks.dart';
import '../../../core/utils/myUtils/myUtils.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../core/utils/widgets/custom_text_field.dart';
import '../../authentication/viewModel/loginState.dart';
import '../../myOrder/widget/paymentMethod.dart';
import '../../sendPackage/model/createOrderResponse.dart';
import '../../sendPackage/viewModel/createOrderViewModel.dart';
import '../../wallet/viewModel/walletState.dart';
import '../model/paymentMethod.dart';
import '../viewModel/makePaymentViewModel.dart';
import '../widget/pricing.dart';
import 'booking_comfiration.dart';

class MakePayment extends StatefulWidget {
  CreateResponse? createResponse;
  MakePayment({Key? key, this.createResponse}) : super(key: key);

  @override
  _MakePaymentState createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  bool applyCoupon = false;
  int selectedIndex = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController couponController = TextEditingController();
  CheckoutMethod method = CheckoutMethod.card;
  bool _inProgress = false;
  String? _cardNumber;
  String? _cvv;
  int? _expiryMonth;
  MakePaymentViewModel? makePaymentState;
  int? _expiryYear;
  LoginState? loginState;
  CreateOrderState? createOrderState;
  // final String currency = FlutterwaveCurrency.NGN;
  final plugin = PaystackPlugin();
  // var txRef = "primexFundRef-${DateTime.now().millisecondsSinceEpoch}";

  WalletState? walletState;

  List<PaymentMethod> listOfPayment = [
    PaymentMethod(
        methodName: "wallet",
        text: "Wallet Balance",
        image: "makePayment/wallet.png"),
    PaymentMethod(
        methodName: "paystack",
        text: "Paystack",
        image: "makePayment/Paystack.png"),
    // PaymentMethod(
    //     methodName: "flutterwave",
    //     text: "Flutterwave",
    //     image: "makePayment/flw.png"
    // ),
    PaymentMethod(
        methodName: "cash",
        text: "Cash on Pick up",
        image: "makePayment/cash.png")
  ];

  CreateResponse? createResponse;
  @override
  void initState() {
    plugin.initialize(publicKey: SystemProperties.payStackLiveKeys);

    createResponse = widget.createResponse;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loginState = Provider.of<LoginState>(context);
    makePaymentState = Provider.of<MakePaymentViewModel>(context);
    createOrderState = Provider.of<CreateOrderState>(context);
    walletState = Provider.of<WalletState>(context);
    return Scaffold(
      // appBar:
      // kAppBar("Make Payment", showLead: true, onPress: () => pop(context)),
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 2.5 * SizeConfig.heightMultiplier,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            applyCoupon = !applyCoupon;
                          });
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                                "${imagePath}makePayment/getCoupon.svg"),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Got Coupon?",
                              style: kBold400.copyWith(
                                  fontSize: 1.7 * SizeConfig.textMultiplier),
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    applyCoupon = !applyCoupon;
                                  });
                                },
                                child: Text(
                                  " Apply",
                                  style: kBold500.copyWith(
                                      fontSize:
                                          1.7 * SizeConfig.textMultiplier),
                                )),
                          ],
                        ),
                      ),
                      // applyCoupon
                      //     ?
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: applyCoupon ? 1 : 0,
                        child: CustomTextField(
                          textEditingController: couponController,
                          useMargin: false,
                          hint: "Enter Coupon",
                          suffix: TextButton(
                            onPressed: () {
                              redeemCoupon();
                            },
                            child: Text(
                              "APPLY",
                              style: kBold700.copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      // : SizedBox(),
                      // SizedBox(
                      //   height: 2.0 * SizeConfig.heightMultiplier,
                      // ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        decoration: BoxDecoration(
                            color: const Color(0xfff9fafb),
                            borderRadius: BorderRadius.circular(10)),

                        //
                        padding: EdgeInsets.only(
                            left: 20, top: applyCoupon ? 10 : 0),
                        child: Column(
                          children: [
                            pricing(
                                mainText: "Shipping Fee",
                                price:
                                    "${MyUtils.formatAmount(createResponse!.price!.shippingFee.toString())}"),
                            SizedBox(
                              height: 1.8 * SizeConfig.heightMultiplier,
                            ),
                            pricing(
                              mainText: "Bonus",
                              price: createResponse?.price!.bonus != null
                                  ? "${MyUtils.formatAmount(createResponse!.price!.bonus!.amount.toString())}"
                                  : "0.00",
                            ),
                            SizedBox(
                              height: 1.8 * SizeConfig.heightMultiplier,
                            ),
                            pricing(
                                mainText: "Coupon",
                                price: createResponse?.price!.coupon != null
                                    ? "${createResponse?.price!.coupon!.amount}"
                                    : "0.00"),
                            SizedBox(
                              height: 1.8 * SizeConfig.heightMultiplier,
                            ),
                            pricing(
                              mainText: "Total",
                              price:
                                  "${MyUtils.formatAmount(createResponse!.price!.total.toString())}",
                              textStyle: kBold700.copyWith(
                                  fontFamily: "",
                                  fontSize: 1.7 * SizeConfig.textMultiplier),
                            )
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Choose Payment Method ",
                              style: kBold500.copyWith(
                                  fontSize: 1.7 * SizeConfig.textMultiplier),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: listOfPayment
                                  .asMap()
                                  .keys
                                  .toList()
                                  .map((index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: paymentMethod(
                                      index: index,
                                      selectedIndex: selectedIndex,
                                      image: listOfPayment[index].image,
                                      text: listOfPayment[index].text),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.5 * SizeConfig.heightMultiplier,
                  ),
                  CustomButton(
                      text: "Make Payment",
                      type: ButtonType.outlined,
                      textColor: Colors.white,
                      onPressed: () {
                        if (selectedIndex == 0) {
                          //  wallet payment
                          paymentWithWallet(
                              reference:
                                  createResponse!.referenceNumber.toString());
                        } else if (selectedIndex == 1) {
                          //payStack
                          _handleCheckout(context);
                        } else {
                          // cash
                          verifyPayment(
                              reference:
                                  createResponse!.referenceNumber.toString());
                        }
                        // pushTo(context, BookingConfirmation());
                      }),
                  SizedBox(
                    height: 4.5 * SizeConfig.heightMultiplier,
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void redeemCoupon() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Preloader();
        });
    var result = await createOrderState!.redeemCoupon(
        coupon: couponController.text.trim(),
        order_id: createResponse!.id,
        token: loginState!.user.token);
    pop(context);

    result.fold(
        (l) => kShowSnackBar(context,
            l.props.first.toString().replaceAll("[", "").replaceAll("]", "")),
        (r) {
      setState(() {
        createResponse = r;
      });
    });
  }

  // Rave

  // _pay2(BuildContext context) {
  //   final _rave = RaveCardPayment(
  //     isDemo: true,
  //     publicKey: SystemProperties.flutterWaveTestKey,
  //     encKey: SystemProperties.flutterWaveTestEncKey,
  //     transactionRef: txRef,
  //     amount: double.parse(createResponse.price.total.toString()),
  //     email: loginState.user.email,
  //     onSuccess: (response) {
  //
  //       if (mounted) {
  //
  //         verifyPayment(reference: txRef);
  //         // Scaffold.of(context).showSnackBar(
  //         //   SnackBar(
  //         //     content: Text("Transaction Sucessful!"),
  //         //     backgroundColor: Colors.green,
  //         //     duration: Duration(
  //         //       seconds: 5,
  //         //     ),
  //         //   ),
  //         // );
  //       }
  //     },
  //     onFailure: (err) {
  //       print("$err");
  //       print("Transaction failed");
  //     },
  //     onClosed: () {
  //       print("Transaction closed");
  //     },
  //     context: context,
  //   );
  //   _rave.process();
  // }

  _handleCheckout(BuildContext context) async {
    // if (_method != CheckoutMethod.card) {
    //   _showMessage('Select server initialization method at the top');
    //   return;
    // }
    setState(() => _inProgress = true);
    _formKey.currentState?.save();
    Charge charge = Charge()
      ..amount = (createResponse!.price!.total!.toInt() * 100)
      ..email = loginState!.user.email
      ..reference = createResponse!.referenceNumber.toString()
      ..card = _getCardFromUI();

    try {
      CheckoutResponse? response = await plugin.checkout(
        context,
        method: method,
        charge: charge,
        fullscreen: false,
        logo: MyLogo(),
      );

      setState(() => _inProgress = false);
      if (response.status != false && response.method != null) {
        verifyPayment(reference: response.reference);
      }
    } catch (e) {
      setState(() => _inProgress = false);
      // _showMessage("Check console for error");
      rethrow;
    }
  }

  verifyPayment({reference}) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Preloader();
        });

    var res = await makePaymentState!.updatePaymentDetails(
        payment_method: listOfPayment[selectedIndex].methodName,
        price: createResponse!.price!.total,
        reference_number: reference,
        order_id: createResponse!.id,
        token: loginState!.user.token);
    pop(context);
    res.fold((l) => kShowSnackBar(context, l.props.first.toString()), (r) {
      pop(context);
      pushReplacementTo(
          context,
          BookingConfirmation(
            createResponse: createResponse,
          ));
    });
  }

  paymentWithWallet({reference}) async {
    print("amounttttt ${createResponse!.price!.total.toString()}");
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Preloader();
        });

    var res = await walletState!.paymentWithWallet(
        title: "order",
        amount: createResponse!.price!.total.toString(),
        transaction_id: reference,
        token: loginState!.user.token,
        user_id: loginState!.user.id.toString());
    pop(context);
    res.fold(
        (l) => kShowSnackBar(context, l.props.first.toString()),
        (r) =>
            // pushReplacementTo(context, BookingConfirmation(createResponse: createResponse,))

            verifyPayment(reference: reference));
  }

  // pushReplacementTo(context, BookingConfirmation(createResponse: createResponse,));
  // _updateStatus(String reference, String message) {
  //   _showMessage('Reference: $reference \n\ Response: $message',
  //       const Duration(seconds: 7));
  // }
  // _showMessage(String message,
  //     [Duration duration = const Duration(seconds: 4)]) {
  //   ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
  //     content: new Text(message),
  //     duration: duration,
  //     action: new SnackBarAction(
  //         label: 'CLOSE',
  //         onPressed: () =>
  //             ScaffoldMessenger.of(context).removeCurrentSnackBar()),
  //   ));
  // }

  PaymentCard _getCardFromUI() {
    // Using just the must-required parameters.
    return PaymentCard(
      number: _cardNumber,
      cvc: _cvv,
      expiryMonth: _expiryMonth,
      expiryYear: _expiryYear,
    );
  }
}

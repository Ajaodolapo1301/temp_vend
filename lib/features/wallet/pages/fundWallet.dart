import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/apiUrls/env.dart';
import '../../../core/utils/function/logo.dart';
import '../../../core/utils/function/snaks.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../core/widget/loading_overlay_widget.dart';
import '../../authentication/viewModel/loginState.dart';
import '../../makePayment/model/paymentMethod.dart';
import '../../makePayment/viewModel/makePaymentViewModel.dart';
import '../../myOrder/widget/paymentMethod.dart';
import '../viewModel/walletState.dart';
import 'paymentStates/confirmation.dart';

class FundWalletPage extends StatefulWidget {
  const FundWalletPage({Key? key}) : super(key: key);

  @override
  _FundWalletPageState createState() => _FundWalletPageState();
}

class _FundWalletPageState extends State<FundWalletPage> {
  MoneyMaskedTextController controller = MoneyMaskedTextController(
      decimalSeparator: ".", thousandSeparator: ",", leftSymbol: "NGN");

  // final String currency = FlutterwaveCurrency.NGN;
  final plugin = PaystackPlugin();
  final _formKey = GlobalKey<FormState>();
  CheckoutMethod _method = CheckoutMethod.card;
  bool _inProgress = false;
  var txRef = "primexFundRef-${DateTime.now().millisecondsSinceEpoch}";
  LoginState? loginState;
  MakePaymentViewModel? makePaymentState;
  String? _cardNumber;
  String? _cvv;
  int? _expiryMonth;
  int? _expiryYear;
  WalletState? walletState;
  List<PaymentMethod>? listOfPayment = [
    PaymentMethod(
        methodName: "paystack",
        text: "Paystack",
        image: "makePayment/Paystack.png"),
    // PaymentMethod(
    //     methodName: "flutterwave",
    //     text: "Flutterwave",
    //     image: "makePayment/flw.png"
    // ),
  ];
  int selectedIndex = 0;

  @override
  void initState() {
    plugin.initialize(publicKey: SystemProperties.payStackLiveKeys);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loginState = Provider.of<LoginState>(context);
    makePaymentState = Provider.of<MakePaymentViewModel>(context);
    walletState = Provider.of<WalletState>(context);
    txRef = "primexFundRef-${DateTime.now().millisecondsSinceEpoch}";
    return LoadingOverlayWidget(
      loading: walletState?.busy,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar:  kAppBar("Wallet", showLead: true, showAction: false, onPress: ()=> pop(context)),

        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enter Amount",
                          style: kBold500.copyWith(
                              fontSize: 1.7 * SizeConfig.textMultiplier),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Container(
                          height: 100,
                          color:
                              // Colors.grey,
                              const Color(0xffF9FAFB),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 30),
                            child: Center(
                              child: Container(
                                child: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                      autofocus: true,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      textAlign: TextAlign.center,
                                      controller: controller,
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return "Amount is required";
                                        }
                                        return null;
                                      },
                                      style: kBold700.copyWith(
                                          fontSize: 30,
                                          color: kTitleTextfieldColor),
                                      decoration: const InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
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
                          children:
                              listOfPayment!.asMap().keys.toList().map((index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: paymentMethod(
                                  index: index,
                                  selectedIndex: selectedIndex,
                                  image: listOfPayment![index].image,
                                  text: listOfPayment![index].text),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              CustomButton(
                text: "Add funds",
                textColor: Colors.white,
                type: ButtonType.outlined,
                onPressed: () {
                  if (controller.text == "NGN0.00") {
                    toast("Enter amount");
                  } else {
                    // print(selectedIndex);
                    if (selectedIndex == 0) {
                      initiate();
                    } else if (selectedIndex == 1) {
                      // _pay2(context);
                    }
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // _pay2(BuildContext context) {
  //   final _rave = RaveCardPayment(
  //     isDemo: true,
  //
  //     publicKey: SystemProperties.flutterWaveTestKey,
  //     encKey: SystemProperties.flutterWaveTestEncKey,
  //
  //     transactionRef: txRef,
  //     amount: double.parse(controller.text.replaceAll("NGN", "").replaceAll(".", "").replaceAll(",", "")),
  //     email: loginState.user.email,
  //
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

  _handleCheckout(BuildContext context, txRef) async {
    setState(() => _inProgress = true);
    _formKey.currentState?.save();
    Charge charge = Charge()
      ..amount = int.parse(controller.text
          .replaceAll("NGN", "")
          .replaceAll(".", "")
          .replaceAll(",", "")) // In base currency
      ..email = loginState!.user.email
      ..reference = txRef
      ..card = _getCardFromUI();

    try {
      CheckoutResponse response = await plugin.checkout(
        context,
        method: _method,
        charge: charge,
        fullscreen: false,
        logo: MyLogo(),
      );
      print('Response = $response');
      setState(() => _inProgress = false);
      if (response.status && response.card != null) {
        verifyPayment(
          reference: response.reference,
        );
      }
    } catch (e) {
      setState(() => _inProgress = false);
      // _showMessage("Check console for error");
      rethrow;
    }
  }

  verifyPayment({reference}) async {
    var res = await walletState!.confirmPayment(
        token: loginState!.user.token,
        gateway: listOfPayment![selectedIndex].methodName,
        transaction_id: reference);

    res.fold((l) => kShowSnackBar(context, l.props.first.toString()), (r) {
      // print(r);
      pushTo(
          context,
          TransactionConfirmation(
            isSuccess: true,
            amount: controller.text
                .replaceAll("NGN", "")
                .replaceAll(".", "")
                .replaceAll(",", ""),
          ));
    }
        // pushReplacementTo(context, BookingConfirmation(createResponse: createResponse,))
        );
  }

  void initiate() async {
    var result = await walletState!.initiatePayment(
        token: loginState!.user.token,
        previous_balance: walletState!.walletBalance.balance,
        amount: controller.text
            .replaceAll("NGN", "")
            .replaceAll(".", "")
            .replaceAll(",", ""),
        type: "credit",
        transaction_id: txRef);

    result.fold((l) => kShowSnackBar(context, l.props.first.toString()), (r) {
      _handleCheckout(context, r.transactionId);
    });
  }

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

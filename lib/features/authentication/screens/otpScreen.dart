import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:vend_express/features/authentication/screens/recover_password/update_password.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/function/snaks.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../core/utils/widgets/header.dart';
import '../../../core/widget/loading_overlay_widget.dart';
import '../../dashboard/screens/home.dart';
import '../model/user.dart';
import '../viewModel/loginState.dart';
import '../widget/OtpTimer.dart';
// const imagePath = "assets/images/";

class OTPPage extends StatefulWidget {
  final User? user;
  final String? phone;
  final pin_id;
  const OTPPage({Key? key, this.user, this.phone, this.pin_id})
      : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<OTPPage> with TickerProviderStateMixin {
  Timer? timer;
  int? totalTimeInSeconds;
  bool _hideResendButton = false;
  LoginState? loginState;

  final FocusNode _pinPutFocusNode = FocusNode();
  final int time = 60;
  final _otpController = TextEditingController();
  AnimationController? _controller;
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: kTitleTextfieldColor),
    );
  }

  @override
  void initState() {
    totalTimeInSeconds = time;
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: time))
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed) {
              setState(() {
                _hideResendButton = !_hideResendButton;
              });
            }
          });
    _controller?.reverse(
        from: _controller!.value == 0.0 ? 1.0 : _controller!.value);
    _startCountdown();

    // getCurrentAppTheme();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loginState = Provider.of<LoginState>(context);

    return LoadingOverlayWidget(
      loading: loginState?.busy,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Column(
              children: [
                Header(
                  text: "",
                  preferredActionOnBackPressed: () {
                    Navigator.maybePop(context);
                  },
                ),
                SizedBox(
                  height: 6 * SizeConfig.heightMultiplier,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("${imagePath}otp/otpPadlock.svg"),
                      SizedBox(
                        height: 3.9 * SizeConfig.heightMultiplier,
                      ),
                      Text(
                        "Enter OTP",
                        style: kBold700.copyWith(
                            fontSize: 2.2 * SizeConfig.textMultiplier),
                      ),
                      SizedBox(
                        height: 0.7 * SizeConfig.heightMultiplier,
                      ),
                      Text(
                        "Please enter 6-digits code that sent to you at ${widget.user?.phone == null ? widget.phone : widget.user!.phone}",
                        textAlign: TextAlign.center,
                        style: kBold400.copyWith(
                            fontSize: 1.7 * SizeConfig.textMultiplier),
                      ),
                      SizedBox(
                        height: 3.9 * SizeConfig.heightMultiplier,
                      ),
                      Container(
                        child: Pinput(
                          length: 6,
                          onSubmitted: (String pin) {
                            setState(() {
                              // _enableBtn = true;
                            });
                          },
                          focusNode: _pinPutFocusNode,
                          controller: _otpController,
                          submittedPinTheme: PinTheme(
                              decoration: _pinPutDecoration.copyWith(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                          focusedPinTheme: PinTheme(
                              decoration: _pinPutDecoration.copyWith(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                          followingPinTheme: PinTheme(
                              decoration: _pinPutDecoration.copyWith(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                _hideResendButton
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Resend code in ",
                              style: kBold400.copyWith(
                                  fontSize: 1.4 * SizeConfig.textMultiplier),
                            ),
                            _getTimerText,
                          ],
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          resendOTP();
                        },
                        child: const Text("Resend")),
                SizedBox(
                  height: 12.8 * SizeConfig.heightMultiplier,
                ),
                CustomButton(
                    text: "Confirm",
                    type: ButtonType.outlined,
                    textColor: Colors.white,
                    onPressed: () {
                      if (_otpController.text.length == 6) {
                        widget.user != null
                            ? verifyOTP()
                            : pushTo(
                                context,
                                UpdatePasswordPage(
                                  otp: _otpController.text,
                                  phone: widget.phone!,
                                  pin_id: widget.pin_id,
                                ));
                      } else {
                        kShowSnackBar(context, "Enter OTP");
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void resendOTP() async {
    var res = await loginState!.resendOtp(phone: widget.user!.phone!);
    res.fold((l) => kShowSnackBar(context, l.props.first.toString()), (r) {
      kShowSnackBar(context, r);
      _startCountdown();
    });
  }

  void verifyOTP() async {
    var res = await loginState!.verifyOtp(
      otp: _otpController.text,
      phone: widget.user!.phone,
      id: widget.user!.id.toString(),
      pin_id: widget.user!.pinId,
    );
    res.fold((l) => kShowSnackBar(context, l.props.first.toString()), (r) {
      kShowSnackBar(context, r);
      Future.delayed(const Duration(milliseconds: 4)).then((value) {
        pushToAndClearStack(context, Home());
      });
    });
  }

  get _getTimerText {
    return Offstage(
      offstage: !_hideResendButton,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          OtpTimer(
            _controller!,
            1.4 * SizeConfig.textMultiplier,
            kTitleTextfieldColor,
          )
        ],
      ),
    );
  }

  Future<Null> _startCountdown() async {
    setState(() {
      _hideResendButton = true;
      totalTimeInSeconds = time;
    });
    _controller!
        .reverse(from: _controller!.value == 0.0 ? 1.0 : _controller!.value);
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/textStyleConstants.dart';
import '../../../../core/utils/navigation/navigator.dart';
import '../../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../../core/utils/widgets/custom_button.dart';
import '../../../../core/utils/widgets/header.dart';
import '../otpScreen.dart';

class RecoverNotification extends StatefulWidget {
  final String? pin_id;
  final String? phone;
  const RecoverNotification({Key? key, this.pin_id, this.phone})
      : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RecoverNotification>
    with TickerProviderStateMixin {
  Timer? timer;
  int? totalTimeInSeconds;
  bool _hideResendButton = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
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
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset("${imagePath}otp/kite.svg"),
                    SizedBox(
                      height: 3.9 * SizeConfig.heightMultiplier,
                    ),
                    Text(
                      "Recover Password",
                      style: kBold700.copyWith(
                          fontSize: 2.2 * SizeConfig.textMultiplier),
                    ),
                    SizedBox(
                      height: 0.7 * SizeConfig.heightMultiplier,
                    ),
                    Text(
                      "We have sent a password recovery instructions to your email",
                      textAlign: TextAlign.center,
                      style: kBold400.copyWith(
                          fontSize: 1.7 * SizeConfig.textMultiplier),
                    ),
                    SizedBox(
                      height: 3.9 * SizeConfig.heightMultiplier,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.8 * SizeConfig.heightMultiplier,
              ),
              CustomButton(
                  text: "Check Phone",
                  type: ButtonType.outlined,
                  textColor: Colors.white,
                  onPressed: () {
                    pushTo(
                        context,
                        OTPPage(
                          phone: widget.phone,
                          pin_id: widget.pin_id,
                          user: null,
                        ));
                    // pushTo(context, UpdatePasswordPage());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

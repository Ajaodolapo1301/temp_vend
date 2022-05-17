import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vend_express/core/constants/textStyleConstants.dart';

import '../../../../core/utils/myUtils/myUtils.dart';
import '../../../../core/utils/navigation/navigator.dart';
import '../../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../../core/utils/styles/color_utils.dart';
import '../../../../core/utils/widgets/custom_button.dart';
import '../../../dashboard/screens/home.dart';
import '../../../profile/model/languageModel.dart';

class TransactionConfirmation extends StatefulWidget {
  final String? amount;
  final bool? isSuccess;
  const TransactionConfirmation({Key? key, this.isSuccess = true, this.amount})
      : super(key: key);

  @override
  _TransactionConfirmationState createState() =>
      _TransactionConfirmationState();
}

class _TransactionConfirmationState extends State<TransactionConfirmation> {
  List<LanguageModel> languageData = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        pushToAndClearStack(context, Home());
        return false;
      },
      child: Scaffold(
        // backgroundColor: Color(0xffE5E5E5
        // ),
        // appBar:  kAppBar("Payment Confirmation", onPress: ()=> pop(context), showAction: false),

        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Transfer ${widget.isSuccess! ? "Successful" : "Failed"} ",
                      style: kBold700.copyWith(
                          color: fadedText,
                          fontSize: 1.9 * SizeConfig.textMultiplier),
                    ),
                    SizedBox(
                      height: 3.6 * SizeConfig.heightMultiplier,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.isSuccess! ? okCheck : badCheck,
                      ),
                      width: 28.8 * SizeConfig.widthMultiplier,
                      height: 13.3 * SizeConfig.heightMultiplier,
                      child: Center(
                          child: SvgPicture.asset(
                        "${imagePath}wallet/${widget.isSuccess! ? "check" : "cancel"}.svg",
                      )),
                    ),
                    SizedBox(
                      height: 6.1 * SizeConfig.heightMultiplier,
                    ),
                    Text(
                      "₦${MyUtils.getFormattedAmount(double.parse(widget.amount!))}",
                      style: kBold700.copyWith(
                          fontSize: 4.3 * SizeConfig.textMultiplier,
                          color: kTitleTextfieldColor,
                          fontFamily: ""),
                    ),
                    Text(
                      "Has been successfully added to your wallet",
                      textAlign: TextAlign.center,
                      style: kBold500.copyWith(
                          fontSize: 1.9 * SizeConfig.textMultiplier),
                    )
                  ],
                )),
                CustomButton(
                    text: "Ok",
                    type: ButtonType.outlined,
                    textColor: Colors.white,
                    onPressed: () {
                      pushToAndClearStack(context, Home());
                    }),
                SizedBox(
                  height: 9.8 * SizeConfig.heightMultiplier,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

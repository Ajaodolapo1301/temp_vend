import 'package:flutter/material.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/myUtils/myUtils.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';

class WalletBalanceWidget extends StatelessWidget {
  final Color? color;
  final String? balance;
  final String? backgroundImage;
  final VoidCallback? onPress;

  WalletBalanceWidget(
      {this.onPress, this.balance, this.color, this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 16.2 * SizeConfig.heightMultiplier,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                backgroundImage!,
                color: complementary.withOpacity(0.2),
                fit: BoxFit.fill,
                // width: 120,
                // height: 120,
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: 1.8 * SizeConfig.heightMultiplier),
              child: Column(
                children: [
                  Text("Wallet Balance",
                      style: kBold500.copyWith(
                          fontSize: 1.2 * SizeConfig.textMultiplier,
                          color: Colors.white)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("₦",
                          style: kBold700.copyWith(
                              color: Colors.white,
                              fontSize: 4.3 * SizeConfig.textMultiplier,
                              fontFamily: "")),
                      Text(MyUtils.formatAmount(balance ?? "0"),
                          style: kBold700.copyWith(
                            color: Colors.white,
                            fontSize: 4.3 * SizeConfig.textMultiplier,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 1.2 * SizeConfig.heightMultiplier,
                  ),
                  InkWell(
                    onTap: onPress,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 1.8 * SizeConfig.heightMultiplier),
                      child: Text(
                        "Fund Wallet",
                        style: kBold500.copyWith(
                            color: color,
                            fontSize: 1.3 * SizeConfig.textMultiplier),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

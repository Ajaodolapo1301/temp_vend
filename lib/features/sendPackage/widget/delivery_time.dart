import 'package:flutter/material.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';

class DeliveryTimeWidget extends StatelessWidget {
  String? mainText;
  String? text;
  bool? selected;
  VoidCallback? onTap;
  DeliveryTimeWidget({this.text, this.mainText, this.selected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 8),
        // width: 27.7 * SizeConfig.widthMultiplier,
        padding: EdgeInsets.all(10),

        decoration: BoxDecoration(
            border: Border.all(
                color:
                    selected! ? complementary : Colors.grey.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mainText!,
              style:
                  kBold400.copyWith(fontSize: 1.4 * SizeConfig.textMultiplier),
            ),
            Text(
              text!,
              style: kBold400.copyWith(
                  color: Colors.black26,
                  fontSize: 1.2 * SizeConfig.textMultiplier),
            )
          ],
        ),
      ),
    );
  }
}

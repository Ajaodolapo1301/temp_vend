import 'package:flutter/material.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';

Row pricing({mainText, price, textStyle}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        mainText,
        style: textStyle ??
            kBold400.copyWith(fontSize: 1.7 * SizeConfig.textMultiplier),
      ),
      Row(
        children: [
          Text(
            "₦",
            style: textStyle ??
                kBold500.copyWith(
                    fontFamily: " ",
                    fontSize: 1.7 * SizeConfig.textMultiplier,
                    color: const Color(0xff666E7A)),
          ),
          Text(
            price,
            style: textStyle ??
                kBold500.copyWith(
                    fontFamily: "",
                    fontSize: 1.7 * SizeConfig.textMultiplier,
                    color: const Color(0xff666E7A)),
          ),
        ],
      )
    ],
  );
}

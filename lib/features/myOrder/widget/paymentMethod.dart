import 'package:flutter/material.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';

Container paymentMethod({text, image, int? selectedIndex, index}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(
          color:
              selectedIndex == index ? primaryColor : const Color(0xffEEEEEE)),
    ),
    child: Row(
      children: [
        Image.asset("${imagePath}$image"),
        const SizedBox(
          width: 20,
        ),
        Text(
          text,
          style: kBold500.copyWith(fontSize: 1.7 * SizeConfig.textMultiplier),
        )
      ],
    ),
  );
}

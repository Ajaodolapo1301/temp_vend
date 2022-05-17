import 'package:flutter/material.dart';

import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';

class TitleWidget extends StatelessWidget {
  final String? mainText;
  final String? subtext;

  const TitleWidget({
    this.mainText,
    this.subtext,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mainText!,
          style: TextStyle(
              fontSize: 2.9 * SizeConfig.textMultiplier,
              color: kTitleTextfieldColor,
              fontWeight: FontWeight.w700),
        ),
        Text(
          subtext!,
          style: TextStyle(
              fontSize: 1.7 * SizeConfig.textMultiplier,
              color: kTitleTextfieldColor,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}

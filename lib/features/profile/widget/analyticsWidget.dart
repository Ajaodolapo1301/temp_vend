import 'package:flutter/material.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';

class AnalyticsWidget extends StatelessWidget {
  final Color? color;

  final Color? subtitleColor;
  final String? title;
  final String? subtitle;
  final VoidCallback? onPress;

  AnalyticsWidget(
      {this.onPress,
      this.title,
      this.color,
      this.subtitle,
      this.subtitleColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.maxFinite,
      height: 16.2 * SizeConfig.heightMultiplier,
      padding: const EdgeInsets.symmetric(horizontal: 29),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: kBold500.copyWith(fontSize: 10),
          ),
          Text(
            subtitle!,
            style: kBold700.copyWith(
                fontSize: 3.9 * SizeConfig.textMultiplier,
                color: subtitleColor),
          )
        ],
      ),
    );
  }
}

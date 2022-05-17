import 'package:flutter/material.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../../core/utils/styles/fontSize.dart';
import '../../trackOrder/model/trackOrderModel.dart';

Widget trackOrderWidget(
    {TrackOrderModel? trackOrderModel,
    bool? isCompleted,
    String? type,
    String? text,
    String? subtext,
    String? boldText}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        type!,
        style: kBold400.copyWith(
            fontSize: fourteen, color: const Color(0xff666E7A)),
      ),
      const SizedBox(
        height: 8,
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: const Color(0xffE5E5E5))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  boldText!,
                  style: kBold500.copyWith(
                      color: const Color(0xff515151),
                      fontSize: sixteen,
                      fontFamily: ""),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              text!,
              style: kBold400.copyWith(color: const Color(0xff666E7A)),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              subtext!,
              style: kBold400.copyWith(color: const Color(0xff666E7A)),
            )
          ],
        ),
      ),
    ],
  );
}

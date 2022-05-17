import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:vend_express/core/utils/styles/color_utils.dart';

import '../../constants/textStyleConstants.dart';

kShowSnackBar(BuildContext ctx, String msg,
    {position, color, textColor, title}) {
  return Flushbar(
    flushbarPosition: position ?? FlushbarPosition.BOTTOM,
    backgroundColor: color ?? Colors.red,
    titleColor: primaryColor,
    icon: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Icon(
        Icons.info,
        size: 28,
        color: const Color(0xffFFB113),
      ),
    ),
    messageText: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            msg,
            style: kBold500.copyWith(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          Text(
            title ?? "",
            // textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.yellow,
              fontSize: 15,
            ),
          ),
        ],
      ),
    ),
    leftBarIndicatorColor: const Color(0xffFFB113),
    duration: const Duration(seconds: 3),
  )..show(ctx);
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vend_express/core/utils/styles/color_utils.dart';

import '../navigation/navigator.dart';

class Header extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final VoidCallback? preferredActionOnBackPressed;
  final Widget? suffix;
  final bool showPrefix;
  const Header({
    Key? key,
    this.text,
    this.showPrefix = true,
    this.textStyle,
    this.suffix,
    this.preferredActionOnBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        showPrefix
            ? IconButton(
                icon: Platform.isIOS
                    ? const Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 18,
                        color: kTitleTextfieldColor,
                      )
                    : const Icon(
                        Icons.arrow_back_sharp,
                        size: 18,
                        color: kTitleTextfieldColor,
                      ),
                onPressed: () {
                  preferredActionOnBackPressed != null
                      ? preferredActionOnBackPressed!()
                      : pop(context);
                },
              )
            : Container(),
        const Spacer(),
        Text(
          text!,
          style: textStyle ??
              TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
        ),
        const Spacer(),
        suffix ?? Container()
        // Opacity(
        //   opacity: 0,
        //   child: IconButton(
        //     icon: Icon(
        //       Icons.arrow_back_ios,
        //       size: 18,
        //     ),
        //     onPressed: null,
        //   ),
        // ),
      ],
    );
  }
}

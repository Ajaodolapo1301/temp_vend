import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vend_express/core/utils/navigation/navigator.dart';

import '../utils/sizeConfig/sizeConfig.dart';
import '../utils/styles/color_utils.dart';

const imagePath = "assets/images/";
const kBold700 = TextStyle(fontWeight: FontWeight.w700);

const kBold500 =
    TextStyle(color: kTitleTextfieldColor, fontWeight: FontWeight.w500);

const kBold400 = TextStyle(fontWeight: FontWeight.w400);

Color getColor(int index, _processIndex) {
  if (index == _processIndex) {
    return kTitleTextfieldColor;
  } else if (index < _processIndex) {
    return kTitleTextfieldColor;
  } else {
    return Colors.grey;
  }
}

Widget kAppBar(String label,
    {bool showLead = true,
    bool cancel = false,
    showAction = false,
    VoidCallback? onPress}) {
  return AppBar(
    elevation: 0,
    leading: showLead
        ? IconButton(
            icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back_outlined,
              color: Colors.black,
            ),
            onPressed: showLead ? onPress : null)
        : Container(),
    backgroundColor: Colors.white,
    actions: [
      showAction
          ? IconButton(
              icon: Icon(
                cancel ? Icons.close : Icons.more_vert,
                color: Colors.black,
              ),
              onPressed: cancel ? onPress : null)
          : Container()
    ],
    centerTitle: true,
    title: Text(
      label,
      style: kBold700.copyWith(
          color: complementary, fontSize: 2.2 * SizeConfig.textMultiplier),
    ),
  );
}

enum Pages { Order, Receiver, Review }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? showLead;
  final bool? cancel;
  final bool? showAction;
  final VoidCallback? onPress;
  final String? label;
  final VoidCallback? preferredBackAction;

  const CustomAppBar(
      {Key? key,
      this.preferredBackAction,
      this.onPress,
      this.showAction = false,
      this.showLead = true,
      this.label,
      this.cancel = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        leading: showLead!
            ? IconButton(
                icon: Icon(
                  Platform.isIOS
                      ? Icons.arrow_back_ios
                      : Icons.arrow_back_outlined,
                  color: Colors.black,
                ),
                onPressed: showLead!
                    ? preferredBackAction ??
                        () {
                          pop(context);
                        }
                    : null)
            : Container(),
        backgroundColor: Colors.white,
        actions: [
          showAction!
              ? IconButton(
                  icon: Icon(
                    cancel! ? Icons.close : Icons.more_vert,
                    color: Colors.black,
                  ),
                  onPressed: cancel! ? onPress : null)
              : Container()
        ],
        centerTitle: true,
        title: Text(
          label!,
          style: kBold700.copyWith(
              color: complementary, fontSize: 2.2 * SizeConfig.textMultiplier),
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}

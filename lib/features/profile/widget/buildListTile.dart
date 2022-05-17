import 'package:flutter/material.dart';

import '../../../core/utils/sizeConfig/sizeConfig.dart';

Widget buildListTile(
    {required String title,
    required String subTitle,
    Widget? preferredTrailing,
    required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: const Color(0xff515151),
              fontWeight: FontWeight.w400,
              fontSize: 1.9 * SizeConfig.textMultiplier,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 15,
            color: Colors.black,
          ),
        ],
      ),
    ),
  );
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';

class ItemBox extends StatelessWidget {
  String? image;
  String? text;
  bool? selected;
  VoidCallback? onTap;
  ItemBox({this.text, this.image, this.selected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 15),
        width: 26.6 * SizeConfig.widthMultiplier,
        height: 14.6 * SizeConfig.heightMultiplier,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            border: Border.all(
                color:
                    selected! ? complementary : Colors.grey.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Expanded(
                child: CachedNetworkImage(
              imageUrl: image!,
              height: 6.1 * SizeConfig.heightMultiplier,
            )),
            SizedBox(
              height: 15,
            ),
            Text(
              text!,
              style: kBold400.copyWith(
                  color: Colors.black26,
                  fontSize: 1.7 * SizeConfig.textMultiplier),
            )
          ],
        ),
      ),
    );
  }
}

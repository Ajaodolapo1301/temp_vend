

import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
class DeliveryTypeWidget extends StatelessWidget {
  String? image;
  String? text;
  bool? selected;
  VoidCallback? onTap;
  DeliveryTypeWidget({this.text, this.image, this.selected, this.onTap});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 5),
        width: 27.7 * SizeConfig.widthMultiplier,


        decoration: BoxDecoration(
            border: Border.all(color: selected! ?  complementary : Colors.grey.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(imageUrl:image!, height: 4.1 * SizeConfig.heightMultiplier, width: 8.8 * SizeConfig.widthMultiplier ,),
            const SizedBox(width:10,),
            Text(text!, style: kBold400.copyWith(color: Colors.black, fontSize: 1.7 * SizeConfig.textMultiplier),)
          ],
        ),
      ),
    );
  }
}

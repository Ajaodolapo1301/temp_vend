import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';

class HomeCard extends StatelessWidget {
  final String? imagePath;
  final bool? isSvg;
  final String? mainText;
  final String? subText;
  final Color? color;
  final VoidCallback? onTap;
  const HomeCard(
      {Key? key,
      this.imagePath,
      this.mainText,
      this.subText,
      this.color,
      this.onTap,
      this.isSvg = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 19.8 * SizeConfig.heightMultiplier,
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSvg!
                ? SvgPicture.asset(
                    imagePath!,
                    height: 4.8 * SizeConfig.heightMultiplier,
                  )
                : Image.asset(
                    imagePath!,
                    height: 4.8 * SizeConfig.heightMultiplier,
                  ),
            const SizedBox(height: 6),
            Text(
              mainText!,
              style: TextStyle(
                color: kTitleTextfieldColor,
                fontWeight: FontWeight.w500,
                fontSize: 1.8 * SizeConfig.textMultiplier,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subText!,
              style: TextStyle(
                color: const Color(0xff666E7A),
                fontSize: 1.2 * SizeConfig.textMultiplier,
              ),
            )
          ],
        ),
      ),
    );
  }
}

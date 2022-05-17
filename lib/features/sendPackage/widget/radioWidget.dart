import 'package:flutter/material.dart';

import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../model/radioModel.dart';

class ColorSelectorItem extends StatelessWidget {
  // final Color selectedColor;
  // final Color color;
  // final String colorText;
  final RadioModel? items;

  const ColorSelectorItem(
      {Key? key,
      // this.virtualCardDesign,
      this.items
      // // @required this.selectedColor,
      // @required this.color,
      // @required this.colorText,
      // @required this.onTap,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Icon(
                Icons.check,
                size: 8,
                color: items!.isSelected! ? Colors.white : lightBlue,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: items!.isSelected! ? complementary : Colors.white,
                border: Border.all(
                  color: items!.isSelected! ? lightBlue : primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${items!.text} ",
                  style: TextStyle(
                    color: const Color(0xff515151),
                    fontSize: 1.7 * SizeConfig.textMultiplier,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

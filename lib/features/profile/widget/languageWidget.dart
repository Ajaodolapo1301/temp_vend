import 'package:flutter/material.dart';

import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../model/languageModel.dart';

class LanguageWidget extends StatelessWidget {
  final LanguageModel? items;

  const LanguageWidget({Key? key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: kTitleTextfieldColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${items!.text} ",
                  style: TextStyle(
                    color: kTitleTextfieldColor,
                    fontSize: 1.9 * SizeConfig.textMultiplier,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
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
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                color: items!.isSelected!
                    ? complementary
                    : const Color(0xffE2E7ED),
                border: Border.all(
                  color:
                      items!.isSelected! ? lightBlue : const Color(0xffE2E7ED),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

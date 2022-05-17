import 'package:flutter/material.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../model/myOrderModel.dart';

Widget orderWidget(
    MyOrderModel? orderModel, bool isCompleted, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
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
              Container(
                width: 26.6 * SizeConfig.widthMultiplier,
                padding: const EdgeInsets.all(7),
                color: isCompleted
                    ? const Color(0xffeaf8d5)
                    : const Color(0xffd8d8e3),
                child: Center(
                    child: Text(
                  isCompleted ? "Completed" : "In Progress",
                  style: kBold500.copyWith(
                      color: isCompleted ? green : complementary,
                      fontSize: 1.4 * SizeConfig.textMultiplier),
                )),
              ),
              Text(
                "ID: ${orderModel!.trackingId.toString()}",
                style: kBold700.copyWith(color: const Color(0xff979797)),
              ),
            ],
          ),
          SizedBox(
            height: sixteen,
          ),
          RichText(
              text: TextSpan(
                  style: TextStyle(color: kTitleTextfieldColor),
                  children: [
                TextSpan(
                    text: orderModel.receiverInfo!.receiverName,
                    style: kBold700.copyWith(
                        fontSize: 1.7 * SizeConfig.textMultiplier)),
                TextSpan(
                    text: " | ",
                    style: kBold400.copyWith(
                        fontSize: 1.7 * SizeConfig.textMultiplier,
                        color: Colors.black.withOpacity(0.6))),
                TextSpan(
                    text:
                        "+234 ${orderModel.receiverInfo!.receiverPhoneNumber}",
                    style: kBold400.copyWith(
                        fontSize: 1.7 * SizeConfig.textMultiplier,
                        color: Colors.black26))
              ])),
          const SizedBox(
            height: 5,
          ),
          Text(
            orderModel.receiverInfo!.destinationAddress!,
            overflow: TextOverflow.ellipsis,
            style: kBold400.copyWith(
              color: Colors.black.withOpacity(0.3),
            ),
          )
        ],
      ),
    ),
  );
}

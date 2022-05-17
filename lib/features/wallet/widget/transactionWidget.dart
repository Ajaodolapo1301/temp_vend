import 'package:flutter/material.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/myUtils/myUtils.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../model/walletHistoryModel.dart';

class TransactionWidget extends StatelessWidget {
  final WalletHistoryModel? walletHistoryModel;

  TransactionWidget({this.walletHistoryModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: walletHistoryModel!.type == "credit" ? green : orange,
                ),
                padding: const EdgeInsets.all(9),
                child: Transform.rotate(
                    angle: walletHistoryModel!.type == "credit" ? 4.7 : 1.55,
                    child: const Icon(
                      Icons.arrow_right_alt,
                      color: Colors.white,
                    )),
              ),
              SizedBox(
                width: 2 * SizeConfig.heightMultiplier,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    capitalize(walletHistoryModel!.title!),
                    style: kBold500.copyWith(
                        fontSize: 1.7 * SizeConfig.textMultiplier),
                  ),
                  Text(
                    MyUtils.formatDate(walletHistoryModel!.createdAt!) ?? "",
                    style: kBold400.copyWith(
                        fontSize: 1.2 * SizeConfig.textMultiplier),
                  )
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                walletHistoryModel!.type!.toUpperCase(),
                style: kBold400.copyWith(
                    color:
                        walletHistoryModel!.type == "credit" ? green : orange,
                    fontSize: 0.9 * SizeConfig.textMultiplier),
              ),
              Row(
                children: [
                  Text(
                    "₦",
                    style: kBold500.copyWith(
                        fontSize: 1.6 * SizeConfig.textMultiplier,
                        fontFamily: ""),
                  ),
                  Text(
                    walletHistoryModel!.type == "credit"
                        ? "${walletHistoryModel!.amount}"
                        : "${walletHistoryModel!.amount}",
                    style: kBold500.copyWith(
                        fontSize: 1.6 * SizeConfig.textMultiplier),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

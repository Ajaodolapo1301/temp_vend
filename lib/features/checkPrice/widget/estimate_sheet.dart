import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/myUtils/myUtils.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../sendPackage/model/orderModel.dart';
import '../../sendPackage/pages/create_order.dart';
import '../model/checkPriceModel.dart';

class CheckPriceWidget extends StatefulWidget {
  final CheckPriceModel? checkPriceModel;
  final Map? indexes;
  final OrderPayloadModel? orderPayloadModel;
  const CheckPriceWidget(
      {Key? key, this.checkPriceModel, this.orderPayloadModel, this.indexes})
      : super(key: key);

  @override
  _CheckPriceWidgetState createState() => _CheckPriceWidgetState();
}

class _CheckPriceWidgetState extends State<CheckPriceWidget> {
  @override
  Widget build(BuildContext context) {
    // print(widget.indexes);
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height - (height - 430),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), topLeft: Radius.circular(25))),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                InkWell(
                  onTap: () => pop(context),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(),
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
                SvgPicture.asset("${imagePath}wallet/barcode-scanner.svg"),
                Column(
                  children: [
                    SizedBox(
                      height: 2.4 * SizeConfig.heightMultiplier,
                    ),
                    Text(
                      "Estimated Pricing",
                      style: kBold500.copyWith(
                          color: kTitleTextfieldColor,
                          fontSize: 1.8 * SizeConfig.textMultiplier),
                    ),
                    Text(
                      "₦${MyUtils.formatAmount(widget.checkPriceModel!.total.toString())}",
                      style: kBold700.copyWith(
                          color: kTitleTextfieldColor,
                          fontFamily: "",
                          fontSize: 5.5 * SizeConfig.textMultiplier),
                    ),
                    Text(
                      "Price may vary at different time",
                      style: kBold500.copyWith(
                          color: fadedText,
                          fontSize: 1.6 * SizeConfig.textMultiplier),
                    )
                  ],
                ),
              ],
            ),
          ),
          CustomButton(
              text: "Place Order",
              type: ButtonType.outlined,
              textColor: Colors.white,
              onPressed: () {
                pop(context);

                pushReplacementTo(
                  context,
                  CreateOrder(
                    orderPayloadModel: widget.orderPayloadModel,
                    indexes: widget.indexes,
                  ),
                );
                // pushRTo(context, CreateOrder(orderPayloadModel: widget.orderPayloadModel,));
              }),
        ],
      ),
    );
  }
}

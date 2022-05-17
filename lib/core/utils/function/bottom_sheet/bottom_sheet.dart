import 'package:flutter/material.dart';

import '../../../../features/checkPrice/model/checkPriceModel.dart';
import '../../../../features/checkPrice/widget/estimate_sheet.dart';
import '../../../../features/sendPackage/model/orderModel.dart';

var _roundedRectangleBorder = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
  topRight: Radius.circular(25),
  topLeft: Radius.circular(25),
));

// void showCheckPriceSheet({BuildContext context, CreateResponse createResponse  }){
//   showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: _roundedRectangleBorder,
//       builder: (context){
//     return CheckPriceWidget(createResponse: createResponse ,);
//   });
// }

void showCheckPriceSheet2(
    {BuildContext? context,
    CheckPriceModel? checkPriceModel,
    OrderPayloadModel? orderPayloadModel,
    Map? indexes}) {
  showModalBottomSheet(
      context: context!,
      isScrollControlled: true,
      shape: _roundedRectangleBorder,
      builder: (context) {
        return CheckPriceWidget(
          checkPriceModel: checkPriceModel,
          orderPayloadModel: orderPayloadModel,
          indexes: indexes!,
        );
      });
}

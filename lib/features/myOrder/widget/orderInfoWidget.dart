import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/myUtils/myUtils.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../../core/utils/styles/fontSize.dart';
import '../../authentication/viewModel/loginState.dart';
import '../../chat/Pages/widget/answer_call.dart';
import '../model/myOrderModel.dart';

Widget orderInfoWidget(MyOrderModel orderModel,
    {bool? isCompleted,
    String? type,
    String? text,
    String? subtext,
    String? boldText}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        type!,
        style: kBold500.copyWith(
            fontSize: fourteen, color: const Color(0xff666E7A)),
      ),
      const SizedBox(
        height: 8,
      ),
      Container(
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
                Text(
                  boldText!,
                  style: kBold500.copyWith(
                      color: const Color(0xff515151), fontSize: sixteen),
                ),
              ],
            ),
            SizedBox(
              height: sixteen,
            ),
            Text(
              text!,
              style: kBold400.copyWith(color: const Color(0xff666E7A)),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              subtext!,
              style: kBold400.copyWith(color: const Color(0xff666E7A)),
            )
          ],
        ),
      ),
    ],
  );
}

Widget getRiderUI(MyOrderModel orderModel, LoginState? loginState, context,
    VoidCallback onTapMessage) {
  var hour = DateTime.now().hour;
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Rider Info",
          style: kBold500.copyWith(
              fontSize: fourteen, color: const Color(0xff666E7A)),
        ),
        const SizedBox(
          height: 8,
        ),
        Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color(0xffE5E5E5))),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        height: 80.0,
                        width: 80.0,
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 0.0,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.0)),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: orderModel.riderInfo!.profileImageUrl!,
                            placeholder: (context, url) => Image.asset(
                                'assets/images/order/driver_avatar.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            orderModel.riderInfo!.fullName!,
                            style: const TextStyle(
                                color: Color(0xff666E7A),
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 7.0,
                          ),
                          Text(
                            orderModel.riderInfo!.plateNo ?? "",
                            style: const TextStyle(color: Color(0xff666E7A)),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          RatingBar.builder(
                            initialRating: 2,
                            itemSize: 15,
                            minRating: 1,
                            direction: Axis.horizontal,
                            // allowHalfRating: true,
                            itemCount: 5,
                            // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  // new SizedBox(
                  //   height: orderItem.paymentMode != PaymentMode.notPaid ? 15.0 : 0.0,
                  // ),
                  (!isOutsideOfficeHours(hour))
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                String channelName =
                                    loginState!.user.id.toString() +
                                        orderModel.riderInfo!.id.toString() +
                                        "mm";

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => AnswerCall(
                                        receiverToken:
                                            orderModel.riderInfo!.fcmToken!,
                                        callerName:
                                            orderModel.riderInfo!.fullName!,
                                        channelName: channelName,
                                        initiatingCall: true),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: const BoxDecoration(
                                    // color: blue,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/onBoarding/phone.png',
                                      width: 15.0,
                                      height: 20.0,
                                      color: primexBlack,
                                    ),
                                    Text(
                                      "In-App",
                                      style: kBold400.copyWith(
                                          fontSize: 12, color: primexBlack),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            GestureDetector(
                              onTap: () async {
                                await launch(
                                    "tel:" + orderModel.riderInfo!.phone!);
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: const BoxDecoration(
                                      // color: Colors.deepOrange,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/onBoarding/phone.png',
                                        width: 15.0,
                                        color: primexBlack,
                                        height: 20.0,
                                      ),
                                      Text(
                                        " Phone",
                                        style: kBold400.copyWith(
                                            fontSize: 12, color: primexBlack),
                                      )
                                    ],
                                  )),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            GestureDetector(
                              onTap: onTapMessage,
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: const BoxDecoration(
                                    // color: Colors.green,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/onBoarding/envelope.png',
                                      width: 15.0,
                                      color: primexBlack,
                                      height: 20.0,
                                    ),
                                    Text(
                                      "  Chat ",
                                      style: kBold400.copyWith(
                                          fontSize: 12, color: primexBlack),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      : Container(
                          height: 0.0,
                        ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    ),
  );
}

bool isOutsideOfficeHours(int hour) {
  return isBeforeOpening(hour) || afterClosing(hour);
}

bool afterClosing(int hour) {
  // We close by 16:00
  // Check if hour is between 16 to 23
  // Used regex when closing time was 18:00 and hardcoded.
  // return new RegExp(r'(1[89]|2[0-3])').hasMatch(hour.toString());
  return MyUtils.closingTime.hour <= hour && hour <= 23;
}

bool isBeforeOpening(int hour) {
  // We open by 8:00
  // Check if hour is between 0 to 7
  // return new RegExp(r'\b([0-7])\b').hasMatch(hour.toString());
  return 0 <= hour && hour <= (MyUtils.openingTime.hour - 1);
}

String closedMessage(bool isBeforeOpening) => 'We are still taking orders, but '
    'they will be fulfilled by 8:00 AM ${isBeforeOpening ? 'today' : 'tomorrow'}.';

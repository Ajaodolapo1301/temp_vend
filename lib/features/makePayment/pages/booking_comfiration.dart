import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../dashboard/screens/home.dart';
import '../../sendPackage/model/createOrderResponse.dart';
import '../../trackOrder/pages/track.dart';

class BookingConfirmation extends StatefulWidget {
  final CreateResponse? createResponse;
  const BookingConfirmation({Key? key, this.createResponse}) : super(key: key);

  @override
  _BookingConfirmationState createState() => _BookingConfirmationState();
}

class _BookingConfirmationState extends State<BookingConfirmation> {
  bool applyCoupon = false;
  CreateResponse? createResponse;
  @override
  void initState() {
    createResponse = widget.createResponse;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        pushToAndClearStack(context, const Home());
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          label: "Booking Confirmation",
          showLead: false,
          cancel: true,
          showAction: true,
          preferredBackAction: () {
            pushToAndClearStack(context, Home());
          },
        ),
        // kAppBar("Booking Confirmation", showLead: false, cancel: true, showAction: true, onPress: () => pushToAndClearStack(context, const Home())),
        body: SafeArea(
          bottom: false,
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 2.5 * SizeConfig.heightMultiplier,
                      ),
                      SvgPicture.asset("${imagePath}makePayment/book.svg"),
                      SizedBox(
                        height: 4.5 * SizeConfig.heightMultiplier,
                      ),
                      Container(
                          padding: const EdgeInsets.all(20),
                          width: 72.8 * SizeConfig.widthMultiplier,
                          child: Text(
                            "Your Order has been successfully booked",
                            textAlign: TextAlign.center,
                            style: kBold500.copyWith(
                                fontSize: 2.4 * SizeConfig.textMultiplier,
                                color: const Color(0xff898A8D)),
                          )),
                      Text(
                        "Tracking ID",
                        style: kBold500.copyWith(
                            fontSize: 1.9 * SizeConfig.textMultiplier,
                            color: const Color(0xff515151)),
                      ),
                      GestureDetector(
                          onTap: () {
                            toast("Copied to Clipboard");
                            Clipboard.setData(ClipboardData(
                                text: createResponse!.trackingId ?? ""));
                          },
                          child: Text(createResponse!.trackingId!,
                              style: kBold500.copyWith(
                                  fontSize: 3.4 * SizeConfig.textMultiplier,
                                  color: const Color(0xff515151)))),
                      SizedBox(
                        height: 2.8 * SizeConfig.heightMultiplier,
                      ),
                      GestureDetector(
                        onTap: () {
                          toast("Copied to Clipboard");
                          Clipboard.setData(ClipboardData(
                              text: createResponse!.trackingId ?? ""));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.file_copy_outlined,
                              size: 15,
                              color: Color(0xffC6C6C6),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Copy",
                              style: kBold500.copyWith(
                                  color: const Color(0xffC6C6C6)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 4.5 * SizeConfig.heightMultiplier,
                  ),
                  CustomButton(
                      text: "Check Status",
                      type: ButtonType.outlined,
                      textColor: Colors.white,
                      onPressed: () {
                        pushReplacementTo(context, TrackOrder());
                      }),
                  SizedBox(
                    height: 3.5 * SizeConfig.heightMultiplier,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

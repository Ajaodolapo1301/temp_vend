import 'package:flutter/material.dart';

import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../checkPrice/pages/check_price.dart';
import '../../sendPackage/pages/create_order.dart';
import '../../trackOrder/pages/track.dart';
import 'home_card.dart';

class DashboardView extends StatefulWidget {
  final VoidCallback? onOrderHistory;
  final AnimationController? fadeController;

  const DashboardView({Key? key, this.onOrderHistory, this.fadeController})
      : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: HomeCard(
                      imagePath: "assets/images/dashboard/parcel.svg",
                      mainText: "Send Package",
                      subText: "Send your packages at your convenience.",
                      color: boxColor,
                      onTap: () {
                        pushTo(context, const CreateOrder());
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: HomeCard(
                      imagePath: "assets/images/dashboard/track.svg",
                      mainText: "Track Order",
                      subText: "Send your packages at your convenience.",
                      color: boxColor,
                      onTap: () {
                        pushTo(context, TrackOrder());
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: HomeCard(
                      isSvg: false,
                      imagePath: "assets/images/dashboard/Group.png",
                      mainText: "Check Price",
                      subText: "Access finances to grow your business.",
                      color: boxColor,
                      onTap: () {
                        pushTo(context, CheckPrice());
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: HomeCard(
                      imagePath: "assets/images/dashboard/order_dash.svg",
                      mainText: "Order History",
                      subText: "Send your packages at your convenience.",
                      color: boxColor,
                      onTap: widget.onOrderHistory!,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

//
  @override
  bool get wantKeepAlive => true;
}

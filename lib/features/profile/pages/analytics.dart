import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/function/snaks.dart';
import '../../authentication/viewModel/loginState.dart';
import '../model/analyticsModel.dart';
import '../viewModel/profileViewModel.dart';
import '../widget/analyticsWidget.dart';

class Analytics extends StatefulWidget {
  const Analytics({Key? key}) : super(key: key);

  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics>
    with AfterLayoutMixin<Analytics> {
  ProfileState? profileState;
  LoginState? loginState;
  AnalyticsModel? analyticsModel;
  @override
  Widget build(BuildContext context) {
    profileState = Provider.of<ProfileState>(context);

    loginState = Provider.of<LoginState>(context);
    return Scaffold(
        appBar: const CustomAppBar(
          label: "Analytics",
        ),

        // kAppBar("Analytics", onPress: ()=> pop(context), ),

        body: Builder(
          builder: (context) {
            if (profileState!.busy) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (analyticsModel == null) {
              return const Center(child: Text("No data found"));
            }
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Column(
                children: [
                  AnalyticsWidget(
                    title: "Total Deliveries",
                    subtitle: "${analyticsModel!.completed} Deliveries",
                    subtitleColor: const Color(0xffFF881D),
                    color: const Color(0xffFEF1DA),
                  ),
                  AnalyticsWidget(
                    title: "Total Amount Spent",
                    subtitle: "${analyticsModel!.totalAmount} Spent ",
                    subtitleColor: const Color(0xff035D9F),
                    color: const Color(0xffE4DBFA),
                  ),
                  AnalyticsWidget(
                    title: "Total Order",
                    subtitle: "${analyticsModel!.totalOrder} Order",
                    subtitleColor: const Color(0xff3296FB),
                    color: const Color(0xffEDF6FF),
                  ),
                  AnalyticsWidget(
                    title: "Total cancelled",
                    subtitle: "${analyticsModel!.cancelled} Cancelled",
                    subtitleColor: const Color(0xff3296FB),
                    color: const Color(0xffEDF6FF),
                  )
                ],
              ),
            );
          },
        ));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getAnalytics();
  }

  getAnalytics() async {
    var result = await profileState!.analytics(token: loginState!.user.token);
    result.fold((l) => kShowSnackBar(context, l.props.first.toString()), (r) {
      setState(() {
        analyticsModel = r;
      });
    });
  }
}

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/function/snaks.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../Notification/pages/notification.dart';
import '../../authentication/viewModel/loginState.dart';
import '../../wallet/pages/fundWallet.dart';
import '../../wallet/viewModel/walletState.dart';
import '../widget/dashboard_view.dart';
import '../widget/walletBalanceWidget.dart';

class DashBoardPage extends StatefulWidget {
  final VoidCallback? onOrderHistory;
  const DashBoardPage({Key? key, this.onOrderHistory}) : super(key: key);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage>
    with AfterLayoutMixin<DashBoardPage> {
  LoginState? loginState;
  WalletState? walletState;
  @override
  Widget build(BuildContext context) {
    loginState = Provider.of<LoginState>(context);
    // print(loginState.user.id);
    walletState = Provider.of<WalletState>(context);
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: Container(),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.black,
              ),
              color: Colors.black,
              onPressed: () {
                pushTo(context, NotifyScreen());
              })
        ],
        title: Text(
          "Hex Logistics",
          style: kBold700.copyWith(
              color: Colors.black, fontSize: 2.2 * SizeConfig.textMultiplier),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 3.9 * SizeConfig.heightMultiplier,
              ),
              Expanded(
                  child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 20, right: 20, top: 37),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello ${loginState!.user.fullName},",
                          style: TextStyle(
                              fontSize: 2.2 * SizeConfig.textMultiplier,
                              color: kTitleTextfieldColor,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "What are you looking to do today?",
                          style: TextStyle(
                              fontSize: 1.7 * SizeConfig.textMultiplier,
                              color: kTitleTextfieldColor,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 1.8 * SizeConfig.heightMultiplier,
                        ),
                        WalletBalanceWidget(
                          backgroundImage: "${imagePath}dashboard/Oval.png",
                          color: complementary,
                          onPress: () {
                            pushTo(context, FundWalletPage());
                          },
                          balance: walletState?.walletBalance.balance ?? "0.00",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.9 * SizeConfig.heightMultiplier,
                    ),
                    Expanded(
                        child: DashboardView(
                      onOrderHistory: widget.onOrderHistory!,
                    ))
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  void getWalletBalance() async {
    var result =
        await walletState!.fetchWalletBalance(token: loginState!.user.token);
    result.fold((l) => kShowSnackBar(context, l.props.first.toString()), (r) {
      // print(r);
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getWalletBalance();
  }
}

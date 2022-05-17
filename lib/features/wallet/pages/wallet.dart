import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/function/snaks.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../authentication/viewModel/loginState.dart';
import '../../dashboard/widget/walletBalanceWidget.dart';
import '../viewModel/walletState.dart';
import '../widget/transactionWidget.dart';
import 'fundWallet.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage>
    with AfterLayoutMixin<WalletPage> {
  var txRef = "primexFundRef-${DateTime.now().millisecondsSinceEpoch}";

  bool isloading = true;

  WalletState? walletState;
  LoginState? loginState;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    walletState = Provider.of<WalletState>(context);
    loginState = Provider.of<LoginState>(context);

    return Scaffold(
      // appBar:  kAppBar("Wallet", showLead: false, showAction: false),

      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 3.8 * SizeConfig.heightMultiplier,
              ),
              // WalletBalanceWidget(
              //   backgroundImage:  "${imagePath}dashboard/ovalBlue.png",
              //   color: green,
              //   onPress: (){
              //     pushTo(context, FundWalletPage()).then((value) {
              //       getWalletBalance();
              //     });
              //    // pushTo(context, TransactionConfirmation(isSuccess: false,));
              //   },
              //   balance:"${walletState.walletBalance.balance}",
              // ),

              WalletBalanceWidget(
                backgroundImage: "${imagePath}dashboard/Oval.png",
                color: complementary,
                onPress: () {
                  pushTo(context, FundWalletPage()).then((value) {
                    getWalletBalance();
                  });
                  // pushTo(context, TransactionConfirmation(isSuccess: false,));
                },
                balance: "${walletState?.walletBalance?.balance ?? "0.00"}",
              ),
              SizedBox(
                height: 3.8 * SizeConfig.heightMultiplier,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Transaction History",
                    style: kBold500.copyWith(color: fadedText),
                  ),
                  SizedBox(
                    height: 1.8 * SizeConfig.heightMultiplier,
                  ),
                ],
              ),

              Expanded(
                child: RefreshIndicator(
                  onRefresh: pull,
                  child: Builder(builder: (context) {
                    if (isloading) {
                      return Center(child: CupertinoActivityIndicator());
                    } else if (walletState!.walletHistory.isEmpty) {
                      return SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                    "${imagePath}wallet/transaction-history.png"),
                                SizedBox(
                                  height: 5 * SizeConfig.heightMultiplier,
                                ),
                                Text(
                                  "No wallet transaction",
                                  style: kBold700.copyWith(
                                      fontSize:
                                          2.2 * SizeConfig.textMultiplier),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 3.6 * SizeConfig.heightMultiplier,
                          );
                        },
                        itemBuilder: (context, index) {
                          return TransactionWidget(
                            walletHistoryModel:
                                walletState!.walletHistory[index],
                          );
                        },
                        itemCount: walletState!.walletHistory.length,
                      );
                    }
                  }),
                ),
              )
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
      print(r);
    });
  }

  Future<void> pull() async {
    getWallethistoryPull();
  }

  void getWallethistoryPull() async {
    var result =
        await walletState!.getTransaction(token: loginState!.user.token);
    result.fold((l) => kShowSnackBar(context, l.props.first.toString()), (r) {
      print(r);
    });
  }

  void getWallethistory() async {
    var result =
        await walletState!.getTransaction(token: loginState!.user.token);
    setState(() {
      isloading = false;
    });
    result.fold((l) => kShowSnackBar(context, l.props.first.toString()), (r) {
      print(r);
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getWalletBalance();
    getWallethistory();
  }
}

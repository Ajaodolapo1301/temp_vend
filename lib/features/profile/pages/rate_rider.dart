import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/GlobalState/appState.dart';
import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/emoji.dart';
import '../../../core/utils/function/snaks.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../core/widget/loading_overlay_widget.dart';
import '../../authentication/viewModel/loginState.dart';
import '../../myOrder/viewModel/myOrderViewModel.dart';

class RateRider extends StatefulWidget {
  final String? id;
  RateRider({Key? key, this.id}) : super(key: key);

  @override
  _RateRiderState createState() => _RateRiderState();
}

class _RateRiderState extends State<RateRider> {
  MyOrderViewModel? myOrderViewModel;
  LoginState? loginState;
  AppState? appState;
  int score = 0;
  @override
  Widget build(BuildContext context) {
    myOrderViewModel = Provider.of<MyOrderViewModel>(context);
    loginState = Provider.of<LoginState>(context);
    appState = Provider.of<AppState>(context);
    return LoadingOverlayWidget(
      loading: myOrderViewModel!.busy,
      child: Scaffold(
        appBar: const CustomAppBar(
          label: "Rate Order",
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
// SizedBox(height: 69,),
                Column(
                  children: [
                    Text(
                      "How was our service?",
                      style: kBold500.copyWith(
                          fontSize: eighteen, color: kTitleTextfieldColor),
                    ),
                    Text(
                      "Kindly rate with the show of  the emoji",
                      style: kBold400.copyWith(
                          fontSize: 14, color: kTitleTextfieldColor),
                    ),
                    const SizedBox(
                      height: 69,
                    ),
                    EmojiFeedback(
                      onChange: (index) {
                        setState(() {
                          score = index + 1;
                        });
                        print(score);
                      },
                    ),
                  ],
                ),
                // SizedBox(height: 69,),

                CustomButton(
                  text: "Rate Order",
                  color: primaryColor,
                  type: ButtonType.outlined,
                  onPressed: () {
                    rate();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void rate() async {
    var res = await myOrderViewModel!.rateOrder(
        token: loginState!.user.token, order_id: widget.id, score: score);
    res.fold((l) => kShowSnackBar(context, l.props.first.toString()), (r) {
      appState!.successDialog(context, r, () {
        pop(context);
        // pop(context);
        // pushReplacementTo(context, Home());
      });
    });
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/preloader/preLoadr.dart';
import '../../../core/utils/function/snaks.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../core/utils/widgets/custom_text_field.dart';
import '../../authentication/viewModel/loginState.dart';
import '../viewModel/trackOrderViewModel.dart';
import 'orderStatus.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({Key? key}) : super(key: key);

  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  TrackOrderViewModel? trackOrderViewModel;
  final _formKey = GlobalKey<FormState>();
  LoginState? loginState;

  String? trackId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    trackOrderViewModel = Provider.of<TrackOrderViewModel>(context);
    loginState = Provider.of<LoginState>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        label: "Track Order",
        showLead: true,
      ),

      // kAppBar("Track Order", showLead: true, onPress: ()=> pop(context)),

      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 2.5 * SizeConfig.heightMultiplier,
              ),
              Expanded(
                  child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      height: 19.8 * SizeConfig.heightMultiplier,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text(
                                "Input your delivery number to track sendPackage details",
                                style: kBold700.copyWith(
                                    color: Colors.white,
                                    fontSize: 2.2 * SizeConfig.textMultiplier),
                              )),
                          Expanded(
                              child: Image.asset("${imagePath}wallet/map.png"))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.3 * SizeConfig.heightMultiplier,
                    ),
                    CustomTextField(
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Empty";
                        }
                        trackId = v;
                        return null;
                      },
                      header: "Tracking ID",
                      hint: "LA345678",
                    ),
                    RichText(
                        text: TextSpan(
                            style: kBold500.copyWith(
                                color: kTitleTextfieldColor,
                                fontSize: 1.7 * SizeConfig.textMultiplier),
                            children: const <TextSpan>[
                          TextSpan(text: "Contact "),
                          TextSpan(
                              text: "Customer Care",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.black)),
                          TextSpan(text: " if having any difficulty")
                        ]))
                  ],
                ),
              )),
              CustomButton(
                  text: "Track Order",
                  type: ButtonType.outlined,
                  textColor: Colors.white,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // pushTo(context, OrderStatus());
                      tracking();
                    }
                  }),
              SizedBox(
                height: 4.5 * SizeConfig.heightMultiplier,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void tracking() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Preloader();
        });
    var res = await trackOrderViewModel!
        .trackOrder(id: trackId, token: loginState!.user.token);
    pop(context);
    res.fold(
        (l) => kShowSnackBar(
            context, l.props.first.toString() ?? "An Error Occurred"), (r) {
      pushTo(
          context,
          OrderStatus(
            trackOrderModel: r,
          ));
    });
  }
}

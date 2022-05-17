import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/keyConstants.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../dashboard/screens/home.dart';
import '../model/initialModel.dart';
import '../model/user.dart';
import '../viewModel/loginState.dart';
import 'login.dart';
import 'onboardingScreen/onboardingScreen.dart';

class SplashPage extends StatefulWidget {
  final bool? hasNotUserUsedApp;
  final User? user;

  const SplashPage({Key? key, this.hasNotUserUsedApp, this.user})
      : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with AfterLayoutMixin<SplashPage> {
  LoginState? loginState;
  InitialModel? initialModel;
  @override
  void initState() {
    //  Timer(Duration(seconds: 3), () {
    //  !widget.hasNotUserUsedApp && widget.user == null ? pushReplacementToWithRoute(context, CustomRoutes.fadeIn(LoginPage())) : widget.user != null ? pushToAndClearStack(context, Home()) :
    // pushToAndClearStack(context, OnboardingPage());
    //  });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loginState = Provider.of(context);
    return Scaffold(
      backgroundColor: primaryColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Column(
              children: [
                Text("Hex Logistics",
                    style: TextStyle(
                        fontSize: 4.3 * SizeConfig.textMultiplier,
                        color: Colors.black,
                        fontWeight: FontWeight.w700)),
                Text(tagline ?? "",
                    style: TextStyle(
                        fontSize: 1.3 * SizeConfig.textMultiplier,
                        color: Colors.black,
                        fontWeight: FontWeight.w400)),
              ],
            ))
          ],
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getInitals();
  }

  void getInitals() async {
    var res = await loginState!.getInitials();
    res.fold((l) => null, (r) {
      print(r);
      initialModel = r;
      initialModel!.brandColor?.forEach((element) {
        print("element${element.name}");
        if (element.name == "main_brand_color") {
          var col = element.value!.replaceAll("#", "0xff");
          primaryColor = Color(int.parse(col));
        } else if (element.name == "complementary_brand_color") {
          var col = element.value!.replaceAll("#", "0xff");
          complementary = Color(int.parse(col));
        }
      });
      !widget.hasNotUserUsedApp! && widget.user == null
          ? pushReplacementToWithRoute(
              context, CustomRoutes.fadeIn(LoginPage()))
          : widget.user != null
              ? pushToAndClearStack(context, Home())
              : pushToAndClearStack(context, OnboardingPage());

      // ColorUtils().initEnv(initialModel.brandColor)
    });
  }
}

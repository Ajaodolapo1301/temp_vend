import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:vend_express/features/profile/pages/privacy_policy.dart';
import 'package:vend_express/features/profile/pages/rate.dart';

import '../../../core/GlobalState/appState.dart';
import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/myUtils/myUtils.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../authentication/screens/login.dart';
import '../../authentication/viewModel/loginState.dart';
import '../widget/buildListTile.dart';
import '../widget/divider.dart';
import 'account_page.dart';
import 'analytics.dart';
import 'contact_us.dart';
import 'edit_profile.dart';
import 'faqScreen.dart';
import 'report.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AfterLayoutMixin<ProfilePage> {
  AppState? appState;
  LoginState? loginState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context);
    loginState = Provider.of(context);
    // print(loginState.user.token);
    return Scaffold(
      appBar: CustomAppBar(label: "Profile", showLead: false),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 2.4 * SizeConfig.heightMultiplier,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        pushTo(context, EditPage());
                      },
                      child: Container(
                        height: 12 * SizeConfig.heightMultiplier,
                        width: 26.1 * SizeConfig.widthMultiplier,
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 0.0,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.0)),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: loginState!.user!.profileImageUrl!,
                            placeholder: (context, url) => Image.asset(
                                'assets/images/order/driver_avatar.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        decoration: const BoxDecoration(

                            // color: Colors.blue,
                            shape: BoxShape.circle),
                      ),
                    ),
                    Text(
                      loginState!.user.fullName!,
                      style: kBold700.copyWith(
                          fontSize: 2.2 * SizeConfig.textMultiplier),
                    ),
                    Text(
                      loginState!.user.email!,
                      style: kBold400.copyWith(
                          fontSize: 1.7 * SizeConfig.textMultiplier,
                          color: kTitleTextfieldColor),
                    )
                  ],
                ),
                SizedBox(
                  height: 2.4 * SizeConfig.heightMultiplier,
                ),
                Column(
                  children: [
                    buildListTile(
                      subTitle: "",
                      title: "My Statistics",
                      onTap: () {
                        pushTo(context, Analytics());
                      },
                    ),
                    divider(),
                    buildListTile(
                      title: "Account Settings",
                      subTitle: "",
                      onTap: () {
                        pushTo(context, AccountPage());
                      },
                    ),
                    divider(),
                    buildListTile(
                      title: "FAQ",
                      subTitle: "",
                      onTap: () {
                        pushTo(context, FaqScreen());
                      },
                    ),
                    divider(),
                    buildListTile(
                      title: "Privacy Policy",
                      subTitle: "",
                      onTap: () {
                        pushTo(context, PrivacyPolicy());
                      },
                    ),
                    divider(),
                    buildListTile(
                      title: "Rate and Review App",
                      subTitle: "",
                      onTap: () {
                        pushTo(context, RatePage());
                      },
                    ),
                    divider(),
                    buildListTile(
                      title: "Contact Us",
                      subTitle: "",
                      onTap: () {
                        pushTo(
                            context,
                            TawkPage(
                              email: loginState!.user.email,
                              fullName: loginState!.user.fullName,
                            ));
                      },
                    ),
                    divider(),
                    buildListTile(
                      title: "Report a problem",
                      subTitle: "",
                      onTap: () {
                        pushTo(context, Report());
                      },
                    ),
                    divider(),
                    buildListTile(
                      title: "Logout",
                      subTitle: "",
                      onTap: () {
                        Platform.isIOS
                            ? MyUtils.showIOSAreYouSureDialog(context,
                                mainText: "Logout",
                                subtext: "Are you sure you want to logout",
                                leftText: "Cancel",
                                rightText: "Ok", onClose: () {
                                pop(context);
                                final box = Hive.box("user");
                                // final box2 = Hive.box("packageSize");
                                // final box3 = Hive.box("delivery_type");
                                // final box4 = Hive.box("delivery_time");
                                // final box5 = Hive.box("balance");
                                box.put('user', null);
                                // box5.put("balance", null);
                                // box2.put("packageSize", null);
                                // box3.put("delivery_type", null);
                                // box4.put("delivery_time", null);

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                    (Route<dynamic> route) => false);
                              })
                            : MyUtils.showAreYouSureDialog(context,
                                mainText: "Logout",
                                subtext: "Are you sure you want to logout",
                                leftText: "Cancel",
                                rightText: "Ok", onClose: () {
                                final box = Hive.box("user");

                                box.put('user', null);

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                    (Route<dynamic> route) => false);
                              });
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
// getuser();
  }
}

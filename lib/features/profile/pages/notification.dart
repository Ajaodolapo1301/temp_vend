import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/function/snaks.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../core/widget/loading_overlay_widget.dart';
import '../../authentication/viewModel/loginState.dart';
import '../model/languageModel.dart';
import '../viewModel/profileViewModel.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with AfterLayoutMixin<NotificationPage> {
  List<LanguageModel> languageData = [];
  LoginState? loginState;
  ProfileState? profileState;
  bool newUpdate = false;
  bool push = false;
  bool sms = false;
  bool email = false;

  bool inAppSound = false;
  bool inAppVib = false;
  Map<String, bool> values = {};
  @override
  void initState() {
    values = {
      "New Update Notification": newUpdate,
      "Push Notification": push,
      "SMS Notification": sms,
      "Email Notification": email,
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loginState = Provider.of<LoginState>(context);
    profileState = Provider.of<ProfileState>(context);
    return LoadingOverlayWidget(
      loading: profileState!.busy,
      child: Scaffold(
        appBar: const CustomAppBar(
          label: "Notification",
        ),
        // kAppBar("Notification", onPress: (){pop(context);
        // } ),

        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.4 * SizeConfig.heightMultiplier,
                  ),
                  const Text("General Notification"),
                  const SizedBox(
                    height: 20,
                  ),

                  Column(
                    children: [
                      CheckboxListTile(
                        activeColor: primaryColor,
                        title: Text(
                          "New Update Notification",
                          style: kBold400.copyWith(
                              fontSize: 1.7 * SizeConfig.textMultiplier),
                        ),
                        value: newUpdate,
                        onChanged: (newValue) {
                          setState(() {
                            newUpdate = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .trailing, //  <-- leading Checkbox
                      ),
                      CheckboxListTile(
                        activeColor: complementary,
                        title: Text(
                          "Push Notification",
                          style: kBold400.copyWith(
                              fontSize: 1.7 * SizeConfig.textMultiplier),
                        ),
                        value: push,
                        onChanged: (newValue) {
                          setState(() {
                            push = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .trailing, //  <-- leading Checkbox
                      ),
                      CheckboxListTile(
                        activeColor: complementary,
                        title: Text(
                          "SMS Notification",
                          style: kBold400.copyWith(
                              fontSize: 1.7 * SizeConfig.textMultiplier),
                        ),
                        value: sms,
                        onChanged: (newValue) {
                          setState(() {
                            sms = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .trailing, //  <-- leading Checkbox
                      ),
                      CheckboxListTile(
                        activeColor: complementary,
                        title: Text(
                          "Email Notification",
                          style: kBold400.copyWith(
                              fontSize: 1.7 * SizeConfig.textMultiplier),
                        ),
                        value: email,
                        onChanged: (newValue) {
                          setState(() {
                            email = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .trailing, //  <-- leading Checkbox
                      ),
                    ],
                  ),

                  // Column(
                  //   children: values.keys.map((key){
                  //     print(key);
                  //     return CheckboxListTile(
                  //         activeColor: blue,
                  //       title: Text(key, style: kBold400.copyWith(fontSize: 1.7 * SizeConfig.textMultiplier),),
                  //       value: values[key],
                  //       onChanged: (v){
                  //           print(v);
                  //
                  //         setState(() {
                  //           values[key] = v;
                  //         });
                  //       },
                  //     );
                  //   }).toList(),
                  // ),

                  SizedBox(
                    height: 2.4 * SizeConfig.heightMultiplier,
                  ),
                  const Text("In-App Notifications"),
                  SizedBox(
                    height: 2.4 * SizeConfig.heightMultiplier,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "In-App sounds",
                              style: kBold400.copyWith(
                                  fontSize: 1.7 * SizeConfig.textMultiplier),
                            ),
                            Transform.scale(
                              scale: 0.7,
                              child: FlutterSwitch(
                                  activeColor: complementary,
                                  showOnOff: true,
                                  value: inAppSound,
                                  onToggle: (v) {
                                    setState(() {
                                      inAppSound = v;
                                    });
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.4 * SizeConfig.heightMultiplier,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "In-App Vibrate",
                              style: kBold400.copyWith(
                                  fontSize: 1.7 * SizeConfig.textMultiplier),
                            ),
                            Transform.scale(
                              scale: 0.7,
                              child: FlutterSwitch(
                                  activeColor: complementary,
                                  showOnOff: true,
                                  value: inAppVib,
                                  onToggle: (v) {
                                    setState(() {
                                      inAppVib = v;
                                    });
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.4 * SizeConfig.heightMultiplier,
                        ),
                        CustomButton(
                            text: "Save changes",
                            type: ButtonType.outlined,
                            textColor: Colors.white,
                            onPressed: () {
                              updateNotificationSettings();
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    setState(() {
      inAppSound = loginState!.user.inAppSound!;
      inAppVib = loginState!.user.inAppVibrate!;
      push = loginState!.user.pushNotification!;
      newUpdate = loginState!.user.newUpdateNotification!;
      sms = loginState!.user.smsNotification!;
      email = loginState!.user.emailNotification!;
    });
  }

  void getuser() async {
    var res = await loginState!
        .getUser(token: loginState!.user.token, id: loginState!.user.id);
    res.fold((l) {
      kShowSnackBar(context, l.props.first.toString());
    }, (r) {});
  }

  void updateNotificationSettings() async {
    var res = await profileState!.notificationSettings(
        new_update_notification: newUpdate ? 1 : 0,
        push_notification: push ? 1 : 0,
        sms_notification: sms ? 1 : 0,
        email_notification: email ? 1 : 0,
        in_app_sound: inAppSound ? 1 : 0,
        in_app_vibrate: inAppVib ? 1 : 0,
        token: loginState!.user.token);
    res.fold((l) => kShowSnackBar(context, l.props.first.toString()), (r) {
      toast("Updated");
      getuser();
    });
  }
}

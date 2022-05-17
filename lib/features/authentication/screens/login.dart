import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vend_express/features/authentication/screens/recover_password/recover_password.dart';
import 'package:vend_express/features/authentication/screens/register_page.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/function/snaks.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../core/utils/widgets/custom_text_field.dart';
import '../../../core/utils/widgets/header.dart';
import '../../../core/widget/loading_overlay_widget.dart';
import '../../../translation/locale_keys.g.dart';
import '../../Notification/firebase_notification/push_notification_manager.dart';
import '../../dashboard/screens/home.dart';
import '../viewModel/loginState.dart';
import '../widget/titleTile.dart';
import 'otpScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  var email;
  LoginState? loginState;
  var password;
  bool isVisiblePassword = true;
  @override
  Widget build(BuildContext context) {
    loginState = Provider.of(context);
    return LoadingOverlayWidget(
      loading: loginState?.busy,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${LocaleKeys.dont_have_an_account.tr()}?",
                style: TextStyle(
                    color: kTitleTextfieldColor,
                    fontSize: 1.6 * SizeConfig.textMultiplier,
                    fontWeight: FontWeight.w500),
              ),
              TextButton(
                  onPressed: () => pushTo(context, const RegisterPage()),
                  child: Text(
                    LocaleKeys.Signup,
                    style: TextStyle(
                        color: complementary,
                        fontSize: 1.6 * SizeConfig.textMultiplier,
                        fontWeight: FontWeight.w700),
                  ))
            ],
          ),
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Header(
                  text: "",
                  preferredActionOnBackPressed: () {
                    Navigator.maybePop(context);
                  },
                ),
                SizedBox(
                  height: 6 * SizeConfig.heightMultiplier,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleWidget(
                          mainText:
                              // "welcome",
                              LocaleKeys.welcome_text.tr(),
                          subtext:
                              "Set up your account so we can get to know you.",
                        ),
                        SizedBox(
                          height: 4 * SizeConfig.heightMultiplier,
                        ),
                        Form(
                          key: _formKey,
                          onChanged: () {
                            _formKey.currentState!.validate();
                          },
                          child: Column(
                            children: [
                              CustomTextField(
                                header: LocaleKeys.email_address.tr(),
                                hint: "ajao@xyz.com",
                                type: FieldType.text,
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "Email is required";
                                  } else if (!EmailValidator.validate(
                                      value.replaceAll(" ", "").trim())) {
                                    return "Email is invalid";
                                  }
                                  email = value;
                                  return null;
                                },
                              ),
                              CustomTextField(
                                useMargin: false,
                                obscureText: isVisiblePassword,
                                header: LocaleKeys.Password.tr(),
                                hint: "*********",
                                suffix: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isVisiblePassword =
                                              !isVisiblePassword;
                                        });
                                      },
                                      child: Text(
                                        !isVisiblePassword
                                            ? "HIDE"
                                            : LocaleKeys.show
                                                .tr()
                                                .toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 10, color: complementary),
                                      ),
                                    ),
                                  ],
                                ),
                                type: FieldType.password,
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return "Empty";
                                  }
                                  password = v;
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 2.2 * SizeConfig.heightMultiplier,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        pushTo(context, RecoverPasswordPage());
                                      },
                                      child: Text(
                                        LocaleKeys.forgot_password.tr(),
                                        style: kBold500.copyWith(
                                            fontSize: 1.7 *
                                                SizeConfig.textMultiplier),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 7.3 * SizeConfig.heightMultiplier,
                              ),
                              CustomButton(
                                  text: LocaleKeys.login.tr(),
                                  type: ButtonType.outlined,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      login();
                                    }
                                    // pushTo(context, OTPPage());
                                  }),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    var res = await loginState!.login(email: email, password: password);
    res.fold(
        (l) => kShowSnackBar(context, l.props.first.toString(),
            title: l.otherMessage != null ? l.otherMessage.toString() : ""),
        (r) {
      phoneInfo();
      if (r.onboard != true) {
        pushToAndClearStack(
            context,
            OTPPage(
              user: r,
            ));
      } else {
        pushToAndClearStack(context, Home());
      }
    });
  }

  phoneInfo() async {
    var result = await loginState!.phoneInfo(
        token: loginState?.user.token,
        device_token: PushNotificationsManager.deviceToken);
  }
}

// igeuser@gmail.com
// 111111

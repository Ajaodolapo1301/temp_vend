import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/GlobalState/appState.dart';
import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/function/snaks.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../core/utils/widgets/custom_text_field.dart';
import '../../../core/widget/loading_overlay_widget.dart';
import '../../../translation/locale_keys.g.dart';
import '../../authentication/viewModel/loginState.dart';
import '../../dashboard/screens/home.dart';
import '../viewModel/profileViewModel.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  ProfileState? profileState;
  LoginState? loginState;
  String? accountName;
  String? email;
  String? currentPass;
  String? newPass;
  AppState? appState;
  final _formKey = GlobalKey<FormState>();
  String? confirmpass;
  String? phone;
  bool obscureCurrentPassword = true;

  bool obscureNewPassword = true;

  bool obscureConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    profileState = Provider.of<ProfileState>(context);
    loginState = Provider.of<LoginState>(context);
    appState = Provider.of<AppState>(context);
    return LoadingOverlayWidget(
      loading: profileState?.busy,
      child: Scaffold(
        // backgroundColor: Color(0xffE5E5E5
        // ),
        appBar: const CustomAppBar(
          label: "Change Password",
        ),
        // kAppBar("Change Password", onPress: ()=> pop(context), showAction: true),

        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5.4 * SizeConfig.heightMultiplier,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          obscureText: obscureCurrentPassword,
                          validator: (v) {
                            if (v!.length < 6) {
                              return "Password should be atleast 6 character";
                            }
                            currentPass = v;
                            return null;
                          },
                          header: "Current Password",
                          hint: "*********",
                          suffix: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscureCurrentPassword =
                                        !obscureCurrentPassword;
                                  });
                                },
                                child: Text(
                                  obscureCurrentPassword ? "SHOW" : "HIDE",
                                  style: TextStyle(
                                      fontSize: 10, color: complementary),
                                ),
                              ),
                            ],
                          ),
                          type: FieldType.password,
                        ),
                        CustomTextField(
                          obscureText: obscureNewPassword,
                          validator: (v) {
                            if (v!.length < 6) {
                              return "Password should be atleast 6 character";
                            }
                            newPass = v;
                            return null;
                          },
                          header: "New Password",
                          hint: "*********",
                          suffix: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscureNewPassword = !obscureNewPassword;
                                  });
                                },
                                child: Text(
                                  obscureNewPassword
                                      ? LocaleKeys.show.tr().toUpperCase()
                                      : "HIDE",
                                  style: TextStyle(
                                      fontSize: 10, color: complementary),
                                ),
                              ),
                            ],
                          ),
                          type: FieldType.password,
                        ),
                        CustomTextField(
                          obscureText: obscureConfirmPassword,
                          header: "Confirm Password",
                          validator: (v) {
                            if (v != newPass) {
                              return "Passwords do not match ";
                            }
                            confirmpass = v;
                            return null;
                          },
                          hint: "*********",
                          suffix: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscureConfirmPassword =
                                        !obscureConfirmPassword;
                                  });
                                },
                                child: Text(
                                  obscureConfirmPassword
                                      ? LocaleKeys.show.tr().toUpperCase()
                                      : "HIDE",
                                  style: TextStyle(
                                      fontSize: 10, color: complementary),
                                ),
                              ),
                            ],
                          ),
                          type: FieldType.password,
                        ),
                        SizedBox(
                          height: 7.3 * SizeConfig.heightMultiplier,
                        ),
                        CustomButton(
                            text: "Update Password",
                            type: ButtonType.outlined,
                            textColor: Colors.white,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                changepass();
                              }
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

  void changepass() async {
    var res = await profileState!.changePassword(
        password_confirmation: confirmpass,
        token: loginState!.user.token,
        currentPass: currentPass,
        password: newPass);
    res.fold(
        (l) => kShowSnackBar(context,
            l.props.first.toString().replaceAll("[", "").replaceAll("]", "")),
        (r) => appState!.successDialog(context, r, () {
              pushToAndClearStack(context, Home());
            }));
  }
}

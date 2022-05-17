import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vend_express/core/utils/widgets/header.dart';

import '../../../../core/GlobalState/appState.dart';
import '../../../../core/utils/function/snaks.dart';
import '../../../../core/utils/navigation/navigator.dart';
import '../../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../../core/utils/styles/color_utils.dart';
import '../../../../core/utils/widgets/custom_button.dart';
import '../../../../core/utils/widgets/custom_text_field.dart';
import '../../../../core/widget/loading_overlay_widget.dart';
import '../../viewModel/loginState.dart';
import '../login.dart';

class UpdatePasswordPage extends StatefulWidget {
  final String? otp;
  final String? phone;
  final String? pin_id;
  const UpdatePasswordPage({Key? key, this.phone, this.pin_id, this.otp})
      : super(key: key);

  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  var password;
  var confirmPassword;
  bool isVisiblePassword = false;
  bool isVisibleConfirmPassword = false;

  LoginState? loginState;
  AppState? appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of(context);
    loginState = Provider.of<LoginState>(context);
    return LoadingOverlayWidget(
      loading: loginState?.busy,
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Header(
                  text: "",
                  preferredActionOnBackPressed: () {},
                ),
                SizedBox(
                  height: 6 * SizeConfig.heightMultiplier,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Update Password",
                              style: TextStyle(
                                  fontSize: 2.9 * SizeConfig.textMultiplier,
                                  color: kTitleTextfieldColor,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Enter new password to get your account running",
                              style: TextStyle(
                                  fontSize: 1.7 * SizeConfig.textMultiplier,
                                  color: kTitleTextfieldColor,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4 * SizeConfig.heightMultiplier,
                        ),
                        Expanded(
                          child: Form(
                            key: _formKey,
                            onChanged: () {
                              _formKey.currentState!.validate();
                            },
                            child: Column(
                              children: [
                                CustomTextField(
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return "Password is Required";
                                    }
                                    password = v;
                                    return null;
                                  },
                                  obscureText: isVisiblePassword,
                                  header: "New Password",
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
                                          isVisiblePassword ? "HIDE" : "SHOW",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: primaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  type: FieldType.password,
                                ),
                                CustomTextField(
                                  validator: (input) {
                                    if (input!.isEmpty) {
                                      return "Empty";
                                    } else if (input != password) {
                                      return "Passwords do not match";
                                    }
                                    confirmPassword = input;
                                    return null;
                                  },
                                  obscureText: isVisibleConfirmPassword,
                                  header: "Confirm Password",
                                  hint: "*********",
                                  suffix: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isVisibleConfirmPassword =
                                                !isVisibleConfirmPassword;
                                          });
                                        },
                                        child: Text(
                                          isVisibleConfirmPassword
                                              ? "HIDE"
                                              : "SHOW",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: primaryColor),
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
                                    text: "Update",
                                    type: ButtonType.outlined,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      update();
                                    }),
                              ],
                            ),
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

  void update() async {
    var res = await loginState!.passwordchange(
        password: password,
        pin_id: widget.pin_id,
        otp: widget.otp,
        phone: widget.phone);
    res.fold((l) => kShowSnackBar(context, l.props.first.toString()), (r) {
      appState!.successDialog(context, r, () {
        pushToAndClearStack(context, LoginPage());
      });
    });
  }
}

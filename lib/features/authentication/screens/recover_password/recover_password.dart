import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vend_express/features/authentication/screens/recover_password/recover_password_notification.dart';

import '../../../../core/utils/function/snaks.dart';
import '../../../../core/utils/navigation/navigator.dart';
import '../../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../../core/utils/styles/color_utils.dart';
import '../../../../core/utils/widgets/custom_button.dart';
import '../../../../core/utils/widgets/custom_text_field.dart';
import '../../../../core/utils/widgets/header.dart';
import '../../../../core/widget/loading_overlay_widget.dart';
import '../../viewModel/loginState.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({Key? key}) : super(key: key);

  @override
  _RecoverPasswordPageState createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  var phone;
  LoginState? loginState;

  @override
  Widget build(BuildContext context) {
    loginState = Provider.of(context);
    return LoadingOverlayWidget(
      loading: loginState?.busy,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Header(
                  text: "",
                  preferredActionOnBackPressed: () {
                    pop(context);
                  },
                ),
                SizedBox(
                  height: 6 * SizeConfig.heightMultiplier,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Recover Password",
                              style: TextStyle(
                                  fontSize: 2.9 * SizeConfig.textMultiplier,
                                  color: kTitleTextfieldColor,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Enter the email associated with your account and we’ll send an email with instructions to reset your password",
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
                                  header: "Phone Number",
                                  hint: "08067927251",
                                  type: FieldType.phone,
                                  textInputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(11),
                                  ],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Field is required";
                                    } else if (value.length < 10) {
                                      return "Invalid Phone";
                                    }
                                    // if (value.trim().isEmpty) {
                                    //   return "Email is required";
                                    // } else if (!EmailValidator.validate(
                                    //     value.replaceAll(" ", "").trim())) {
                                    //   return "Email is invalid";
                                    // }
                                    phone = value;
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 7.3 * SizeConfig.heightMultiplier,
                                ),
                                CustomButton(
                                    text: "Send Instructions",
                                    type: ButtonType.outlined,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        recoverPass();
                                      }
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

  void recoverPass() async {
    var res = await loginState!.requestPasswordchange(phone: phone);
    res.fold(
        (l) => kShowSnackBar(context, l.props.first.toString()),
        (r) => pushTo(
            context,
            RecoverNotification(
              pin_id: r,
              phone: phone,
            )));
  }
}

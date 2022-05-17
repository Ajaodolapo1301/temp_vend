import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/function/snaks.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../core/utils/widgets/custom_text_field.dart';
import '../../../core/utils/widgets/header.dart';
import '../../../core/widget/loading_overlay_widget.dart';
import '../viewModel/loginState.dart';
import '../widget/titleTile.dart';
import 'login.dart';
import 'otpScreen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  LoginState? loginState;
  String? accountName;
  String? email;
  String? phone;
  String? password;
  bool isVisiblePassword = true;
  @override
  Widget build(BuildContext context) {
    loginState = Provider.of<LoginState>(context);
    return LoadingOverlayWidget(
      loading: loginState?.busy,
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Already have an account",
                style: TextStyle(
                    color: kTitleTextfieldColor,
                    fontSize: 1.6 * SizeConfig.textMultiplier,
                    fontWeight: FontWeight.w500),
              ),
              TextButton(
                  onPressed: () => pushTo(context, const LoginPage()),
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 1.6 * SizeConfig.textMultiplier,
                        fontWeight: FontWeight.w700),
                  ))
            ],
          ),
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Header(
                    text: "",
                    preferredActionOnBackPressed: () {
                      pop(context);
                    },
                  ),
                  SizedBox(
                    height: 3 * SizeConfig.heightMultiplier,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleWidget(
                          mainText: "Create Account",
                          subtext:
                              "Set up your account so we can get to know you.",
                        ),
                        SizedBox(
                          height: 3 * SizeConfig.heightMultiplier,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                header: "Account Name",
                                hint: "John Doe",
                                type: FieldType.text,
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    //Todo validate first and last name
                                    return "Name is Required";
                                  }
                                  accountName = v;
                                  return null;
                                },
                              ),
                              CustomTextField(
                                header: "Email Address",
                                hint: "ajaodlp@xyz.com",
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
                                header: "Phone Number",
                                hint: "08065083711",
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return "Phone is Required";
                                  }
                                  phone = v;
                                  return null;
                                },
                                type: FieldType.phone,
                                textInputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(11),
                                ],
                              ),
                              CustomTextField(
                                textEditingController: controller,
                                obscureText: isVisiblePassword,
                                header: "Password",
                                hint: "*********",
                                validator: (v) {
                                  if (v!.length < 6) {
                                    return "Password should be at least 6 character ";
                                  } else if (v.isEmpty) {
                                    return "password is Required";
                                  }
                                  password = v;
                                  return null;
                                },
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
                                        isVisiblePassword ? "SHOW" : "HIDE",
                                        style: TextStyle(
                                            fontSize: 10, color: primaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                                type: FieldType.password,
                              ),
                              FlutterPwValidator(
                                  controller: controller,
                                  minLength: 7,
                                  uppercaseCharCount: 1,
                                  numericCharCount: 1,
                                  specialCharCount: 1,
                                  width: 400,
                                  height: 150,
                                  onSuccess: () {
                                    setState(() {});
                                  }),
                              SizedBox(
                                height: 5.3 * SizeConfig.heightMultiplier,
                              ),
                              CustomButton(
                                  text: "Create Account",
                                  type: ButtonType.outlined,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      register();
                                    }
                                  }),
                            ],
                          ),
                        )
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

  void register() async {
    var res = await loginState!.register(
      email: email.toString().toLowerCase(),
      password: password,
      home_address: "",
      dob: "",
      phone: phone,
      full_name: accountName,
      role_id: "1",
    );
    res.fold(
        (l) => kShowSnackBar(context, l.props.first.toString(),
            title: l.otherMessage != null ? l.otherMessage.toString() : ""),
        (r) {
      pushTo(
          context,
          OTPPage(
            user: r,
          ));
    });
  }
}

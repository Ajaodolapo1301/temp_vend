import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/function/snaks.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../authentication/viewModel/loginState.dart';
import '../viewModel/profileViewModel.dart';

class FaqScreen extends StatefulWidget {
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen>
    with AfterLayoutMixin<FaqScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  ProfileState? profileState;
  LoginState? loginState;

  @override
  Widget build(BuildContext context) {
    profileState = Provider.of<ProfileState>(context);
    loginState = Provider.of<LoginState>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: const CustomAppBar(label: "FAQ", showAction: false),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 4.4 * SizeConfig.heightMultiplier,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Frequently Asked Question",
                  style: kBold700.copyWith(
                      fontSize: 2.5 * SizeConfig.textMultiplier),
                ),
              ),
              SizedBox(
                height: 2.4 * SizeConfig.heightMultiplier,
              ),
              Builder(
                builder: (context) {
                  if (profileState!.busy) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (profileState!.faqList.isEmpty ||
                      profileState?.faqList == null) {
                    return const Center(child: Text("Empty"));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: profileState!.faqList.length,
                          itemBuilder: (context, index) {
                            return FaqItem(
                              question: profileState!.faqList[index].question!,
                              answer: profileState!.faqList[index].answer!,
                            );
                          }),
                    );

                    //
                    // ...List.generate(profileState.faqList.length, (index) {
                    // return FaqItem(
                    // question: profileState.faqList[index].question,
                    // answer: profileState.faqList[index].answer,
                    // );
                    // })
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getFAq();
  }

  void getFAq() async {
    var res = await profileState!.faq(token: loginState!.user.token);
    res.fold((l) {
      kShowSnackBar(context, l.props.first.toString());
    }, (r) {});
  }
}

class FaqItem extends StatefulWidget {
  final String? question;
  final String? answer;

  const FaqItem({Key? key, this.question, this.answer}) : super(key: key);

  @override
  _FaqItemState createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqItem> {
  Color textColor = kTitleTextfieldColor;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      // iconColor: kTitleTextfieldColor,
      title: Text(
        widget.question!,
        style: kBold400.copyWith(
          fontSize: 1.9 * SizeConfig.textMultiplier,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
      backgroundColor: kTitleTextfieldColor.withOpacity(0.1),
      onExpansionChanged: (expanded) {
        setState(() {
          if (expanded) {
//            textColor = MyColors.accentColorDeep;
          } else {
            textColor = kTitleTextfieldColor;
          }
        });
      },
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15.0, bottom: 10.0, right: 15.0),
            child: Text(
              widget.answer!,
              style: kBold400.copyWith(
                fontSize: 1.7 * SizeConfig.textMultiplier,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

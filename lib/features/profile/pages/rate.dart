import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
import '../../authentication/viewModel/loginState.dart';
import '../viewModel/profileViewModel.dart';

class RatePage extends StatefulWidget {
  const RatePage({Key? key}) : super(key: key);

  @override
  _RatePageState createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  bool inAppSound = false;
  bool inAppVib = false;
  TextEditingController controller = TextEditingController();
  String? userRating;
  @override
  void initState() {
    super.initState();
  }

  AppState? appState;
  ProfileState? profileState;
  LoginState? loginState;
  @override
  Widget build(BuildContext context) {
    profileState = Provider.of<ProfileState>(context);
    loginState = Provider.of<LoginState>(context);

    appState = Provider.of<AppState>(context);
    return LoadingOverlayWidget(
      loading: profileState!.busy,
      child: Scaffold(
        // backgroundColor: Color(0xffE5E5E5
        // ),
        appBar: const CustomAppBar(label: "Rating", showAction: false),

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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rate our app and services",
                        style: kBold700.copyWith(
                            fontSize: 1.7 * SizeConfig.textMultiplier),
                      ),
                      Text(
                        "On a scale of five, how do we do",
                        style: kBold400.copyWith(
                            fontSize: 1.4 * SizeConfig.textMultiplier,
                            color: fadedText),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.4 * SizeConfig.heightMultiplier,
                  ),
                  RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      itemSize: 6.7 * SizeConfig.textMultiplier,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) {
                        return Icon(
                          Icons.star,
                          color: primaryColor,
                        );
                      },
                      onRatingUpdate: (rating) {
                        setState(() {
                          userRating = rating.toString();
                        });
                      }),
                  SizedBox(
                    height: 4.3 * SizeConfig.heightMultiplier,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        textEditingController: controller,
                        header: "Can you share more about it?",
                        hint: "Additional Information...",
                        maxLines: 10,
                        minLines: 10,
                        maxLength: 300,
                        type: FieldType.multiline,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.5 * SizeConfig.heightMultiplier,
                  ),
                  CustomButton(
                      text: "Send Review",
                      type: ButtonType.outlined,
                      textColor: Colors.white,
                      onPressed: () {
                        sendRating();
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  sendRating() async {
    var result = await profileState!.appRatings(
        rate: userRating ?? 5.0,
        message: controller.text,
        token: loginState!.user.token);
    result.fold(
        (l) => kShowSnackBar(context, l.props.first.toString()),
        (r) => appState!.successDialog(context, r, () {
              pop(context);
              pop(context);
              // pushReplacementTo(context, Home());
            }));
  }
}

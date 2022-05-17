import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/navigation/navigator.dart';
import '../../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../../core/utils/styles/color_utils.dart';
import '../../../../core/utils/widgets/custom_button.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../model/onBoardingDetails.dart';
import '../login.dart';
import '../register_page.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final List<OnboardDetails> OnboardingScreens = [
    OnboardDetails(
      mainText: LocaleKeys.onBoarding_main_text.tr(),
      imagePath: "assets/images/onBoarding/first.svg",
      subText: LocaleKeys.onBoarding_sub_text.tr(),
    ),
    OnboardDetails(
      mainText: LocaleKeys.onBoarding_main_text.tr(),
      imagePath: "assets/images/onBoarding/second.svg",
      subText: LocaleKeys.onBoarding_sub_text.tr(),
    ),
    OnboardDetails(
      mainText: LocaleKeys.onBoarding_main_text.tr(),
      imagePath: "assets/images/onBoarding/third.svg",
      subText: LocaleKeys.onBoarding_sub_text.tr(),
    )
  ];
  int _currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);
  double current = 0.0;
  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < OnboardingScreens.length; i++) {
      list.add(i == _currentPage ? circleBar(true) : circleBar(false));
    }
    return list;
  }

  Widget circleBar(isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 8 : 8,
      width: isActive ? 8 : 8,
      decoration: BoxDecoration(
          // border: Border.all(color: blue),
          color: isActive ? primaryColor : const Color(0xffD8D8D8),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }

  void listener() {
    setState(() {
      current = _pageController.page!;
    });
  }

  @override
  void initState() {
    _pageController.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 6.1 * SizeConfig.heightMultiplier,
              ),
              Expanded(
                flex: 1,
                child: PageView.builder(
                  itemCount: OnboardingScreens.length,
                  onPageChanged: (page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              width: double.infinity,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: SvgPicture.asset(
                                    OnboardingScreens[index].imagePath!,
                                    fit: BoxFit.contain,
                                    width: 68 * SizeConfig.widthMultiplier,
                                    height: 35 * SizeConfig.heightMultiplier,
                                  ))),
                          SizedBox(
                            height: 4.0 * SizeConfig.heightMultiplier,
                          ),
                          Text(
                            OnboardingScreens[index].mainText!,
                            style: TextStyle(
                                fontSize: 2.6 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 1.0 * SizeConfig.heightMultiplier,
                          ),
                          Container(
                              width: 69.8 * SizeConfig.widthMultiplier,
                              // width:250,

                              child: Text(
                                OnboardingScreens[index].subText!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 1.9 * SizeConfig.textMultiplier,
                                    fontWeight: FontWeight.w400),
                              )),
                          SizedBox(
                            height: 2.0 * SizeConfig.heightMultiplier,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _buildPageIndicator(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

// Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 2.3 * SizeConfig.heightMultiplier),
                child: Column(
                  children: [
                    CustomButton(
                      text: LocaleKeys.login.tr(),
                      type: ButtonType.outlined,
                      textColor: Colors.white,
                      onPressed: () => pushTo(context, LoginPage()),
                    ),
                    SizedBox(
                      height: 2.0 * SizeConfig.heightMultiplier,
                    ),
                    CustomButton(
                        text: LocaleKeys.Signup.tr(),
                        color: Colors.transparent,
                        type: ButtonType.outlined,
                        textColor: kTitleTextfieldColor,
                        onPressed: () => pushTo(context, RegisterPage()))
                  ],
                ),
              ),

              SizedBox(
                height: 6.1 * SizeConfig.heightMultiplier,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

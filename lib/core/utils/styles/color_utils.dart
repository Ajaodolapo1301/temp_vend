import 'package:flutter/material.dart';

import '../sizeConfig/sizeConfig.dart';

class ColorUtils {
  static Color _blue = const Color(0xff035D9F);

  static Color get blue => _blue;
  bool isDark = true;

  // Future<void> resetIsDark() async {
  //   var pref = await SharedPreferences.getInstance();
  //   isDark = pref.getBool("isDark") ?? false;
  // }
  void initEnv(accessToken) {
    _blue = accessToken;
  }
}

// const Color blue = Color(0xff035D9F);
Color primaryColor = const Color(0xffFDF06A);
Color complementary = Colors.black45;

final sixteen = 1.9 * SizeConfig.heightMultiplier;
final eighteen = 2.2 * SizeConfig.heightMultiplier;

const Color kTitleTextfieldColor = Color(0xff515151);

const Color fadedText = Color(0xff979797);
const primexBlack = Color(0xff666E7A);
const Color orange = Color(0xffFFAD01);
Color green = const Color(0xff81AA60);
Color okCheck = const Color(0xff0AA06E);
Color badCheck = const Color(0xffFF6465);
Color boxColor = const Color(0xffFAFAFD);
const Color kBackground = Color(0xffE5E5E5);
const Color lightBlue = Color(0xffF0FAFF);
Color borderBlue = const Color(0xff9AA9CF);
const Color cyan = Color(0xff00C2FF);
Color deepCyan = const Color(0xffD9F6FF);
Color lightDeepCyan = const Color(0xff87E3FF);

//Home Card Colors.
Color almostRed = const Color(0xffFFEAE9);
Color almostCyan = const Color(0xFFF0FAFF);
Color almostPurple = const Color(0xFFEDE4FF);
Color almostGreen = const Color(0xFFE3FFEF);

//Onboarding Colors.
Color burntRed = const Color(0xFFFFBFA6);
Color burntBlue = const Color(0xFF8FC8FF);
Color burntPurple = const Color(0xFF9196F5);

//Modals
Color barrierColor = const Color(0xff364A7D).withOpacity(0.85);

//Add A New Business
Color burntGreen = const Color(0xFFC8F8D0);

//Budget
Color barGreen = const Color(0xFF1BC97E);

//CryptoCurrency
Color btcBlue = const Color(0xFF27ACFF);

//Virtual Cards
Color deepTangerine = const Color(0xFFFEB816);
Color deepSkyBlue = const Color(0xFF166BFE);
Color jaggerPurple = const Color(0xFF3F2B4B);
Color deepPink = const Color(0xFFFE1692);
Color rebbecaPurple = const Color(0xFF4B3C9C);
Color gladeOrange = const Color(0XFFFF8000);
Color gladeBlue = const Color(0xFF16AFFE);
Color deepGreen = const Color(0xFF209189);

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/keyConstants.dart';
import '../styles/color_utils.dart';

class MyUtils {
  ///
  ///Generates a positive random integer uniformly distributed on the range
  /// from [min], inclusive, to [max], exclusive.

  static String getCleanedNumber(String text) {
    if (text == null) {
      return '';
    }
    RegExp regExp = RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }

  static String getFormattedAmount(num amount) {
    var newamount = amount / 100;
    String format = '${NumberFormat('#,##0.00', 'en_GB').format(newamount)}';
    var formats = format.split(RegExp(r'(\.)'));
    return formats[1] == '00' ? formats[0] : format;
  }

  static cupertinoDark({@required BuildContext? context}) {
    return CupertinoTheme(
      data: CupertinoTheme.of(context!).copyWith(brightness: Brightness.light),
      child: const CupertinoActivityIndicator(),
    );
  }

//
//  static Future<String> googleAPIKey() async {
//
//    return Platform.isIOS ? "AIzaSyAM-5Ejo9txM4LdIMR2nrm84HL9LXkFxj8" : "AIzaSyAM-5Ejo9txM4LdIMR2nrm84HL9LXkFxj8";
//  }

//  static String isEmailStr(String email, {String error = Strings.emailInvalid}) {
//    return isEmail(email) ? null : error;
//  }

  static bool isEmail(String email) {
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";

    return RegExp(p).hasMatch(email);
  }

  static const requestDuration = Duration(seconds: 15);

//  static String validateField(String value) {
//    if (value == null || value.isEmpty) return Strings.fieldReq;
//    return null;
//  }
//
//  static String validateConfirmPassword(String value, String confirm) {
//    if (value == null || value.isEmpty) return Strings.fieldReq;
//    if (value != confirm) return Strings.confirmError;
//
//    return null;
//  }

  static String? validateZip(String value) {
    if (value == null || value.length < 5)
      return "Zip code should not be 5 digits ";
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    //print("num $value");
    if (value == null || value.isEmpty || value.length < 10) {
      return "Enter a correct Phone Number";
    }
    return null;
  }

  static TimeOfDay closingTime = const TimeOfDay(hour: 20, minute: 00);
  static TimeOfDay openingTime = const TimeOfDay(hour: 11, minute: 00);

  static String getObscuredNumberWithSpaces(
      {required String string, String obscureValue = 'X', String space = ' '}) {
    assert(
        !(string.length < 8),
        'Card Number $string must be more than 8 '
        'characters and above');
    assert(obscureValue != null && obscureValue.length == 1);
    var length = string.length;
    var buffer = StringBuffer();
    for (int i = 0; i < string.length; i++) {
      if (i < (length - 4)) {
        // The numbers before the last digits is changed to X
        buffer.write(obscureValue);
      } else {
        // The last four numbers are spared
        buffer.write(string[i]);
      }
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != string.length) {
        buffer.write(space);
      }
    }
    return buffer.toString();
  }

  static String getObscuredNumberWithSpacesv2(
      {required String string, String obscureValue = 'X', String space = ' '}) {
    assert(
        !(string.length < 8),
        'Card Number $string must be more than 8 '
        'characters and above');
    assert(obscureValue != null && obscureValue.length == 1);
    var length = string.length;
    var buffer = StringBuffer();
    for (int i = 0; i < string.length; i++) {
      if (i < 4) {
        buffer.write(string[i]);
      } else if (i < (length - 4)) {
        // The numbers before the last digits is changed to X
        buffer.write(obscureValue);
      } else {
        // The last four numbers are spared
        buffer.write(string[i]);
      }
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != string.length) {
        buffer.write(space);
      }
    }
    return buffer.toString();
  }

  static int autoCompleteTimes = 0;

  static Future<String> googleAPIKey() async {
    return API_KEY;
    // Platform.isIOS ? "AIzaSyCVPD-qI5rlLLGoEzgQJQjLQBqtvsHW-o8" : "AIzaSyCVPD-qI5rlLLGoEzgQJQjLQBqtvsHW-o8";
    // "AIzaSyAVgkQ1Q9YFoutukKPAg6WLQyhAatOLNI4" : "AIzaSyAVgkQ1Q9YFoutukKPAg6WLQyhAatOLNI4";
  }

  static formatDate(String date) {
    if (date == null) {
      return date ?? "";
    }

    var fmtDate = DateFormat.yMMMd().format(DateTime.parse(date));
//    String fmtDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
    String fmtTime = DateFormat('kk:mm:a').format(DateTime.parse(date));
    return "${fmtDate.toString()} - ${fmtTime.toString()}";
  }

  static formatTime(String date) {
    if (date == null) {
      return date ?? "";
    }

    String fmtTime = DateFormat('kk:mm:a').format(DateTime.parse(date));
    return fmtTime.toString();
  }

  static formatWithoutTime(String date) {
    if (date == null) {
      return date ?? "";
    }

    var fmtDate = DateFormat.yMMMd().format(DateTime.parse(date));
//    String fmtDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
//     String fmtTime =DateFormat('kk:mm:a').format(DateTime.parse(date));
    return "${fmtDate.toString()}";
  }

  static String formatDuration(Duration d) {
    var seconds = d.inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];
    if (days != 0) {
      tokens.add('${days}d');
    }
    if (tokens.isNotEmpty || hours != 0) {
      tokens.add('${hours}h');
    }
    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('${minutes}m');
    }
    tokens.add('${seconds}s');

    return tokens.join(':');
  }

  static double convertAmount(
      String amount, double commission, double exchangeRate) {
//    print("amount: $amount");
//    print("comission: $commission");
//    print("ex: $exchangeRate");

    var percentageOfCommission = double.parse(amount) * (commission / 100);
    //print("percentage of commission: $percentageOfCommission");

    //

    var amountWithCommissionTaken =
        double.parse(amount) - percentageOfCommission;
    //print("amount with commision taken: $amountWithCommissionTaken");
    double amountConverted = (amountWithCommissionTaken * exchangeRate);

    //print("recie: $amountConverted");
    return amountConverted;
  }

  static double convertAmountForModal(
      String amount, double commission, double exchangeRate) {
    var percentageOfCommission = double.parse(amount) * (commission / 100);

    var amountWithCommissionTaken =
        double.parse(amount) - percentageOfCommission;

    double amountConverted = (amountWithCommissionTaken * exchangeRate);

    if (amountConverted.isInfinite || amountConverted.isNaN) {
      return 0.0;
    }

    return amountConverted;
  }

  static formatAmount(String amount) {
    if (amount != "0") {
      return NumberFormat.currency(name: 'NGN', symbol: '').format(double.parse(
          amount
              .replaceAll("USD", "")
              .replaceAll(",", "")
              .replaceAll("NGN", "")
              .replaceAll("\n", "")));
    }

    return amount + ".00";
  }

  static String getTime(DateTime time) {
    String _addLeadingZeroIfNeeded(int value) {
      if (value < 10) {
        return '0$value';
      }
      return value.toString();
    }

    TimeOfDay day = TimeOfDay.fromDateTime(time);
    String result =
        "${_addLeadingZeroIfNeeded(day.hourOfPeriod)}:${_addLeadingZeroIfNeeded(day.minute)} ${day.period == DayPeriod.am ? "AM" : "PM"}";

    return result;
  }

  static String getAvatarText(String name) {
    var strings = name.split(RegExp(' '));
    print("this is the cause of an issue $strings ---- ${strings.length}");
    if (strings.isEmpty) {
      return '';
    }

    if (strings.length >= 1) {
      return strings[0][0];
    } else {
      return 'T';
    }
  }

  static showAlertDialog(
      {BuildContext? context, String? text, VoidCallback? onClose}) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context!);
      },
    );
    Widget continueButton = FlatButton(
      child: const Text(
        "OK",
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xff202F36)),
      ),
      onPressed: onClose,
    );

//  // set up the AlertDialog
//  AlertDialog alert = AlertDialog(
////    title: Text("Logout"),
//    content: Text("Password change successfully"),
//    actions: [
////      cancelButton,
//      continueButton,
//    ],
//  );

    // show the dialog
    showDialog(
        barrierDismissible: false,
        // barrierColor: kSecondaryColor20,
        context: context!,
        builder: (_) => AlertDialog(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              content: Builder(
                builder: (context) {
                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;

                  return SizedBox(
                      height: 20,
                      width: width,
                      child: Text(
                        text!,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff202F36)),
                      ));
                },
              ),
              actions: [continueButton],
            ));
  }

  static showIosAlerDialog(
      {BuildContext? context, String? text, VoidCallback? onClose}) {
    Widget cancelButton = FlatButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context!);
      },
    );
    Widget continueButton = FlatButton(
      child: const Text(
        "OK",
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xff202F36)),
      ),
      onPressed: onClose,
    );

    showDialog(
      barrierDismissible: false,
      context: context!,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Text(
            text!,
          ),
          actions: <Widget>[continueButton],
        );
      },
    );
  }

  static showIOSAreYouSureDialog(BuildContext context,
      {text, VoidCallback? onClose, leftText, rightText, mainText, subtext}) {
    Widget cancelButton = FlatButton(
      child: Text(
        leftText,
        style: TextStyle(color: primaryColor),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
        child: Text(
          rightText,
          style: TextStyle(color: primaryColor),
        ),
        onPressed: onClose);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(mainText),
          content: Text(
            subtext,
          ),
          actions: <Widget>[cancelButton, continueButton],
        );
      },
    );
  }

  static showAreYouSureDialog(BuildContext context,
      {text, VoidCallback? onClose, leftText, rightText, mainText, subtext}) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        leftText,
        style: TextStyle(color: primaryColor),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
        child: Text(
          rightText,
          style: TextStyle(color: primaryColor),
        ),
        onPressed: onClose);

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(mainText),
      content: Text(subtext),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

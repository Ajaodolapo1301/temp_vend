import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../authentication/model/notification_model.dart';
import '../../authentication/viewModel/loginState.dart';

class NotifyScreen extends StatefulWidget {
  @override
  _NotifyScreenState createState() => _NotifyScreenState();
}

class _NotifyScreenState extends State<NotifyScreen>
    with TickerProviderStateMixin, AfterLayoutMixin<NotifyScreen> {
  AnimationController? _controller;
  LoginState? loginState;
  @override
  void initState() {
    // initTextScale();
    // initDark();
    // initAnim();
    super.initState();
  }

  // int move = 0;
  // var tween = Tween(begin: Offset.zero, end: Offset(10, 0));
  // Timer timer2;
  //
  // initAnim() async {
  //   _controller =
  //       AnimationController(vsync: this, duration: Duration(seconds: 3));
  //   timer2 = Timer.periodic(Duration(seconds: 2), (timer) async {
  //     if (mounted) {
  //       try {
  //         await _controller.forward();
  //         _controller.reset();
  //         setState(() {
  //           move++;
  //           if (move % 2 == 0) {
  //             tween = Tween(begin: Offset.zero, end: Offset(5, 0));
  //           } else {
  //             tween = Tween(begin: Offset.zero, end: Offset(-5, 0));
  //           }
  //         });
  //       } catch (e) {}
  //     }
  //   });
  // }
  //
  // bool showDismissInfo = true;

  @override
  void dispose() {
    super.dispose();
  }

  // Timer timer;
  //
  List notifications = [];

  double textScale = 1.0;

  @override
  Widget build(BuildContext context) {
    loginState = Provider.of(context);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: textScale),
      child: Scaffold(
          // appBar: kAppBar("Notification", onPress: () {
          //   pop(context);
          // }),
          backgroundColor: Colors.white,
          body: SafeArea(
            bottom: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: loginState!.notificationList.isEmpty
                          ? Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height,
                              padding: EdgeInsets.zero,
                              child: const Center(
                                child: Text(
                                  "No Notifications",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ))
                          : ListView.separated(
                              itemCount: loginState!.notificationList.length,
                              itemBuilder: (context, index) {
                                NotificationModel notif =
                                    loginState!.notificationList[index];
                                return Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          notif.title!,
                                          style:
                                              kBold500.copyWith(fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.89,
                                            child: Text(notif.log!,
                                                textAlign: TextAlign.start,
                                                style: kBold400.copyWith(
                                                    fontSize: 12,
                                                    color:
                                                        kTitleTextfieldColor)))
                                      ],
                                    )
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Divider(),
                                  ],
                                );
                              },
                            )
                      // List.generate(notifications.length, (index) {
                      //   NM.Notification e = notifications[index];
                      //   print(e);
                      //   return Dismissible(
                      //     key: UniqueKey(),
                      //     onDismissed: (direction) {
                      //       setState(() {
                      //         notifications.removeAt(index);
                      //       });
                      //       List<String> note = [];
                      //       notifications.forEach((element) {
                      //         note.add(jsonEncode(element.toJson()));
                      //       });
                      //       SharedPreferences.getInstance()
                      //           .then((pref) {
                      //         pref.setStringList("notifications",
                      //             note.reversed.toList());
                      //       });
                      //     },
                      //     child: Container(
                      //       margin: EdgeInsets.symmetric(
                      //           horizontal: 10, vertical: 10),
                      //       padding: EdgeInsets.symmetric(
                      //           horizontal: 15, vertical: 10),
                      //       decoration: BoxDecoration(
                      //           color: lightBlue,
                      //           borderRadius: BorderRadius.circular(5)),
                      //       child: Column(
                      //         crossAxisAlignment:
                      //         CrossAxisAlignment.start,
                      //         children: <Widget>[
                      //           Row(
                      //             children: [
                      //               CircleAvatar(
                      //                 child: Icon(
                      //                   Icons.person,
                      //                   color: Colors.white,
                      //                 ),
                      //                 backgroundColor: blue,
                      //               ),
                      //               SizedBox(width: 8),
                      //               Text(
                      //                 "Ebi from Glade",
                      //                 style: TextStyle(
                      //                     color: isDark
                      //                         ? Colors.white
                      //                         : headerColor,
                      //                     fontWeight: FontWeight.w600
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //           SizedBox(height: 10),
                      //           Text(
                      //             e.title ?? "",
                      //             style: TextStyle(
                      //                 color:  blue,
                      //                 fontWeight: FontWeight.w600,
                      //                 fontSize: 15),
                      //           ),
                      //           SizedBox(
                      //             height: 5,
                      //           ),
                      //           Text(
                      //             e.body ?? "",
                      //             style: TextStyle(
                      //                 fontSize: 13,
                      //                 color: isDark
                      //                     ? Colors.white
                      //                     : Colors.black),
                      //           ),
                      //           SizedBox(height: 10),
                      //           Text(
                      //             e.date ?? "",
                      //             style: TextStyle(
                      //               color: isDark
                      //                   ? Colors.white
                      //                   : Colors.grey[900],
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   );
                      // })),
                      ),
                ],
              ),
            ),
          )),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    fetchNotif();
  }

  void fetchNotif() async {
    var res = await loginState!.getNotification(
        token: loginState!.user.token!, id: loginState!.user.id);
  }
}

// if (notifications.isNotEmpty)
// Column(
// children: [
// Container(
// height: 250,
// child: Column(
// children: [
// SizedBox(height: 10),
// Text(
// "Swipe left or right to delete notification",
// style: TextStyle(
// color: blue, fontSize: 14),
// ),
// SizedBox(height: 10),
// Container(
// width: double.maxFinite,
// margin: EdgeInsets.symmetric(
// horizontal: 10, vertical: 10),
// padding: EdgeInsets.symmetric(
// horizontal: 15, vertical: 10),
// decoration: BoxDecoration(
// color: lightBlue,
// borderRadius: BorderRadius.circular(5)),
// child: Column(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: <Widget>[
// Row(
// children: [
// CircleAvatar(
// child: Icon(
// Icons.person,
// color: Colors.white,
// ),
// backgroundColor: blue,
// ),
// SizedBox(width: 8),
// Text(
// "Femi from Primex",
// style: TextStyle(
// color:  blue,
// fontWeight: FontWeight.w600
// ),
// )
// ],
// ),
// SizedBox(
// height: 10,
// ),
// Text(
// "Swipe to delete",
// style: TextStyle(
// color:  blue,
// fontWeight: FontWeight.bold,
// fontSize: 17),
// ),
// SizedBox(
// height: 10,
// ),
// Text(
// "You can delete notifications by swiping left or right",
// style: TextStyle(
// fontSize: 13,
// color: Colors.black),
// ),
// SizedBox(
// height: 10,
// ),
// Text(
// "Now",
// style: TextStyle(
// color: Colors.grey[900],
// ),
// ),
// ],
// ),
// ),
// TextButton(
// onPressed: () {
//
// },
// child: Text("OK"),
// )
// ],
// ),
// ),
// Divider(
// color: Colors.grey[400],
// height: 0.3,
// ),
// ],
// ),

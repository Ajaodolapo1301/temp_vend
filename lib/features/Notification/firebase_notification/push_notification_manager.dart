import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:vend_express/features/chat/viewModel/chatViewModel.dart';

import '../../../main.dart';
import '../../authentication/api/data_source/local_data_source/user_hive.dart';
import '../../authentication/model/user.dart';
import '../../chat/Pages/widget/answer_call.dart';
import '../../chat/model/chatModel.dart';
import '../../profile/pages/rate_rider.dart';

ChatState chatState = ChatState();

Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  String action = message.data["action"];
  UserHive hive = UserHive(hive: Hive);
  User? user = await hive.getUser();

  if (action == "message") {
    String channelName = message.data["channelName"];
    String senderName = message.data["senderName"];
    String actualMessage = message.data["message"];
    String senderId = message.data["senderId"];
    String receiverFcmToken = message.data["fcmToken"];
    // add a new message to list of messages if not previously added
    chatState.getMessageToken(token: user!.token, channel: channelName).then(
          (value) => value.fold(
            (l) => print(l),
            (r) {
              // create random int as id
              int id = Random().nextInt(912921);

              List<MessageModel> message = [
                MessageModel(message: actualMessage, user: senderId.toString())
              ];

              //add a new chat
              Chat chat = Chat(
                receiverFcmToken: receiverFcmToken,
                chatId: id,
                messages: message,
                channelName: channelName,
                riderName: senderName,
                riderId: senderId,
              );
              chatState.addChat(chat);
            },
          ),
        );
  }
}

/// Create a [AndroidNotificationChannel] for heads up notifications

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

class PushNotificationsManager {
  final BuildContext context;
  PushNotificationsManager({
    required this.context,
  });
  bool _initialized = true;
  static String _deviceToken = "";

  static String get deviceToken => _deviceToken;
  bool isDark = true;

  // Future<void> resetIsDark() async {
  //   var pref = await SharedPreferences.getInstance();
  //   isDark = pref.getBool("isDark") ?? false;
  // }
  void initEnv(accessToken) {
    _deviceToken = accessToken;
  }

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('app_icon');
  Future<void> init() async {
    if (_initialized) {
      FirebaseMessaging.instance.getToken().then((value) {
        // print("token");
        // print("token$value");
        initEnv(value);
      });
      //print('setup notification');
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
          'high_importance_channel', // id
          'High Importance Notifications', // title
          description: 'This channel is used for important notifications.',
          importance: Importance.max,
          enableLights: true,
          enableVibration: true,
          sound: RawResourceAndroidNotificationSound("calling.mp3"));
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen(
        (RemoteMessage? message) {
          RemoteNotification notification = message!.notification!;
          AndroidNotification android = message.notification!.android!;

          if (notification != null && android != null) {
            flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    icon: 'app_icon',
                    playSound: true,
                    sound:
                        const RawResourceAndroidNotificationSound("calling")),
              ),
            );
          } else {
            flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              const NotificationDetails(
                iOS: IOSNotificationDetails(
                  sound: "",
                  subtitle: "",
                ),
              ),
            );
          }
          if (notification.body == "Rider has delivered item at destination") {
            navKey.currentState?.push(MaterialPageRoute(
                builder: (context) => RateRider(
                      id: message.data["order_id"],
                    )));
          }

          actBasedOnMessage(message);
        },
      );

      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

      // manage when user opens application by clicking notifications
      RemoteMessage? message =
          await FirebaseMessaging.instance.getInitialMessage();
      if (message != null) {
        await actBasedOnMessage(message);
      }

      // manage notification from notification while the app is minimized
      FirebaseMessaging.onMessageOpenedApp
          .listen((RemoteMessage message) async {
        RemoteNotification notification = message.notification!;
        print("on Message${message.notification!.body}");
        // print("on all object Message${message}");
        if (notification.body == "Rider has delivered item at destination") {
          navKey.currentState?.push(MaterialPageRoute(
              builder: (context) => RateRider(
                    id: message.data["order_id"],
                  )));
        }
        await actBasedOnMessage(message);
      });

      FirebaseMessaging messaging = FirebaseMessaging.instance;

      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        //print('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        //print('User granted provisional permission');
      } else {
        //print('User declined or has not accepted permission');
      }
    }
  }

  Future<void> actBasedOnMessage(RemoteMessage message) async {
    UserHive hive = UserHive(hive: Hive);
    User? user = await hive.getUser();

    String action = message.data["action"];

    // if (encodedData != null) {
    //   data = UserData.fromJson(
    //     jsonDecode(encodedData),
    //   );
    //   if (action == "order_assigned") {
    //     //change the value of the main index
    //     IndexProvider().setIndex(0);
    //   } else
    if (action == "call") {
      print("calling notification receivedoooooo");
      //get Token
      String channelName = message.data["channelName"] ?? "";
      String callerName = message.data["senderName"];
      chatState.getCallToken(token: user!.token, channel: channelName).then(
            (value) => value.fold(
              (l) => print(l),
              (r) {
                // goto answer call page
                navKey.currentState?.push(
                  MaterialPageRoute(
                    builder: (index) => AnswerCall(
                      receiverToken: null,
                      callerName: callerName,
                      channelName: channelName,
                      initiatingCall: false,
                    ),
                  ),
                );
              },
            ),
          );
    } else if (action == "message") {
      String channelName = message.data["channelName"] ?? '';
      String senderName = message.data["senderName"] ?? '';
      String actualMessage = message.data["message"] ?? '';
      String senderId = message.data["senderId"] ?? '';
      String receiverFcmToken = message.data["fcmToken"] ?? '';
      // add a new message to list of messages if not previously added
      chatState.getMessageToken(token: user!.token, channel: channelName).then(
            (value) => value.fold(
              (l) => print(l),
              (r) {
                // create random int as id
                int id = Random().nextInt(912921);

                List<MessageModel> message = [
                  MessageModel(
                      message: actualMessage, user: senderId.toString())
                ];

                Chat chat = Chat(
                  receiverFcmToken: receiverFcmToken,
                  chatId: id,
                  messages: message,
                  channelName: channelName,
                  riderName: senderName,
                  riderId: senderId,
                );
                //add a new chat
                chatState.addChat(chat);
              },
            ),
          );
      // set indexto 2
      // IndexProvider().setIndex(2);
    } else if (message.notification!.body ==
        "Rider has delivered item at destination") {
      navKey.currentState?.push(MaterialPageRoute(
          builder: (context) => RateRider(
                id: message.data["order_id"],
              )));
    }
    _initialized = true;
  }
  // }
}

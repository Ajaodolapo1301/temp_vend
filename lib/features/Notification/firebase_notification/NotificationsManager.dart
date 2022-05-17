// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:primhex/core/utils/myUtils/myUtils.dart';
// import 'package:primhex/features/authentication/api/data_source/local_data_source/user_hive.dart';
// import 'package:primhex/features/authentication/model/user.dart';
// import 'package:primhex/features/authentication/viewModel/loginState.dart';
// import 'package:primhex/features/chat/Pages/widget/answer_call.dart';
// import 'package:primhex/features/chat/model/chatModel.dart';
// import 'package:primhex/features/chat/viewModel/chatViewModel.dart';
//
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:primhex/main.dart';
//
//
// class PushNotificationsManager {
//
// ChatState chatState  = ChatState();
//
//   FirebaseMessaging firebaseMessaging;
//   bool _initialized = false;
//   static String _deviceToken = "";
//   UserHive hive = UserHive(hive: Hive);
//
//
//   static String get deviceToken => _deviceToken;
//   bool isDark = true;
//
//   Future<void> resetIsDark() async {
//     var pref = await SharedPreferences.getInstance();
//     isDark = pref.getBool("isDark") ?? false;
//   }
//   void  initEnv(accessToken){
//
//     _deviceToken = accessToken;
//   }
//
//
//   Future<void> _messageHandler(RemoteMessage message) async {
//     User user = await  hive.getUser();
//     String action = message.data["action"];
//     if (action == "call") {
//       //get Token
//       String channelName = message.data["channelName"];
//       String callerName = message.data["callerName"];
//       chatState.getCallToken(channel: channelName, token: user.token).then(
//             (value) =>
//             value.fold(
//                   (l) => print(l),
//                   (r) {
//                 navKey.currentState.push(MaterialPageRoute(
//                   builder: (index) =>
//                       AnswerCall(
//                         callerName: callerName,
//                         channelName: channelName,
//                         initiatingCall: false,
//                       ),
//                 ));
//                 // goto answer call page
//
//               },
//             ),
//       );
//     }else if(action == "message"){
//       String channelName = message.data["channelName"];
//       String senderName = message.data["senderName"];
//       String actualMessage = message.data["message"];
//       int senderId = message.data["senderId"];
//       // add a new message to list of messages if not previously added
//       chatState.getMessageToken(token: user.token, channel: channelName).then(
//             (value) => value.fold(
//               (l) => print(l),
//               (r) {
//             // create random int as id
//             int id = Random().nextInt(912921);
//             List<MessageModel> message = [
//               MessageModel(message: actualMessage, user: senderId.toString())
//             ];
//             //add a new chat
//             Chat chat = Chat(
//               chatId: id,
//               messages: message,
//               channelName: channelName,
//               riderName: senderName,
//               riderId: senderId,
//             );
//             chatState.addChat(chat);
//           },
//         ),
//       );
//     }
//
//   }
//   Future<void> init(context, ) async {
//     User user = await  hive.getUser();
//     FirebaseMessaging.instance.requestPermission();
//
//     if (!_initialized) {
//       // For iOS request permission first.
//       FirebaseMessaging.instance.getToken().then((value){
//         print("token");
//         print("token$value");
//         initEnv(value);
//       });
//       // _firebaseMessaging.
//
//       FirebaseMessaging.onMessage.listen((RemoteMessage message)async {
//           print(message.notification.body);
//
//             await actBasedOnMessage(message, user);
//       });
//       FirebaseMessaging messaging = FirebaseMessaging.instance;
//       NotificationSettings settings = await messaging.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );
//
//       FirebaseMessaging.onMessageOpenedApp.listen((message)async {
//         print(message.notification.body);
//
//         await actBasedOnMessage(message, user);
//       });
//       FirebaseMessaging.onBackgroundMessage(_messageHandler);
//
//
//       _initialized = true;
//     }
//   }
//
//    Future   actBasedOnMessage(RemoteMessage message, User user)async{
//         String action = message.data["action"];
//         if (action == "call") {
//           //get Token
//           String channelName = message.data["channelName"];
//           String callerName = message.data["callerName"];
//           chatState.getCallToken(channel: channelName, token: user.token).then(
//                 (value) =>
//                 value.fold(
//                       (l) => print(l),
//                       (r) {
//                     navKey.currentState.push(MaterialPageRoute(
//                       builder: (index) =>
//                           AnswerCall(
//                             callerName: callerName,
//                             channelName: channelName,
//                             initiatingCall: false,
//                           ),
//                     ));
//                     // goto answer call page
//
//                   },
//                 ),
//           );
//         }else if(action == "message"){
//           String channelName = message.data["channelName"];
//           String senderName = message.data["senderName"];
//           String actualMessage = message.data["message"];
//           int senderId = message.data["senderId"];
//           // add a new message to list of messages if not previously added
//           chatState.getMessageToken(token: user.token, channel: channelName).then(
//                 (value) => value.fold(
//                   (l) => print(l),
//                   (r) {
//                 // create random int as id
//                 int id = Random().nextInt(912921);
//                 List<MessageModel> message = [
//                   MessageModel(message: actualMessage, user: senderId.toString())
//                 ];
//                 //add a new chat
//                 Chat chat = Chat(
//                   chatId: id,
//                   messages: message,
//                   channelName: channelName,
//                   riderName: senderName,
//                   riderId: senderId,
//                 );
//                 chatState.addChat(chat);
//               },
//             ),
//           );
//         }
//       }
//
// }
//
//
//
//
// class Notification {
//   String sound;
//   String body;
//   String title;
//   String contentAvailable;
//   String priority;
//   String clickAction;
//   String date;
//
//   Notification(
//       {this.sound,
//         this.body,
//         this.title,
//         this.contentAvailable,
//         this.priority,
//         this.clickAction});
//
//   Notification.fromJson(Map<String, dynamic> json) {
//     sound = json['sound'];
//     body = json['body'];
//     title = json['title'];
//     contentAvailable = json['content_available'];
//     priority = json['priority'];
//     clickAction = json['click_action'];
//     date = MyUtils.formatDate(DateTime.now().toString());
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['sound'] = this.sound;
//     data['body'] = this.body;
//     data['title'] = this.title;
//     data['content_available'] = this.contentAvailable;
//     data['priority'] = this.priority;
//     data['click_action'] = this.clickAction;
//     data['date'] = this.date;
//     return data;
//   }
//
//   String toString(){
//     return toJson().toString();
//   }
// }
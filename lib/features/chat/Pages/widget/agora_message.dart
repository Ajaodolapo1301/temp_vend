import 'dart:async';

import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/apiUrls/env.dart';
import '../../../Notification/firebase_notification/push_notification_manager.dart';
import '../../../authentication/viewModel/loginState.dart';
import '../../model/chatModel.dart';
import '../../viewModel/chatViewModel.dart';

class AgoraMessage extends StatefulWidget {
  final String? channelName;
  final String? userName;
  final String? userId;
  final String? token;
  final String? myId;
  final int? chatId;
  final String? receiverFcmToken;
  AgoraMessage(
      {this.channelName,
      this.userName,
      this.token,
      this.userId,
      this.chatId,
      this.receiverFcmToken,
      this.myId});
  @override
  _AgoraMessageState createState() => _AgoraMessageState();
}

class _AgoraMessageState extends State<AgoraMessage> {
  bool _isLogin = false;

  final _peerMessageController = TextEditingController();

  final _infoStrings = <String>[];

  AgoraRtmClient? _client;
  AgoraRtmChannel? _channel;
  ChatState? chatState;
  LoginState? loginState;
  @override
  void initState() {
    super.initState();
    _createClient();
  }

  @override
  void dispose() {
    _client?.logout();
    _channel?.leave();
    _client?.releaseChannel(_channel!.channelId!);
    super.dispose();
    // logout();
  }

  @override
  Widget build(BuildContext context) {
    chatState = Provider.of(context);
    loginState = Provider.of(context);
    return Scaffold(
      // appBar: kAppBar('Chat with ' + widget.userName, showLead: true, onPress: (){
      //   pop(context);
      // } ),

      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [_buildMessages(), _buildSendPeerMessage()],
        ),
      ),
      // bottomSheet: _buildSendPeerMessage(),
    );
  }

  void _createClient() async {
    try {
      _client =
          await AgoraRtmClient.createInstance(SystemProperties.agoraAppID);

      _client?.onMessageReceived = (AgoraRtmMessage message, String peerId) {
        _log("Peer msg: " + peerId + ", msg: " + (message.text));
      };
      _client?.onConnectionStateChanged = (int state, int reason) {
        if (state == 5) {
          _client?.logout();
          _log('Logout.');
        }
      };
      print(widget.channelName);

      //login to the channel
      await _client?.login(widget.token, widget.myId!);
      _channel = await _createChannel(widget.channelName!);

      await _channel?.join();
      if (mounted) {
        setState(() {});
      }
    } on Exception catch (e) {
      // TODO
      print(e);
      print("wdffffff");
    }
  }

  List<MessageModel> messages = [];

  Future<AgoraRtmChannel?> _createChannel(String? name) async {
    try {
      AgoraRtmChannel? channel = await _client!.createChannel(name!);
      if (channel != null) {
        channel.onMemberJoined = (AgoraRtmMember member) {
          print("Member joined: " +
              member.userId +
              ', channel: ' +
              member.channelId);
        };
        channel.onMemberLeft = (AgoraRtmMember member) {
          print("Member left: " +
              member.userId +
              ', channel: ' +
              member.channelId);
        };
        channel.onMessageReceived =
            (AgoraRtmMessage message, AgoraRtmMember member) {
          //add message to list
          messages.add(
            MessageModel(message: message.text, user: member.userId),
          );

          setState(() {});
          _peerMessageController.clear();

          print(
            "Channel msg: " +
                member.userId +
                ", msg: " +
                (message.text.toString()),
          );
        };
      }
      return channel;
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  static TextStyle textStyle =
      const TextStyle(fontSize: 18, color: Colors.blue);

  Widget _buildSendPeerMessage() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _peerMessageController,
              decoration: const InputDecoration(
                hintText: 'Input message',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Icon(
                Icons.send,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onTap: sendMessage,
          )
        ],
      ),
    );
  }

  Widget _buildMessages() {
    return Expanded(
      child: ValueListenableBuilder(
          builder: (BuildContext context, List<Chat?>? value, Widget? child) {
            Chat? currentChat = value!
                .where((element) => element!.channelName == widget.channelName)
                .first;
            messages = currentChat!.messages!;
            return ListView.builder(
              itemBuilder: (context, i) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(8),
                  alignment: (messages[i].user == widget.myId)
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  color: (messages[i].user == widget.myId)
                      ? Colors.blue.withOpacity(0.2)
                      : Colors.green.withOpacity(0.2),
                  child: Text(
                    messages[i].message!,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                );
              },
              itemCount: messages.length,
            );
          },
          valueListenable: chatState!.chatsNotifier!),
    );
  }

  void logout() async {
    if (_isLogin) {
      try {
        await _client!.logout();
        await _channel!.leave();
        _client!.releaseChannel(_channel!.channelId!);
        _log('Logout success.');
      } catch (errorCode) {
        _log('Logout error: ' + errorCode.toString());
      }
    }
  }

  void sendMessage() async {
    String text = _peerMessageController.text;
    if (text.isEmpty) {
      return;
    }

    try {
      AgoraRtmMessage message = AgoraRtmMessage.fromText(text);
      _log(message.text);
      await _channel?.sendMessage(AgoraRtmMessage.fromText(text), false, true);
      MessageModel model = MessageModel(
          message: _peerMessageController.text, user: widget.myId!);
      //add message to lists of chats
      chatState!.addMessage(model, widget.chatId!);
      var res = await chatState?.sendFCMNotification(
          senderName: loginState!.user.fullName!,
          title: "Message from ${loginState!.user.fullName}",
          body: text,
          action: "message",
          channelName: widget.channelName!,
          senderId: loginState!.user.id.toString(),
          myToken: PushNotificationsManager.deviceToken,
          receiverToken: widget.receiverFcmToken!,
          message: text);
      _peerMessageController.clear();
      setState(() {});
      _log(' message sent.');
    } catch (errorCode) {
      _log('Send  message error: ' + errorCode.toString());
    }
  }

  void _log(String info) {
    print(info);
  }
}

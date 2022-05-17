import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vend_express/core/error/failures.dart';
import 'package:vend_express/features/chat/model/agora_token.dart';

import '../../../core/GlobalState/baseState.dart';
import '../model/chatModel.dart';
import '../repository/repos.dart';

abstract class AbstractChatViewModel extends BaseViewModel {
  Future<Either<Failure, AgoraToken>> getCallToken({channel, token});
  Future<Either<Failure, AgoraToken>> getMessageToken({channel, token});
  Future<Either<Failure, int>> sendFCMNotification(
      {String receiverToken,
      String myToken,
      String action,
      String senderName,
      String channelName,
      String message,
      String senderId,
      String body,
      String title});
}

class ChatState extends AbstractChatViewModel {
  @override
  Future<Either<Failure, AgoraToken>> getCallToken({channel, token}) async {
    setBusy(true);
    var res = await ChatRepoImpl().getCallToken(channel: channel, token: token);
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {
      return r;
    });

    return res;
  }

  ValueNotifier<List<Chat>> chatsNotifier = ValueNotifier<List<Chat>>(
    [],
  );

  ValueNotifier<bool> loadingNotifier = ValueNotifier<bool>(true);

  void addMessage(MessageModel message, int index) {
    chatsNotifier.value
        .where((element) => element.chatId == index)
        .first
        .messages!
        .add(message);
    notifyListeners();
    persistChats();
  }

  void addChat(Chat? chat) async {
    if (chatsNotifier.value
        .any((element) => element.channelName == chat!.channelName)) {
      chatsNotifier.value
          .where((element) => element.channelName == chat!.channelName)
          .first
          .messages!
          .addAll(chat!.messages!);
    } else {
      chatsNotifier.value.add(chat!);
    }
    notifyListeners();
    persistChats();
  }

  void filterChats(String filter) {
    if (filter.isEmpty) {
      getChats();
    } else {
      var filteredChats = chatsNotifier.value
          .where(
            (element) => element.riderName!.toLowerCase().contains(
                  filter.toLowerCase(),
                ),
          )
          .toList();
      chatsNotifier.value = filteredChats;
      notifyListeners();
    }
  }

  void persistChats() async {
    List<String> encodedChats = chatsNotifier.value.map((e) {
      return jsonEncode(e.toJson());
    }).toList();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList("chats", encodedChats);
  }

  getChats() async {
    loadingNotifier.value = true;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String>? storedChats = sharedPreferences.getStringList("chats");
    if (storedChats != null) {
      chatsNotifier.value = storedChats.map((e) {
        return Chat.fromJson(jsonDecode(e));
      }).toList();
      notifyListeners();
    }
  }

  @override
  Future<Either<Failure, AgoraToken>> getMessageToken({channel, token}) async {
    setBusy(true);
    var res =
        await ChatRepoImpl().getMessageToken(channel: channel, token: token);
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {
      return r;
    });

    return res;
  }

  @override
  Future<Either<Failure, int>> sendFCMNotification(
      {String? receiverToken,
      String? myToken,
      String? action,
      String? senderName,
      String? channelName,
      String? message,
      String? senderId,
      String? body,
      String? title}) async {
    setBusy(true);
    var res = await ChatRepoImpl().sendFCMNotification(
        receiverToken: receiverToken,
        action: action,
        channelName: channelName,
        body: body,
        title: title,
        senderId: senderId,
        senderName: senderName,
        message: message,
        myToken: myToken);
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {
      return r;
    });

    return res;
  }
}

class Chat {
  int? chatId;
  String? riderName;
  String? riderId;
  String? token;
  String? channelName;
  List<MessageModel>? messages;
  String? receiverFcmToken;

  Chat(
      {this.chatId,
      this.messages,
      this.riderId,
      this.channelName,
      this.receiverFcmToken,
      this.token,
      this.riderName});

  Chat.fromJson(Map<String, dynamic> json) {
    chatId = json["chatId"];
    riderName = json["riderName"];
    riderId = json["senderId"];
    channelName = json["channelName"];
    receiverFcmToken = json["receiverFcmToken"];
    token = json["token"];
    messages = List.from(json["messages"])
        .map((e) => MessageModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data["chatId"] = chatId;
    _data["riderName"] = riderName;
    _data["senderId"] = riderId;
    _data["channelName"] = channelName;
    _data["receiverFcmToken"] = receiverFcmToken;
    _data["token"] = token;
    _data["messages"] = messages!.map((e) => e.toJson()).toList();

    return _data;
  }
}

class MessageModel {
  String? message;
  String? user;
  MessageModel({required this.message, required this.user});

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    user = json["user"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data["message"] = message;
    _data["user"] = user;

    return _data;
  }
}

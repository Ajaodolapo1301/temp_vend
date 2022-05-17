class AgoraToken {
  String? token;
  AgoraToken({this.token});

  AgoraToken.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }
}

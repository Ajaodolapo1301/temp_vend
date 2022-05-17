class NotificationModel {
  int? id;
  String? title;
  String? log;

  NotificationModel({this.id, this.title, this.log});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    log = json['log'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['log'] = log;
    return data;
  }
}

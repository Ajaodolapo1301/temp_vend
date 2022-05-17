class AnalyticsModel {
  num? totalOrder;
  num? completed;
  num? cancelled;
  num? active;
  num? totalAmount;

  AnalyticsModel(
      {this.totalOrder,
      this.completed,
      this.cancelled,
      this.active,
      this.totalAmount});

  AnalyticsModel.fromJson(Map<String, dynamic> json) {
    totalOrder = json['total_order'];
    completed = json['completed'];
    cancelled = json['cancelled'];
    active = json['active'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_order'] = totalOrder;
    data['completed'] = completed;
    data['cancelled'] = cancelled;
    data['active'] = active;
    data['total_amount'] = totalAmount;
    return data;
  }
}

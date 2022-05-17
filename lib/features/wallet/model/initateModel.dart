class InitiateModel {
  int? id;
  String? transactionId;

  InitiateModel({this.id, this.transactionId});

  InitiateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionId = json['transaction_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['transaction_id'] = transactionId;
    return data;
  }
}

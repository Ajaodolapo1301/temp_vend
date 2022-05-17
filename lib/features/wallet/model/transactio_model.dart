class TransactionModel {
  final String? description;
  final bool? isDebit;
  final String? date;
  final String? amount;
  TransactionModel(
      {this.amount, this.date, this.description, this.isDebit = true});
}

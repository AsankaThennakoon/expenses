class Transaction {
  final String transcationId;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    required this.amount,
    required this.date,
    required this.title,
    required this.transcationId,
  });
}

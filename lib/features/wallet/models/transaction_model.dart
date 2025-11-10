enum TransactionStatus {
  pending,
  completed,
  failed,
}

class Transaction {
  final String id;
  final String title;
  final String type;
  final int coins;
  final double amount;
  final DateTime timestamp;
  final TransactionStatus status;
  final String? description;

  const Transaction({
    required this.id,
    required this.title,
    required this.type,
    required this.coins,
    required this.amount,
    required this.timestamp,
    required this.status,
    this.description,
  });
}
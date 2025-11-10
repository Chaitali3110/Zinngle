// lib/features/wallet/models/transaction_model.dart

class Transaction {
  final String id;
  final String type;
  final String title;
  final double amount;
  final DateTime timestamp;
  final String status;
  final String description;

  Transaction({
    required this.id,
    required this.type,
    required this.title,
    required this.amount,
    required this.timestamp,
    required this.status,
    required this.description,
  });
}
// lib/features/chat/models/message_model.dart
class Message {
  final String id;
  final String? text;
  final String? imagePath;
  final bool isSentByMe;
  final DateTime timestamp;

  const Message({
    required this.id,
    this.text,
    this.imagePath,
    required this.isSentByMe,
    required this.timestamp,
  });
}

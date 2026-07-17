import 'attachment_model.dart';

enum MessageType {
  user,
  assistant,
  system,
}

class ChatMessage {
  final String id;

  final String text;

  final MessageType type;

  final DateTime timestamp;

  final List<AttachmentModel> attachments;

  final bool isTyping;

  final bool isError;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.type,
    required this.timestamp,
    this.attachments = const [],
    this.isTyping = false,
    this.isError = false,
  });
  factory ChatMessage.user({
  required String text,
  List<AttachmentModel> attachments = const [],
}) {
  return ChatMessage(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    text: text,
    type: MessageType.user,
    timestamp: DateTime.now(),
    attachments: attachments,
  );
}

factory ChatMessage.ai({
  required String text,
}) {
  return ChatMessage(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    text: text,
    type: MessageType.assistant,
    timestamp: DateTime.now(),
  );
}

  bool get isUser => type == MessageType.user;

  bool get isAssistant => type == MessageType.assistant;

  ChatMessage copyWith({
    String? id,
    String? text,
    MessageType? type,
    DateTime? timestamp,
    List<AttachmentModel>? attachments,
    bool? isTyping,
    bool? isError,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      attachments: attachments ?? this.attachments,
      isTyping: isTyping ?? this.isTyping,
      isError: isError ?? this.isError,
    );
  }
}

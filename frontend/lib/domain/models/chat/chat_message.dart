import 'package:event_planr_app/domain/models/chat/sender.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String chatId,
    required String content,
    required DateTime createdAt,
    required Sender sender,
  }) = _ChatMessage;
}

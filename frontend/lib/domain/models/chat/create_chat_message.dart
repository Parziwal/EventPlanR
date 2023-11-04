import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_chat_message.freezed.dart';

@freezed
class CreateChatMessage with _$CreateChatMessage {
  const factory CreateChatMessage({
    required String chatId,
    required String content,
  }) = _CreateChatMessage;
}

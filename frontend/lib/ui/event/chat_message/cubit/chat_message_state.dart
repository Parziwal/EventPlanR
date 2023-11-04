part of 'chat_message_cubit.dart';

enum ChatMessageStatus {
  idle,
  loading,
  error,
}

@freezed
class ChatMessageState with _$ChatMessageState {
  const factory ChatMessageState({
    required ChatMessageStatus status,
    Chat? chat,
    @Default([])
    List<Message> messages,
    @Default(User(id: ''))
    User user,
    String? errorCode,
  }) = _ChatMessageState;
}

part of 'user_chats_cubit.dart';

enum UserChatsStatus {
  idle,
  loading,
  error,
  chatCreated
}

@freezed
class UserChatsState with _$UserChatsState {
  const factory UserChatsState({
    required UserChatsStatus status,
    List<Chat>? chats,
    int? pageNumber,
    Exception? exception,
  }) = _UserChatsState;
}

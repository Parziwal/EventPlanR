part of 'chat_cubit.dart';

enum ChatStatus {
  loading,
  success,
  failed,
  newMessage,
}

class ChatState extends Equatable {
  const ChatState({
    this.status = ChatStatus.loading,
    this.user = const types.User(id: ''),
    this.messages = const [],
  });

  final ChatStatus status;
  final types.User user;
  final List<types.Message> messages;

  ChatState copyWith({
    ChatStatus Function()? status,
    types.User Function()? user,
    List<types.Message> Function()? messages,
  }) {
    return ChatState(
      status: status != null ? status() : this.status,
      user: user != null ? user() : this.user,
      messages: messages != null ? messages() : this.messages,
    );
  }

  @override
  List<Object> get props => [status, user, messages];
}

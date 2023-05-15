part of 'message_cubit.dart';

@immutable
abstract class MessageState extends Equatable {
}

class MessageLoading extends MessageState {
  @override
  List<Object?> get props => [];
}

class MessageUserList extends MessageState {
  MessageUserList({this.users = const[]});

  final List<User> users;

  @override
  List<Object?> get props => [users];
}

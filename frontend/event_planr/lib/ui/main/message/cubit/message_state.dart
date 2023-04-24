part of 'message_cubit.dart';

@immutable
abstract class MessageState extends Equatable {
}

class MessageIdle extends MessageState {
  @override
  List<Object?> get props => [];
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_planr/domain/auth/auth_repository.dart';
import 'package:event_planr/domain/message/message_repository.dart';
import 'package:event_planr/domain/message/models/message.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:injectable/injectable.dart';

part 'chat_state.dart';

@injectable
class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.authRepository, this.messageRepository)
      : super(const ChatState());

  final AuthRepository authRepository;
  final MessageRepository messageRepository;
  late String conversationId;
  StreamSubscription<Message>? subscription;

  Future<void> getMessages(String reciverUser) async {
    emit(const ChatState());
    final senderUser = (await authRepository.user).email;
    conversationId = ([reciverUser, senderUser]..sort()).join();
    subscribeToNewMessages();
    final messages = await messageRepository.getMessages(conversationId);
    emit(
      ChatState(
        status: ChatStatus.success,
        user: types.User(id: senderUser),
        messages: messages
            .map(
              (m) => types.TextMessage(
                author: types.User(id: m.sender),
                createdAt: m.createdAt.millisecondsSinceEpoch,
                id: m.createdAt.toString(),
                text: m.content,
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> addMessage(types.PartialText message) async {
    await messageRepository.addMessage(
      Message(
        conversationId: conversationId,
        content: message.text,
        createdAt: DateTime.now(),
        sender: state.user.id,
      ),
    );
  }

  void subscribeToNewMessages() {
    subscription =
        messageRepository.subscribeToNewMessage(conversationId).listen((m) {
      emit(
        state.copyWith(
          status: () => ChatStatus.newMessage,
          messages: () => state.messages
            ..insert(
              0,
              types.TextMessage(
                author: types.User(id: m.sender),
                createdAt: m.createdAt.millisecondsSinceEpoch,
                id: m.createdAt.toString(),
                text: m.content,
              ),
            ),
        ),
      );
      emit(state.copyWith(status: () => ChatStatus.success));
    });
  }

  @override
  Future<void> close() async {
    await subscription?.cancel();
    subscription = null;
    await super.close();
  }
}
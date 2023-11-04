import 'dart:async';

import 'package:event_planr_app/domain/auth_repository.dart';
import 'package:event_planr_app/domain/chat_repository.dart';
import 'package:event_planr_app/domain/models/chat/chat.dart';
import 'package:event_planr_app/domain/models/chat/create_chat_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'chat_message_state.dart';

part 'chat_message_cubit.freezed.dart';

@injectable
class ChatMessageCubit extends Cubit<ChatMessageState> {
  ChatMessageCubit({
    required AuthRepository authRepository,
    required ChatRepository chatRepository,
  })  : _authRepository = authRepository,
        _chatRepository = chatRepository,
        super(const ChatMessageState(status: ChatMessageStatus.idle));

  final AuthRepository _authRepository;
  final ChatRepository _chatRepository;
  StreamSubscription<Message>? _subscription;
  late final String _chatId;

  Future<void> loadMessages(String chatId) async {
    _chatId = chatId;
    try {
      emit(state.copyWith(status: ChatMessageStatus.loading));
      final user = await _authRepository.user;
      final chat = _chatRepository.getSelectedChat();
      final messages = await _chatRepository.getChatMessages(chatId);

      subscribeToNewMessages(chatId);
      emit(
        state.copyWith(
          chat: chat,
          user: User(
            id: user.id,
            firstName: user.firstName,
            lastName: user.lastName,
          ),
          messages: messages
              .map(
                (m) => TextMessage(
                  id: m.createdAt.toString(),
                  author: User(
                    id: m.sender.id,
                    firstName: m.sender.firstName,
                    lastName: m.sender.lastName,
                    imageUrl: m.sender.profileImageUrl,
                  ),
                  text: m.content,
                  createdAt: m.createdAt.millisecondsSinceEpoch,
                ),
              )
              .toList(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ChatMessageStatus.error,
          errorCode: e.toString(),
        ),
      );
    }

    emit(state.copyWith(status: ChatMessageStatus.idle));
  }

  Future<void> createMessage(CreateChatMessage message) async {
    try {
      await _chatRepository.createMessage(message);
    } catch (e) {
      emit(
        state.copyWith(
          status: ChatMessageStatus.error,
          errorCode: e.toString(),
        ),
      );
    }
    emit(state.copyWith(status: ChatMessageStatus.idle));
  }

  void subscribeToNewMessages(String chatId) {
    _subscription = _chatRepository
        .subscribeToNewMessage(chatId)
        .map(
          (m) => TextMessage(
            id: m.createdAt.toString(),
            text: m.content,
            author: User(
              id: m.sender.id,
              firstName: m.sender.firstName,
              lastName: m.sender.lastName,
              imageUrl: m.sender.profileImageUrl,
            ),
            createdAt: m.createdAt.millisecondsSinceEpoch,
          ),
        )
        .listen((m) {
      emit(
        state.copyWith(
          messages: [m, ...state.messages],
        ),
      );
    });
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    _subscription = null;
    await _chatRepository.getChatMessages(_chatId);
    await super.close();
  }
}

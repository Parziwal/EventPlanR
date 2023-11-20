import 'package:event_planr_app/domain/chat_repository.dart';
import 'package:event_planr_app/domain/models/chat/chat.dart';
import 'package:event_planr_app/domain/models/chat/chat_filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_chats_state.dart';

part 'user_chats_cubit.freezed.dart';

@injectable
class UserChatsCubit extends Cubit<UserChatsState> {
  UserChatsCubit({
    required ChatRepository chatRepository,
  })  : _chatRepository = chatRepository,
        super(const UserChatsState(status: UserChatsStatus.idle));

  final ChatRepository _chatRepository;

  Future<void> getDirectChats(int pageNumber) async {
    try {
      emit(
        state.copyWith(
          status: UserChatsStatus.loading,
          chats: pageNumber == 1 ? null : state.chats,
        ),
      );
      final chats = await _chatRepository
          .getDirectChats(ChatFilter(pageSize: 20, pageNumber: pageNumber));
      emit(
        state.copyWith(
          chats:
              pageNumber == 1 ? chats.items : [...state.chats!, ...chats.items],
          pageNumber: chats.hasNextPage ? pageNumber + 1 : null,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: UserChatsStatus.error,
          exception: e,
        ),
      );
    }

    emit(state.copyWith(status: UserChatsStatus.idle));
  }

  Future<void> getEventChats(int pageNumber) async {
    try {
      emit(
        state.copyWith(
          status: UserChatsStatus.loading,
          chats: pageNumber == 1 ? null : state.chats,
        ),
      );
      final chats = await _chatRepository
          .getEventsChats(ChatFilter(pageSize: 20, pageNumber: pageNumber));
      emit(
        state.copyWith(
          chats:
              pageNumber == 1 ? chats.items : [...state.chats!, ...chats.items],
          pageNumber: chats.hasNextPage ? pageNumber + 1 : null,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: UserChatsStatus.error,
          exception: e,
        ),
      );
    }

    emit(state.copyWith(status: UserChatsStatus.idle));
  }

  Future<void> createDirectChat(String email) async {
    try {
      emit(state.copyWith(status: UserChatsStatus.loading));
      await _chatRepository.createDirectChat(email);
      emit(
        state.copyWith(
          status: UserChatsStatus.chatCreated,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: UserChatsStatus.error,
          exception: e,
        ),
      );
    }

    emit(state.copyWith(status: UserChatsStatus.idle));
    await getDirectChats(1);
  }

  Future<void> setSelectedChat(Chat chat) async {
    await _chatRepository.setSelectedChat(chat);
  }
}

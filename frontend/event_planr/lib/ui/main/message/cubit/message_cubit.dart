import 'package:equatable/equatable.dart';
import 'package:event_planr/domain/message/message_repository.dart';
import 'package:event_planr/domain/message/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'message_state.dart';

@injectable
class MessageCubit extends Cubit<MessageState> {
  MessageCubit(this.messageRepository): super(MessageLoading());

  final MessageRepository messageRepository;

  Future<void> getUsers() async {
    emit(MessageLoading());
    final users = await messageRepository.getUsers();
    emit(MessageUserList(users: users));
  }
}

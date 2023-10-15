import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_event_tickets_state.dart';
part 'user_event_tickets_cubit.freezed.dart';

class UserEventTicketsCubit extends Cubit<UserEventTicketsState> {
  UserEventTicketsCubit() : super(const UserEventTicketsState.initial());
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_event_tickets_state.dart';
part 'user_event_tickets_cubit.freezed.dart';

@injectable
class UserEventTicketsCubit extends Cubit<UserEventTicketsState> {
  UserEventTicketsCubit() : super(const UserEventTicketsState.initial());
}

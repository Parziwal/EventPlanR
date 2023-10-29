import 'package:event_planr_app/domain/models/event/event.dart';
import 'package:event_planr_app/domain/models/event/user_event_filter.dart';
import 'package:event_planr_app/domain/user_ticket_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_events_state.dart';

part 'user_events_cubit.freezed.dart';

@injectable
class UserEventsCubit extends Cubit<UserEventsState> {
  UserEventsCubit({
    required UserTicketRepository userTicketRepository,
  })  : _userTicketRepository = userTicketRepository,
        super(
          const UserEventsState(status: UserEventsStatus.idle),
        );

  final UserTicketRepository _userTicketRepository;

  Future<void> getUserUpcomingEvents(int pageNumber) async {
    try {
      final events = await _userTicketRepository.getUserUpcomingEvents(
        UserEventFilter(
          pageNumber: pageNumber,
          pageSize: 20,
        ),
      );
      emit(
        state.copyWith(
          events: pageNumber == 1
              ? events.items
              : [...state.events, ...events.items],
          pageNumber: events.hasNextPage ? pageNumber + 1 : null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: UserEventsStatus.error,
          errorCode: e.toString(),
        ),
      );
    }
    emit(state.copyWith(status: UserEventsStatus.idle));
  }

  Future<void> getUserPastEvents(int pageNumber) async {
    try {
      final events = await _userTicketRepository.getUserPastEvents(
        UserEventFilter(
          pageNumber: pageNumber,
          pageSize: 20,
        ),
      );
      emit(
        state.copyWith(
          events: pageNumber == 1
              ? events.items
              : [...state.events, ...events.items],
          pageNumber: events.hasNextPage ? pageNumber + 1 : null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: UserEventsStatus.error,
          errorCode: e.toString(),
        ),
      );
    }
    emit(state.copyWith(status: UserEventsStatus.idle));
  }

  Future<void> getUserEventInvitations(int pageNumber) async {
    try {
      final events = await _userTicketRepository.getUserEventInvitations(
        UserEventFilter(
          pageNumber: pageNumber,
          pageSize: 20,
        ),
      );
      emit(
        state.copyWith(
          events: pageNumber == 1
              ? events.items
              : [...state.events, ...events.items],
          pageNumber: events.hasNextPage ? pageNumber + 1 : null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: UserEventsStatus.error,
          errorCode: e.toString(),
        ),
      );
    }
    emit(state.copyWith(status: UserEventsStatus.idle));
  }
}

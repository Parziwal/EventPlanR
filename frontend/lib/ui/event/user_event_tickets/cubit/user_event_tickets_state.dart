part of 'user_event_tickets_cubit.dart';

enum UserEventTicketsStatus { idle, loading, error }

@freezed
class UserEventTicketsState with _$UserEventTicketsState {
  const factory UserEventTicketsState({
    required UserEventTicketsStatus status,
    @Default([])
    List<SoldTicket> soldTickets,
    Exception? exception,
  }) = _UserEventTicketsState;
}

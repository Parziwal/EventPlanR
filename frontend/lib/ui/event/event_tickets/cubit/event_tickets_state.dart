part of 'event_tickets_cubit.dart';

enum EventTicketsStatus {
  idle,
  loading,
  error,
}

@freezed
class EventTicketsState with _$EventTicketsState {
  const factory EventTicketsState({
    required EventTicketsStatus status,
    @Default(0)
    double totalPrice,
    List<Ticket>? tickets,
    String? errorCode,
  }) = _EventTicketsState;
}

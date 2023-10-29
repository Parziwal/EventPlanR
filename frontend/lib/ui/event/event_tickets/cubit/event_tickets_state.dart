part of 'event_tickets_cubit.dart';

enum EventTicketsStatus {
  idle,
  loading,
  error,
  ticketsReserved,
}

@freezed
class EventTicketsState with _$EventTicketsState {
  const factory EventTicketsState({
    required EventTicketsStatus status,
    @Default(0)
    double totalPrice,
    CurrencyEnum? currency,
    @Default([])
    List<Ticket> tickets,
    @Default([])
    List<AddReserveTicket> reservedTickets,
    String? errorCode,
  }) = _EventTicketsState;
}

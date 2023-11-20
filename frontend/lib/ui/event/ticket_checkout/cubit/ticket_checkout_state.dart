part of 'ticket_checkout_cubit.dart';

enum TicketCheckoutStatus {
  idle, loading, error, ticketsOrdered
}

@freezed
class TicketCheckoutState with _$TicketCheckoutState {
  const factory TicketCheckoutState({
    required TicketCheckoutStatus status,
    @Default([])
    List<AddReserveTicket> reservedTickets,
    DateTime? expirationTime,
    Exception? exception,
}) = _TicketCheckoutState;
}

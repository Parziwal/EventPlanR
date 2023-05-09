part of 'event_ticket_cubit.dart';

enum EventTicketStatus {
  loading,
  success,
  failure,
  checkout,
}

class EventTicketState extends Equatable {
  const EventTicketState({
    this.status = EventTicketStatus.loading,
    this.eventTickets = const [],
    this.buyTickets = const [],
    this.totalPrice = 0,
  });

  final EventTicketStatus status;
  final List<EventTicket> eventTickets;
  final List<BuyTicket> buyTickets;
  final double totalPrice;

  EventTicketState copyWith({
    EventTicketStatus Function()? status,
    List<EventTicket> Function()? eventTickets,
    List<BuyTicket> Function()? buyTickets,
    double Function()? totalPrice,
  }) {
    return EventTicketState(
      status: status != null ? status() : this.status,
      eventTickets: eventTickets != null ? eventTickets() : this.eventTickets,
      buyTickets: buyTickets != null ? buyTickets() : this.buyTickets,
      totalPrice: totalPrice != null ? totalPrice() : this.totalPrice,
    );
  }

  @override
  List<Object> get props => [
        status,
        eventTickets,
        buyTickets,
        totalPrice,
      ];
}

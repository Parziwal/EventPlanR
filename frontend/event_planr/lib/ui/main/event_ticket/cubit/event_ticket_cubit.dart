import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_planr/domain/ticket/models/buy_ticket.dart';
import 'package:event_planr/domain/ticket/models/event_ticket.dart';
import 'package:event_planr/domain/ticket/ticket_repository.dart';
import 'package:injectable/injectable.dart';
part 'event_ticket_state.dart';

@injectable
class EventTicketCubit extends Cubit<EventTicketState> {
  EventTicketCubit(this.ticketRepository) : super(const EventTicketState());

  final TicketRepository ticketRepository;
  String? eventId;

  Future<void> getEventTickets(String eventId) async {
    this.eventId = eventId;
    emit(
      state.copyWith(
        status: () => EventTicketStatus.loading,
      ),
    );
    final eventTickets = await ticketRepository.getEventTickets(eventId);
    emit(
      state.copyWith(
        status: () => EventTicketStatus.success,
        eventTickets: () => eventTickets,
      ),
    );
  }

  Future<void> addTicket(String ticketName) async {
    final index =
        state.buyTickets.indexWhere((t) => t.ticketName == ticketName);
    final buyTickets = List<BuyTicket>.from(state.buyTickets);
    if (index != -1) {
      final removed = buyTickets.removeAt(index);
      buyTickets.insert(
        index,
        removed.copyWith(
          quantity: () => removed.quantity + 1,
        ),
      );
    } else {
      buyTickets.add(BuyTicket(ticketName: ticketName, quantity: 1));
    }

    final ticketPrice =
        state.eventTickets.firstWhere((t) => t.name == ticketName).price;

    emit(
      state.copyWith(
        buyTickets: () => buyTickets,
        totalPrice: () => state.totalPrice + ticketPrice,
      ),
    );
  }

  Future<void> removeTicket(String ticketName) async {
    final index =
        state.buyTickets.indexWhere((t) => t.ticketName == ticketName);
    final buyTickets = List<BuyTicket>.from(state.buyTickets);
    final removed = buyTickets.removeAt(index);
    if (removed.quantity != 1) {
      buyTickets.insert(
        index,
        removed.copyWith(
          quantity: () => removed.quantity - 1,
        ),
      );
    }

    final ticketPrice =
        state.eventTickets.firstWhere((t) => t.name == ticketName).price;

    emit(
      state.copyWith(
        buyTickets: () => buyTickets,
        totalPrice: () => state.totalPrice - ticketPrice,
      ),
    );
  }

  Future<void> buyTickets() async {
    emit(
      state.copyWith(
        status: () => EventTicketStatus.loading,
      ),
    );
    await ticketRepository.buyTicket(eventId!, state.buyTickets);
    emit(
      state.copyWith(
        status: () => EventTicketStatus.checkout,
      ),
    );
  }
}

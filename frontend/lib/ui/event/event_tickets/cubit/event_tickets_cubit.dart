import 'package:event_planr_app/domain/event_general_repository.dart';
import 'package:event_planr_app/domain/models/event/currency_enum.dart';
import 'package:event_planr_app/domain/models/ticket/add_reserve_ticket.dart';
import 'package:event_planr_app/domain/models/ticket/ticket.dart';
import 'package:event_planr_app/domain/ticket_order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'event_tickets_state.dart';

part 'event_tickets_cubit.freezed.dart';

@injectable
class EventTicketsCubit extends Cubit<EventTicketsState> {
  EventTicketsCubit({
    required EventGeneralRepository eventGeneralRepository,
    required TicketOrderRepository ticketOrderRepository,
  })  : _eventGeneralRepository = eventGeneralRepository,
        _ticketOrderRepository = ticketOrderRepository,
        super(const EventTicketsState(status: EventTicketsStatus.idle));

  final EventGeneralRepository _eventGeneralRepository;
  final TicketOrderRepository _ticketOrderRepository;

  Future<void> loadEventTickets(String eventId) async {
    try {
      emit(state.copyWith(status: EventTicketsStatus.loading));
      final tickets = await _eventGeneralRepository.getEventTickets(eventId);
      emit(
        state.copyWith(
          tickets: tickets,
          currency: tickets.isNotEmpty ? tickets.first.currency : null,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: EventTicketsStatus.error,
          exception: e,
        ),
      );
    }

    emit(state.copyWith(status: EventTicketsStatus.idle));
  }

  Future<void> addTicket(Ticket ticket) async {
    final reservedTickets = state.reservedTickets.toList();
    final index = reservedTickets.indexWhere((t) => t.ticketId == ticket.id);
    if (index != -1) {
      final removed = reservedTickets.removeAt(index);
      reservedTickets.insert(
        index,
        removed.copyWith(
          count: removed.count + 1,
        ),
      );
    } else {
      reservedTickets.add(
        AddReserveTicket(
          ticketId: ticket.id,
          ticketName: ticket.name,
          count: 1,
        ),
      );
    }

    emit(
      state.copyWith(
        totalPrice: state.totalPrice + ticket.price,
        reservedTickets: reservedTickets,
      ),
    );
  }

  Future<void> removeTicket(Ticket ticket) async {
    final reservedTickets = state.reservedTickets.toList();
    final index = reservedTickets.indexWhere((t) => t.ticketId == ticket.id);
    final removed = reservedTickets.removeAt(index);
    if (removed.count != 1) {
      reservedTickets.insert(
        index,
        removed.copyWith(
          count: removed.count - 1,
        ),
      );
    }

    emit(
      state.copyWith(
        totalPrice: state.totalPrice - ticket.price,
        reservedTickets: reservedTickets,
      ),
    );
  }

  Future<void> reserveTickets() async {
    try {
      emit(state.copyWith(status: EventTicketsStatus.loading));
      await _ticketOrderRepository.reserveTickets(state.reservedTickets);
      emit(state.copyWith(status: EventTicketsStatus.ticketsReserved));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: EventTicketsStatus.error,
          exception: e,
          reservedTickets: [],
          totalPrice: 0,
        ),
      );
    }

    emit(state.copyWith(status: EventTicketsStatus.idle));
  }
}

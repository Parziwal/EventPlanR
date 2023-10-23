import 'package:event_planr_app/domain/event_general_repository.dart';
import 'package:event_planr_app/domain/models/ticket/ticket.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'event_tickets_state.dart';

part 'event_tickets_cubit.freezed.dart';

@injectable
class EventTicketsCubit extends Cubit<EventTicketsState> {
  EventTicketsCubit({required EventGeneralRepository eventGeneralRepository})
      : _eventGeneralRepository = eventGeneralRepository,
        super(const EventTicketsState(status: EventTicketsStatus.idle));

  final EventGeneralRepository _eventGeneralRepository;

  Future<void> loadEventTickets(String eventId) async {
    try {
      emit(state.copyWith(status: EventTicketsStatus.loading));
      final tickets =
          await _eventGeneralRepository.getEventTickets(eventId);
      emit(
        state.copyWith(
          status: EventTicketsStatus.idle,
          tickets: tickets,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: EventTicketsStatus.error,
          errorCode: e.toString(),
        ),
      );
    }
  }

  Future<void> addTicket(Ticket ticket) async {
    emit(
      state.copyWith(
        totalPrice: state.totalPrice + ticket.price,
      ),
    );
  }

  Future<void> removeTicket(Ticket ticket) async {
    emit(
      state.copyWith(
        totalPrice: state.totalPrice - ticket.price,
      ),
    );
  }
}

import 'package:event_planr_app/domain/models/ticket/organization_ticket.dart';
import 'package:event_planr_app/domain/ticket_manager_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'organization_event_tickets_state.dart';

part 'organization_event_tickets_cubit.freezed.dart';

@injectable
class OrganizationEventTicketsCubit
    extends Cubit<OrganizationEventTicketsState> {
  OrganizationEventTicketsCubit({
    required TicketManagerRepository ticketManagerRepository,
  })  : _ticketManagerRepository = ticketManagerRepository,
        super(
          const OrganizationEventTicketsState(
            status: OrganizationEventTicketsStatus.idle,
          ),
        );

  final TicketManagerRepository _ticketManagerRepository;

  Future<void> loadEventTickets(String eventId) async {
    try {
      emit(state.copyWith(status: OrganizationEventTicketsStatus.loading));
      final tickets =
          await _ticketManagerRepository.getOrganizationEventTickets(eventId);
      emit(
        state.copyWith(
          status: OrganizationEventTicketsStatus.idle,
          eventId: eventId,
          tickets: tickets,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: OrganizationEventTicketsStatus.error,
          exception: e,
        ),
      );
    }
  }

  Future<void> deleteTicket(String ticketId) async {
    try {
      await _ticketManagerRepository.deleteTicket(ticketId);
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: OrganizationEventTicketsStatus.error,
          exception: e,
        ),
      );
    }

    await loadEventTickets(state.eventId!);
  }
}

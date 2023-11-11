import 'package:event_planr_app/domain/models/ticket/check_in_ticket.dart';
import 'package:event_planr_app/domain/models/ticket/check_in_ticket_filter.dart';
import 'package:event_planr_app/domain/ticket_manager_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'organization_event_check_in_state.dart';

part 'organization_event_check_in_cubit.freezed.dart';

@injectable
class OrganizationEventCheckInCubit
    extends Cubit<OrganizationEventCheckInState> {
  OrganizationEventCheckInCubit({
    required TicketManagerRepository ticketManagerRepository,
  })  : _ticketManagerRepository = ticketManagerRepository,
        super(const OrganizationEventCheckInState());

  final TicketManagerRepository _ticketManagerRepository;

  Future<void> getCheckInTickets({
    required String eventId,
    required int pageNumber,
  }) async {
    try {
      emit(
        state.copyWith(
          soldTickets: pageNumber == 1 ? null : state.soldTickets,
        ),
      );
      final tickets =
          await _ticketManagerRepository.getOrganizationEvenCheckInTickets(
        CheckInTicketFilter(
          eventId: eventId,
          pageNumber: pageNumber,
          pageSize: 20,
        ),
      );
      emit(
        state.copyWith(
          soldTickets: pageNumber == 1
              ? tickets.items
              : [...state.soldTickets!, ...tickets.items],
          pageNumber: tickets.hasNextPage ? pageNumber + 1 : null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorCode: e.toString(),
        ),
      );
    }
  }

  Future<void> ticketCheckIn(String soldTicketId) async {
    if (state.soldTickets == null) {
      return;
    }

    try {
      final ticket =
          state.soldTickets!.where((t) => t.id == soldTicketId).single;
      final newTicket = await _ticketManagerRepository.ticketCheckIn(
        soldTicketId: ticket.id,
        checkIn: !ticket.isCheckedIn,
      );
      final newTickets = state.soldTickets!.toList();
      newTickets[newTickets.indexWhere((t) => t.id == soldTicketId)] =
          newTicket;
      emit(
        state.copyWith(
          soldTickets: newTickets,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorCode: e.toString(),
        ),
      );
    }
  }
}

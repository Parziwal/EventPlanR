import 'package:event_planr_app/domain/models/ticket/check_in_ticket_details.dart';
import 'package:event_planr_app/domain/ticket_manager_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'organization_event_check_in_details_state.dart';

part 'organization_event_check_in_details_cubit.freezed.dart';

@injectable
class OrganizationEventCheckInDetailsCubit
    extends Cubit<OrganizationEventCheckInDetailsState> {
  OrganizationEventCheckInDetailsCubit({
    required TicketManagerRepository ticketManagerRepository,
  })  : _ticketManagerRepository = ticketManagerRepository,
        super(
          const OrganizationEventCheckInDetailsState(
            status: OrganizationEventCheckInDetailsStatus.idle,
          ),
        );

  final TicketManagerRepository _ticketManagerRepository;

  Future<void> loadCheckInTicketDetails(String soldTicketId) async {
    try {
      emit(
        state.copyWith(
          status: OrganizationEventCheckInDetailsStatus.loading,
        ),
      );
      final ticket =
          await _ticketManagerRepository.getCheckInTicketDetails(soldTicketId);
      emit(
        state.copyWith(
          checkInTicketDetails: ticket,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: OrganizationEventCheckInDetailsStatus.error,
          errorCode: e.toString(),
        ),
      );
    }

    emit(state.copyWith(status: OrganizationEventCheckInDetailsStatus.idle));
  }

  Future<void> ticketCheckIn() async {
    if (state.checkInTicketDetails == null) {
      return;
    }

    try {
      emit(
        state.copyWith(
          status: OrganizationEventCheckInDetailsStatus.loading,
        ),
      );
      final ticket = await _ticketManagerRepository.ticketCheckIn(
        soldTicketId: state.checkInTicketDetails!.id,
        checkIn: !state.checkInTicketDetails!.isCheckedIn,
      );
      emit(
        state.copyWith(
          status: OrganizationEventCheckInDetailsStatus.checkedInChanged,
          checkInTicketDetails: state.checkInTicketDetails
              ?.copyWith(isCheckedIn: ticket.isCheckedIn),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: OrganizationEventCheckInDetailsStatus.error,
          errorCode: e.toString(),
        ),
      );
    }

    emit(
      state.copyWith(
        status: OrganizationEventCheckInDetailsStatus.idle,
      ),
    );
  }
}

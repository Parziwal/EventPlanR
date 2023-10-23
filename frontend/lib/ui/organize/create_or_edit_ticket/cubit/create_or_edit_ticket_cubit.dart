import 'package:event_planr_app/domain/models/ticket/add_or_edit_ticket.dart';
import 'package:event_planr_app/domain/models/ticket/organization_ticket.dart';
import 'package:event_planr_app/domain/ticket_manager_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'create_or_edit_ticket_state.dart';

part 'create_or_edit_ticket_cubit.freezed.dart';

@injectable
class CreateOrEditTicketCubit extends Cubit<CreateOrEditTicketState> {
  CreateOrEditTicketCubit({
    required TicketManagerRepository ticketManagerRepository,
  })  : _ticketManagerRepository = ticketManagerRepository,
        super(
          const CreateOrEditTicketState(
            status: CreateOrEditTicketStatus.idle,
          ),
        );

  final TicketManagerRepository _ticketManagerRepository;

  void loadTicketForEdit(OrganizationTicket ticket) {
    print(ticket);
    emit(
      state.copyWith(
        edit: true,
        ticket: ticket,
      ),
    );
  }

  Future<void> createOrEditTicket(
    AddOrEditTicket ticket,
  ) async {
    try {
      emit(state.copyWith(status: CreateOrEditTicketStatus.loading));
      await _ticketManagerRepository.addOrEditEventTicket(ticket);
      emit(
        state.copyWith(status: CreateOrEditTicketStatus.ticketSubmitted)
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CreateOrEditTicketStatus.error,
          errorCode: e.toString(),
        ),
      );
    }
  }
}

import 'package:event_planr_app/domain/models/ticket/check_in_ticket.dart';
import 'package:event_planr_app/domain/ticket_manager_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'check_in_ticket_scanner_state.dart';

part 'check_in_ticket_scanner_cubit.freezed.dart';

@injectable
class CheckInTicketScannerCubit extends Cubit<CheckInTicketScannerState> {
  CheckInTicketScannerCubit({
    required TicketManagerRepository ticketManagerRepository,
  })  : _ticketManagerRepository = ticketManagerRepository,
        super(
          const CheckInTicketScannerState(
            status: CheckInTicketScannerStatus.idle,
          ),
        );

  final TicketManagerRepository _ticketManagerRepository;

  Future<void> ticketCheckIn(String soldTicketId) async {
    try {
      final newTicket = await _ticketManagerRepository.ticketCheckIn(
        soldTicketId: soldTicketId,
        checkIn: true,
      );
      emit(
        state.copyWith(
          status: CheckInTicketScannerStatus.ticketChecked,
          checkedTicket: newTicket,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: CheckInTicketScannerStatus.error,
          exception: e,
        ),
      );
    }
  }
}

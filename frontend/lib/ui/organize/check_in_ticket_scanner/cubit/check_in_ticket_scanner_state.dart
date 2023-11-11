part of 'check_in_ticket_scanner_cubit.dart';

enum CheckInTicketScannerStatus {
  idle,
  error,
  ticketChecked,
}

@freezed
class CheckInTicketScannerState with _$CheckInTicketScannerState {
  const factory CheckInTicketScannerState({
    required CheckInTicketScannerStatus status,
    CheckInTicket? checkedTicket,
    String? errorCode,
  }) = _CheckInTicketScannerState;
}

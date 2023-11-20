part of 'create_or_edit_ticket_cubit.dart';

enum CreateOrEditTicketStatus {
  idle,
  loading,
  error,
  ticketSubmitted,
}

@freezed
class CreateOrEditTicketState with _$CreateOrEditTicketState {
  const factory CreateOrEditTicketState({
    required CreateOrEditTicketStatus status,
    @Default(false) bool edit,
    OrganizationTicket? ticket,
    Exception? exception,
  }) = _CreateOrEditTicketState;
}

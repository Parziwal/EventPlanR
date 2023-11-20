part of 'organization_event_check_in_cubit.dart';

@freezed
class OrganizationEventCheckInState with _$OrganizationEventCheckInState {
  const factory OrganizationEventCheckInState({
    List<CheckInTicket>? soldTickets,
    Exception? exception,
    int? pageNumber,
}) = _OrganizationEventCheckInState;
}

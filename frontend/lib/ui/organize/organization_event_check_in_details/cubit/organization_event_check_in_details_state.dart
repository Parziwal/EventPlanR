part of 'organization_event_check_in_details_cubit.dart';

enum OrganizationEventCheckInDetailsStatus {
  idle,
  loading,
  error,
  checkedInChanged,
}

@freezed
class OrganizationEventCheckInDetailsState
    with _$OrganizationEventCheckInDetailsState {
  const factory OrganizationEventCheckInDetailsState({
    required OrganizationEventCheckInDetailsStatus status,
    CheckInTicketDetails? checkInTicketDetails,
    Exception? exception,
  }) = _OrganizationEventCheckInDetailsState;
}

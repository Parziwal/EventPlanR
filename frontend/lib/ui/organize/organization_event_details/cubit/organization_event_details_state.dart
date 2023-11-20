part of 'organization_event_details_cubit.dart';

enum OrganizationEventDetailsStatus {
  idle,
  loading,
  error,
  eventPublished,
  eventDeleted,
}

@freezed
class OrganizationEventDetailsState with _$OrganizationEventDetailsState {
  const factory OrganizationEventDetailsState({
    required OrganizationEventDetailsStatus status,
    OrganizationEventDetails? eventDetails,
    Exception? exception,
  }) = _OrganizationEventDetailsState;
}

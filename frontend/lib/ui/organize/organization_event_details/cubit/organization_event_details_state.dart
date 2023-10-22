part of 'organization_event_details_cubit.dart';

enum OrganizationEventDetailsStatus { idle, loading, error }

@freezed
class OrganizationEventDetailsState with _$OrganizationEventDetailsState {
  const factory OrganizationEventDetailsState({
    required OrganizationEventDetailsStatus status,
    OrganizationEventDetails? eventDetails,
    String? errorCode,
  }) = _OrganizationEventDetailsState;
}

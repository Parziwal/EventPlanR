part of 'organization_events_cubit.dart';

enum OrganizationEventsStatus { idle, loading, error }

@freezed
class OrganizationEventsState with _$OrganizationEventsState {
  const factory OrganizationEventsState({
    required OrganizationEventsStatus status,
    PaginatedList<OrganizationEvent>? events,
    String? errorCode,
  }) = _OrganizationEventsState;
}

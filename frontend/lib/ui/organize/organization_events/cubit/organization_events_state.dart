part of 'organization_events_cubit.dart';

enum OrganizationEventsStatus { idle, error }

@freezed
class OrganizationEventsState with _$OrganizationEventsState {
  const factory OrganizationEventsState({
    required OrganizationEventsStatus status,
    @Default([])
    List<OrganizationEvent> events,
    int? pageNumber,
    String? errorCode,
  }) = _OrganizationEventsState;
}

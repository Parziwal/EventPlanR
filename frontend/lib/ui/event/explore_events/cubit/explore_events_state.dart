part of 'explore_events_cubit.dart';

@freezed
class ExploreEventsState with _$ExploreEventsState {
  const factory ExploreEventsState({
    required EventFilter eventFilter,
    required OrganizationFilter organizationFilter,
    @Default(true) bool eventView,
    List<Event>? events,
    List<Organization>? organizations,
    String? errorCode,
  }) = _ExploreEventsState;
}

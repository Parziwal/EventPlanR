part of 'explore_events_cubit.dart';

enum ExploreEventsStatus {
  idle,
  error,
}

@freezed
class ExploreEventsState with _$ExploreEventsState {
  const factory ExploreEventsState({
    required ExploreEventsStatus status,
    required EventFilter filter,
    @Default([])
    List<Event> events,
    String? errorCode,
  }) = _ExploreEventsState;
}

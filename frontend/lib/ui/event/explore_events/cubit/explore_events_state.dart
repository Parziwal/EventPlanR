part of 'explore_events_cubit.dart';

enum ExploreEventsStatus {
  idle,
  loading,
  error,
}

@freezed
class ExploreEventsState with _$ExploreEventsState {
  const factory ExploreEventsState({
    required ExploreEventsStatus status,
    required EventFilter filter,
    PaginatedList<Event>? events,
    String? errorCode,
  }) = _ExploreEventsState;
}

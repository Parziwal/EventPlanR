part of 'user_events_cubit.dart';

enum UserEventsStatus { idle, error }

@freezed
class UserEventsState with _$UserEventsState {
  const factory UserEventsState({
    required UserEventsStatus status,
    @Default([])
    List<Event> events,
    int? pageNumber,
    String? errorCode,
  }) = _UserEventsState;
}

part of 'event_details_cubit.dart';

enum EventDetailsStatus {
  idle,
  loading,
  error,
}

@freezed
class EventDetailsState with _$EventDetailsState {
  const factory EventDetailsState({
    required EventDetailsStatus status,
    EventDetails? eventDetails,
    String? errorCode,
  }) = _EventDetailsState;
}

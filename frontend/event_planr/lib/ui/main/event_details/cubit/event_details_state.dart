part of 'event_details_cubit.dart';

enum EventDetailsStatus {
  loading,
  success,
  failure,
}

@immutable
class EventDetailsState extends Equatable {
  const EventDetailsState({
    this.status = EventDetailsStatus.loading,
    this.event,
  });

  final EventDetailsStatus status;
  final EventDetails? event;

  EventDetailsState copyWith({
    EventDetailsStatus Function()? status,
    EventDetails Function()? event,
  }) {
    return EventDetailsState(
      status: status != null ? status() : this.status,
      event: event != null ? event() : this.event,
    );
  }

  @override
  List<Object?> get props => [
        status,
        event,
      ];
}

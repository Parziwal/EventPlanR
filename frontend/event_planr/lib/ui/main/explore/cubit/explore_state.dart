part of 'explore_cubit.dart';

enum ExploreStatus {
  loading,
  success,
  failure,
}

@immutable
class ExploreState extends Equatable {
  const ExploreState({
    this.status = ExploreStatus.loading,
    this.filter = const EventFilter(),
    this.events = const [],
  });

  final ExploreStatus status;
  final EventFilter filter;
  final List<Event> events;

  ExploreState copyWith({
    ExploreStatus Function()? status,
    EventFilter Function()? filter,
    List<Event> Function()? events,
  }) {
    return ExploreState(
      status: status != null ? status() : this.status,
      filter: filter != null ? filter() : this.filter,
      events: events != null ? events() : this.events,
    );
  }

  @override
  List<Object?> get props => [
        status,
        filter,
        events,
      ];
}

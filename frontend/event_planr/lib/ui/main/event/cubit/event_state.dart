part of 'event_cubit.dart';

@immutable
abstract class EventState extends Equatable {}

class EventLoading extends EventState {
  @override
  List<Object?> get props => [];
}

class EventEventList extends EventState {
  EventEventList(this.events);

  final List<Event> events; 

  @override
  List<Object?> get props => [events];
}

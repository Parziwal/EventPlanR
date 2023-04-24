part of 'explore_cubit.dart';

@immutable
abstract class ExploreState extends Equatable {}

class ExploreLoading extends ExploreState {
  @override
  List<Object?> get props => [];
}

class ExploreEventList extends ExploreState {
  ExploreEventList(this.events);

  final List<Event> events; 

  @override
  List<Object?> get props => [events];
}

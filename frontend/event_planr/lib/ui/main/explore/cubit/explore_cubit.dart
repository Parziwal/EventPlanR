import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_planr/domain/event/event.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

part 'explore_state.dart';

@injectable
class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit({required EventRepository eventRepository})
      : _eventRepository = eventRepository,
        super(const ExploreState());

  final EventRepository _eventRepository;

  Future<void> listEvents({EventFilter filter = const EventFilter()}) async {
    emit(state.copyWith(status: () => ExploreStatus.loading));
    final events = await _eventRepository.getEventList(filter);
    emit(
      state.copyWith(
        status: () => ExploreStatus.success,
        events: () => events,
        filter: () => filter,
      ),
    );
  }
}

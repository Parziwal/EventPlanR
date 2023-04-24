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
        super(ExploreLoading());

  final EventRepository _eventRepository;

  Future<void> listEvents() async {
    emit(ExploreLoading());
    final events = await _eventRepository.listEvents();
    emit(ExploreEventList(events));
  }
}

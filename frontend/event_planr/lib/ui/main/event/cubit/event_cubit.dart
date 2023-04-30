import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_planr/domain/event/event.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

part 'event_state.dart';

@injectable
class EventCubit extends Cubit<EventState> {
  EventCubit({required EventRepository eventRepository})
      : _eventRepository = eventRepository,
        super(EventLoading());

  final EventRepository _eventRepository;

  Future<void> listMyEvents({
    UserEventType type = UserEventType.upcoming,
  }) async {
    emit(EventLoading());
    final events = await _eventRepository.listMyEvents(type);
    emit(EventEventList(events));
  }
}

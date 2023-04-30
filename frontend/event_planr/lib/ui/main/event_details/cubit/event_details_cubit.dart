import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_planr/domain/event/event.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

part 'event_details_state.dart';

@injectable
class EventDetailsCubit extends Cubit<EventDetailsState> {
  EventDetailsCubit({required EventRepository eventRepository})
      : _eventRepository = eventRepository,
        super(const EventDetailsState());

  final EventRepository _eventRepository;

  Future<void> getEventDetail(String id) async {
    emit(state.copyWith(status: () => EventDetailsStatus.loading));
    final event = await _eventRepository.getEventDetails(id);
    emit(
      state.copyWith(
        status: () => EventDetailsStatus.success,
        event: () => event,
      ),
    );
  }
}

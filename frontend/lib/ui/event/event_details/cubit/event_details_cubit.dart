import 'package:event_planr_app/domain/event_general_repository.dart';
import 'package:event_planr_app/domain/models/event/event_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'event_details_state.dart';

part 'event_details_cubit.freezed.dart';

@injectable
class EventDetailsCubit extends Cubit<EventDetailsState> {
  EventDetailsCubit({required EventGeneralRepository eventGeneralRepository})
      : _eventGeneralRepository = eventGeneralRepository,
        super(const EventDetailsState(status: EventDetailsStatus.idle));

  final EventGeneralRepository _eventGeneralRepository;

  Future<void> loadEventDetails(String eventId) async {
    try {
      emit(state.copyWith(status: EventDetailsStatus.loading));
      final eventDetails =
          await _eventGeneralRepository.getEventDetails(eventId);
      emit(
        state.copyWith(
          status: EventDetailsStatus.idle,
          eventDetails: eventDetails,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: EventDetailsStatus.error,
          exception: e,
        ),
      );
    }
  }
}

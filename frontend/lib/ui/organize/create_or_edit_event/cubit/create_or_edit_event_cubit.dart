import 'package:event_planr_app/domain/event_manager_repository.dart';
import 'package:event_planr_app/domain/map_repository.dart';
import 'package:event_planr_app/domain/models/event/create_or_edit_event.dart';
import 'package:event_planr_app/domain/models/event/organization_event_details.dart';
import 'package:event_planr_app/domain/models/map/map_location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

part 'create_or_edit_event_state.dart';

part 'create_or_edit_event_cubit.freezed.dart';

@injectable
class CreateOrEditEventCubit extends Cubit<CreateOrEditEventState> {
  CreateOrEditEventCubit({
    required MapRepository mapRepository,
    required EventManagerRepository eventManagerRepository,
  })  : _mapRepository = mapRepository,
        _eventManagerRepository = eventManagerRepository,
        super(
          const CreateOrEditEventState(status: CreateOrEditEventStatus.idle),
        );

  final MapRepository _mapRepository;
  final EventManagerRepository _eventManagerRepository;

  Future<void> loadEventDetailsForEdit(String eventId) async {
    try {
      emit(
        state.copyWith(
          edit: true,
          status: CreateOrEditEventStatus.loading,
        ),
      );
      final eventDetails =
          await _eventManagerRepository.getOrganizationEventDetails(eventId);
      emit(
        state.copyWith(
          status: CreateOrEditEventStatus.idle,
          eventDetails: eventDetails,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: CreateOrEditEventStatus.error,
          exception: e,
        ),
      );
    }
  }

  Future<void> getLocationAddress(LatLng location) async {
    try {
      emit(state.copyWith(status: CreateOrEditEventStatus.loading));
      final locationDetails = await _mapRepository.reverseSearch(
        location.latitude,
        location.longitude,
      );
      emit(
        state.copyWith(
          status: CreateOrEditEventStatus.locationLoaded,
          location: locationDetails,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: CreateOrEditEventStatus.error,
          exception: e,
        ),
      );
    }
  }

  Future<void> createOrEditEvent(CreateOrEditEvent event) async {
    try {
      emit(state.copyWith(status: CreateOrEditEventStatus.loading));
      await _eventManagerRepository.createOrEditEvent(event);
      emit(state.copyWith(status: CreateOrEditEventStatus.eventSubmitted));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: CreateOrEditEventStatus.error,
          exception: e,
        ),
      );
    }
  }
}

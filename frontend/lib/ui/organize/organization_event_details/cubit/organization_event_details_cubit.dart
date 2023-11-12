import 'package:event_planr_app/domain/event_manager_repository.dart';
import 'package:event_planr_app/domain/models/event/organization_event_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

part 'organization_event_details_state.dart';

part 'organization_event_details_cubit.freezed.dart';

@injectable
class OrganizationEventDetailsCubit
    extends Cubit<OrganizationEventDetailsState> {
  OrganizationEventDetailsCubit({
    required EventManagerRepository eventManagerRepository,
  })  : _eventManagerRepository = eventManagerRepository,
        super(
          const OrganizationEventDetailsState(
            status: OrganizationEventDetailsStatus.idle,
          ),
        );

  final EventManagerRepository _eventManagerRepository;

  Future<void> loadEventDetails(String eventId) async {
    try {
      emit(state.copyWith(status: OrganizationEventDetailsStatus.loading));
      final eventDetails =
          await _eventManagerRepository.getOrganizationEventDetails(eventId);
      emit(
        state.copyWith(
          status: OrganizationEventDetailsStatus.idle,
          eventDetails: eventDetails,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: OrganizationEventDetailsStatus.error,
          errorCode: e.toString(),
        ),
      );
    }
  }

  Future<void> publishEvent() async {
    if (state.eventDetails == null) {
      return;
    }

    try {
      await _eventManagerRepository.publishEvent(
        eventId: state.eventDetails!.id,
        publish: !state.eventDetails!.isPublished,
      );
      emit(
        state.copyWith(
          status: OrganizationEventDetailsStatus.eventPublished,
          eventDetails: state.eventDetails!
              .copyWith(isPublished: !state.eventDetails!.isPublished),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: OrganizationEventDetailsStatus.error,
          errorCode: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteEvent() async {
    if (state.eventDetails == null) {
      return;
    }

    try {
      await _eventManagerRepository.deleteEvent(state.eventDetails!.id);
      emit(
        state.copyWith(
          status: OrganizationEventDetailsStatus.eventDeleted,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: OrganizationEventDetailsStatus.error,
          errorCode: e.toString(),
        ),
      );
    }
  }

  Future<void> uploadEventCoverImage(XFile image) async {
    if (state.eventDetails == null) {
      return;
    }

    try {
      emit(state.copyWith(status: OrganizationEventDetailsStatus.loading));
      final imageUrl = await _eventManagerRepository.uploadEventCoverImage(
        eventId: state.eventDetails!.id,
        image: image,
      );
      emit(
        state.copyWith(
          eventDetails: state.eventDetails!.copyWith(coverImageUrl: imageUrl),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: OrganizationEventDetailsStatus.error,
          errorCode: e.toString(),
        ),
      );
    }

    emit(state.copyWith(status: OrganizationEventDetailsStatus.idle));
  }
}

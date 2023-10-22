import 'package:event_planr_app/domain/event_manager_repository.dart';
import 'package:event_planr_app/domain/models/event/organization_event_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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

  Future<void> deleteEvent(String eventId) async {
    try {
      await _eventManagerRepository.deleteEvent(eventId);
    } catch (e) {
      emit(
        state.copyWith(
          status: OrganizationEventDetailsStatus.error,
          errorCode: e.toString(),
        ),
      );
    }
  }
}

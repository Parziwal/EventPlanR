import 'package:event_planr_app/domain/event_manager_repository.dart';
import 'package:event_planr_app/domain/models/event/organization_event.dart';
import 'package:event_planr_app/domain/models/event/organization_event_filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'organization_events_state.dart';

part 'organization_events_cubit.freezed.dart';

@injectable
class OrganizationEventsCubit extends Cubit<OrganizationEventsState> {
  OrganizationEventsCubit({
    required EventManagerRepository eventManagerRepository,
  })  : _eventManagerRepository = eventManagerRepository,
        super(
          const OrganizationEventsState(status: OrganizationEventsStatus.idle),
        );

  final EventManagerRepository _eventManagerRepository;

  Future<void> getOrganizationUpcomingEvents(
    int pageNumber,
  ) async {
    try {
      emit(
        state.copyWith(
          events: pageNumber == 1 ? null : state.events,
        ),
      );
      final events =
          await _eventManagerRepository.getOrganizationUpcomingEvents(
        OrganizationEventFilter(
          pageNumber: pageNumber,
          pageSize: 20,
        ),
      );
      emit(
        state.copyWith(
          events: pageNumber == 1
              ? events.items
              : [...?state.events, ...events.items],
          pageNumber: events.hasNextPage ? pageNumber + 1 : null,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: OrganizationEventsStatus.error,
          exception: e,
        ),
      );
    }
    emit(state.copyWith(status: OrganizationEventsStatus.idle));
  }

  Future<void> getOrganizationDraftEvents(
    int pageNumber,
  ) async {
    try {
      emit(
        state.copyWith(
          events: pageNumber == 1 ? null : state.events,
        ),
      );
      final events = await _eventManagerRepository.getOrganizationDraftEvents(
        OrganizationEventFilter(
          pageNumber: pageNumber,
          pageSize: 20,
        ),
      );
      emit(
        state.copyWith(
          events: pageNumber == 1
              ? events.items
              : [...?state.events, ...events.items],
          pageNumber: events.hasNextPage ? pageNumber + 1 : null,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: OrganizationEventsStatus.error,
          exception: e,
        ),
      );
    }
    emit(state.copyWith(status: OrganizationEventsStatus.idle));
  }

  Future<void> getOrganizationPastEvents(
    int pageNumber,
  ) async {
    try {
      emit(
        state.copyWith(
          events: pageNumber == 1 ? null : state.events,
        ),
      );
      final events = await _eventManagerRepository.getOrganizationPastEvents(
        OrganizationEventFilter(
          pageNumber: pageNumber,
          pageSize: 20,
        ),
      );
      emit(
        state.copyWith(
          events: pageNumber == 1
              ? events.items
              : [...?state.events, ...events.items],
          pageNumber: events.hasNextPage ? pageNumber + 1 : null,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: OrganizationEventsStatus.error,
          exception: e,
        ),
      );
    }
    emit(state.copyWith(status: OrganizationEventsStatus.idle));
  }
}

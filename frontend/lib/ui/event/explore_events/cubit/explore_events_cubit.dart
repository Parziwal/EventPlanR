import 'package:event_planr_app/domain/event_general_repository.dart';
import 'package:event_planr_app/domain/map_repository.dart';
import 'package:event_planr_app/domain/models/common/order_direction_enum.dart';
import 'package:event_planr_app/domain/models/event/event.dart';
import 'package:event_planr_app/domain/models/event/event_distance_enum.dart';
import 'package:event_planr_app/domain/models/event/event_filter.dart';
import 'package:event_planr_app/domain/models/event/event_order_by_enum.dart';
import 'package:event_planr_app/domain/models/organization/organization.dart';
import 'package:event_planr_app/domain/models/organization/organization_filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

part 'explore_events_state.dart';

part 'explore_events_cubit.freezed.dart';

@injectable
class ExploreEventsCubit extends Cubit<ExploreEventsState> {
  ExploreEventsCubit({
    required EventGeneralRepository eventGeneralRepository,
    required MapRepository mapRepository,
  })  : _eventGeneralRepository = eventGeneralRepository,
        _mapRepository = mapRepository,
        super(
          ExploreEventsState(
            eventFilter: EventFilter(
              fromDate: DateTime.now().toUtc(),
              orderBy: EventOrderByEnum.fromDate,
              orderDirection: OrderDirectionEnum.ascending,
              distance: EventDistanceEnum.km10,
              pageNumber: 1,
              pageSize: 20,
            ),
            organizationFilter:
                const OrganizationFilter(pageNumber: 1, pageSize: 20),
          ),
        );

  final EventGeneralRepository _eventGeneralRepository;
  final MapRepository _mapRepository;

  Future<void> filterEvents(EventFilter eventFilter) async {
    try {
      if (state.events != null) {
        emit(
          state.copyWith(
            events: eventFilter.pageNumber == 1 ? null : state.events,
            eventFilter: eventFilter,
          ),
        );
      }
      final events =
          await _eventGeneralRepository.getFilteredEvents(eventFilter);
      emit(
        state.copyWith(
          events: eventFilter.pageNumber == 1
              ? events.items
              : [...?state.events, ...events.items],
          eventFilter: eventFilter.copyWith(
            pageNumber: events.hasNextPage ? eventFilter.pageNumber! + 1 : null,
          ),
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          exception: e,
        ),
      );
    }
  }

  Future<void> filterOrganizations(
    OrganizationFilter organizationFilter,
  ) async {
    try {
      emit(
        state.copyWith(
          organizations:
              organizationFilter.pageNumber == 1 ? null : state.organizations,
          organizationFilter: organizationFilter,
        ),
      );
      final organizations =
          await _eventGeneralRepository.getOrganizations(organizationFilter);
      emit(
        state.copyWith(
          organizations: organizationFilter.pageNumber == 1
              ? organizations.items
              : [...?state.organizations, ...organizations.items],
          organizationFilter: organizationFilter.copyWith(
            pageNumber: organizations.hasNextPage
                ? organizationFilter.pageNumber! + 1
                : null,
          ),
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          exception: e,
        ),
      );
    }
  }

  Future<void> setLocationAddress(LatLng location) async {
    try {
      emit(
        state.copyWith(
          events: null,
        ),
      );
      final locationDetails = await _mapRepository.reverseSearch(
        location.latitude,
        location.longitude,
      );
      emit(
        state.copyWith(
          eventFilter: state.eventFilter.copyWith(
            locationName: '${locationDetails.address.country}, '
                '${locationDetails.address.city}, '
                '${locationDetails.address.road}',
            latitude: location.latitude,
            longitude: location.longitude,
            pageNumber: 1,
          ),
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          exception: e,
        ),
      );
    }

    await filterEvents(state.eventFilter);
  }

  void changeView() {
    emit(
      state.copyWith(
        eventView: !state.eventView,
        eventFilter: state.eventFilter.copyWith(searchTerm: null),
        organizationFilter: state.organizationFilter.copyWith(searchTerm: null),
      ),
    );
  }
}

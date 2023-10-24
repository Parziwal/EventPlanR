import 'package:event_planr_app/domain/event_general_repository.dart';
import 'package:event_planr_app/domain/map_repository.dart';
import 'package:event_planr_app/domain/models/common/order_direction_enum.dart';
import 'package:event_planr_app/domain/models/common/paginated_list.dart';
import 'package:event_planr_app/domain/models/event/event.dart';
import 'package:event_planr_app/domain/models/event/event_distance_enum.dart';
import 'package:event_planr_app/domain/models/event/event_filter.dart';
import 'package:event_planr_app/domain/models/event/event_order_by_enum.dart';
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
  })
      : _eventGeneralRepository = eventGeneralRepository,
        _mapRepository = mapRepository,
        super(
        const ExploreEventsState(
          status: ExploreEventsStatus.idle,
          filter: EventFilter(
            orderBy: EventOrderByEnum.fromDate,
            orderDirection: OrderDirectionEnum.descending,
            distance: EventDistanceEnum.km10,
          ),
        ),
      );

  final EventGeneralRepository _eventGeneralRepository;
  final MapRepository _mapRepository;

  Future<void> filterEvents(EventFilter filter) async {
    try {
      emit(state.copyWith(status: ExploreEventsStatus.loading, filter: filter));
      final events = await _eventGeneralRepository.getFilteredEvents(filter);
      emit(
        state.copyWith(
          status: ExploreEventsStatus.idle,
          events: events,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ExploreEventsStatus.error,
          errorCode: e.toString(),
        ),
      );
    }
  }

  Future<void> getLocationAddress(LatLng location) async {
    try {
      emit(state.copyWith(status: ExploreEventsStatus.loading));
      final locationDetails = await _mapRepository.reverseSearch(
        location.latitude,
        location.longitude,
      );
      emit(
        state.copyWith(
          filter: state.filter.copyWith(
            locationName: '${locationDetails.address.country}, '
                '${locationDetails.address.city}, '
                '${locationDetails.address.road}',
            latitude: location.latitude,
            longitude: location.longitude,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ExploreEventsStatus.error,
          errorCode: e.toString(),
        ),
      );
    }
    await filterEvents(state.filter);
  }
}
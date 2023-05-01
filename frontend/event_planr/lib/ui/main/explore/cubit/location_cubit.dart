import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_planr/domain/nominatim/models/place.dart';
import 'package:event_planr/domain/nominatim/models/place_filter.dart';
import 'package:event_planr/domain/nominatim/nominatim_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

part 'location_state.dart';

@injectable
class LocationCubit extends Cubit<LocationState> {
  LocationCubit({required NominatimRepository nominatimRepository})
      : _nominatimRepository = nominatimRepository,
        super(const LocationState());

  final NominatimRepository _nominatimRepository;

  Future<void> getPlaces(String city) async {
    emit(state.copyWith(status: () => LocationStatus.loading));
    final places = await _nominatimRepository.getPlaces(
      PlaceFilter(city: city),
    );
    emit(
      state.copyWith(
        status: () => LocationStatus.success,
        places: () => places,
      ),
    );
  }
}

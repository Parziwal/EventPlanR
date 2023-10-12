import 'package:event_planr_app/domain/map_repository.dart';
import 'package:event_planr_app/domain/models/map/map_address.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

part 'create_event_state.dart';

part 'create_event_cubit.freezed.dart';

@injectable
class CreateEventCubit extends Cubit<CreateEventState> {
  CreateEventCubit({required MapRepository mapRepository})
      : _mapRepository = mapRepository,
        super(const CreateEventState(status: CreateEventStatus.idle));

  final MapRepository _mapRepository;

  Future<void> getLocationAddress(LatLng location) async {
    emit(state.copyWith(status: CreateEventStatus.loading));
    final locationDetails = await _mapRepository.reverseSearch(
      location.latitude,
      location.longitude,
    );
    emit(
      state.copyWith(
        status: CreateEventStatus.addressLoaded,
        address: locationDetails.address,
      ),
    );
  }
}

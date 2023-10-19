import 'package:event_planr_app/domain/models/map/map_address.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_location.freezed.dart';

@freezed
class MapLocation with _$MapLocation {
  const factory MapLocation({
    required int placeId,
    required String latitude,
    required String longitude,
    required String displayName,
    required MapAddress address,
  }) = _MapLocation;
}

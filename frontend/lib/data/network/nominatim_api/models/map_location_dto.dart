import 'package:event_planr_app/data/network/nominatim_api/models/map_address_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_location_dto.freezed.dart';
part 'map_location_dto.g.dart';

@freezed
class MapLocationDto with _$MapLocationDto {
  const factory MapLocationDto({
    @JsonKey(name: 'place_id')
    required int placeId,
    required String lat,
    required String lon,
    @JsonKey(name: 'display_name')
    required String displayName,
    MapAddressDto? address,
  }) = _MapLocationDto;

  factory MapLocationDto.fromJson(Map<String, dynamic> json) =>
      _$MapLocationDtoFromJson(json);
}

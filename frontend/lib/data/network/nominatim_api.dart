import 'package:event_planr_app/data/network/models/nominatim/map_location_dto.dart';

abstract class NominatimApi {
  Future<List<MapLocationDto>> locationSearch({
    String? query,
    int? limit,
    int? addressDetails,
    String? format,
  });

  Future<MapLocationDto> reverseLocationSearch({
    required double latitude,
    required double longitude,
    int? addressDetails,
    String? format,
  });
}

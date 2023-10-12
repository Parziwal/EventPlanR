import 'package:event_planr_app/data/network/nominatim_api.dart';
import 'package:event_planr_app/domain/models/map/map_address.dart';
import 'package:event_planr_app/domain/models/map/map_location.dart';
import 'package:injectable/injectable.dart';

@singleton
class MapRepository {
  MapRepository({required NominatimApi nominatimApi})
      : _nominatimApi = nominatimApi;

  final NominatimApi _nominatimApi;

  Future<List<MapLocation>> searchPlaces(String query, int limit) async {
    final locations =
        await _nominatimApi.locationSearch(query: query, limit: limit);
    return locations
        .map(
          (l) => MapLocation(
            placeId: l.placeId,
            latitude: l.lat,
            longitude: l.lon,
            displayName: l.displayName,
            address: MapAddress(
              city: l.address?.city ??
                  l.address?.town ??
                  l.address?.village ??
                  '',
              country: l.address?.country ?? '',
              houseNumber: l.address?.houseNumber ?? '',
              zipCode: l.address?.postcode ?? '',
              road: l.address?.road ?? '',
            ),
          ),
        )
        .toList();
  }

  Future<MapLocation> reverseSearch(double latitude, double longitude) async {
    final location = await _nominatimApi.reverseLocationSearch(
      latitude: latitude,
      longitude: longitude,
    );

    return MapLocation(
      placeId: location.placeId,
      latitude: location.lat,
      longitude: location.lon,
      displayName: location.displayName,
      address: MapAddress(
        city: location.address?.city ??
            location.address?.town ??
            location.address?.village ??
            '',
        country: location.address?.country ?? '',
        houseNumber: location.address?.houseNumber ?? '',
        zipCode: location.address?.postcode ?? '',
        road: location.address?.road ?? '',
      ),
    );
  }
}

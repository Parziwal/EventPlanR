import 'package:event_planr_app/data/network/nominatim/nominatim_client.dart';
import 'package:event_planr_app/domain/models/map/map_address.dart';
import 'package:event_planr_app/domain/models/map/map_location.dart';
import 'package:injectable/injectable.dart';

@singleton
class MapRepository {
  MapRepository({required NominatimClient nominatimClient})
      : _nominatimClient = nominatimClient;

  final NominatimClient _nominatimClient;

  Future<List<MapLocation>> searchPlaces(String query, int limit) async {
    final locations =
        await _nominatimClient.locationSearch(query: query, limit: limit);
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
    final location = await _nominatimClient.reverseLocationSearch(
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

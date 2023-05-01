import 'package:event_planr/data/network/nominatim_api.dart';
import 'package:event_planr/domain/nominatim/models/place.dart';

import 'package:event_planr/domain/nominatim/models/place_filter.dart';
import 'package:injectable/injectable.dart';

@singleton
class NominatimRepository {
  NominatimRepository(this.nominatimApi);

  final NominatimApi nominatimApi;

  Future<List<Place>> getPlaces(PlaceFilter filter) async {
    final places = await nominatimApi.searchPlaces(
      query: filter.query,
      city: filter.city,
      limit: filter.limit ?? 10,
      format: 'json',
    );
    return places
        .map(
          (p) => Place(
            placeId: p.placeId,
            lat: double.parse(p.lat),
            lon: double.parse(p.lon),
            displayName: p.displayName,
          ),
        )
        .toList();
  }
}

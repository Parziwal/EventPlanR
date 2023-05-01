import 'package:event_planr/data/network/models/place_dto.dart';

// ignore: one_member_abstracts
abstract class NominatimApi {
  Future<List<PlaceDto>> searchPlaces({
    String? query,
    String? city,
    String? format,
    String? language,
    int? limit,
  });
}

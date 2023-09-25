// ignore_for_file: one_member_abstracts

import 'package:event_planr_app/data/network/models/nominatim/searched_location_dto.dart';

abstract class NominatimApi {
  Future<List<SearchedLocationDto>> searchPlaces({
    String? query,
    String? city,
    String? format,
    String? language,
    int? limit,
  });
}

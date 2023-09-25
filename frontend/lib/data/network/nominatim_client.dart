import 'package:dio/dio.dart';
import 'package:event_planr_app/data/network/models/nominatim/searched_location_dto.dart';
import 'package:event_planr_app/data/network/nominatim_api.dart';
import 'package:event_planr_app/env/env.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'nominatim_client.g.dart';

@RestApi(baseUrl: '${Env.nominatimApiUrl}/')
abstract class NominatimClient implements NominatimApi {
  @factoryMethod
  factory NominatimClient(Dio dio, {String baseUrl}) = _NominatimClient;

  @GET('/search')
  @override
  Future<List<SearchedLocationDto>> searchPlaces({
    @Query('q') String? query,
    @Query('city') String? city,
    @Query('format') String? format,
    @Query('accept-language') String? language,
    @Query('limit') int? limit,
  });
}

import 'package:dio/dio.dart';
import 'package:event_planr/data/network/models/place_dto.dart';
import 'package:event_planr/data/network/nominatim_api.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'nominatim_service.g.dart';

@Singleton(as: NominatimApi)
@RestApi(baseUrl: 'https://nominatim.openstreetmap.org')
abstract class NominatimService implements NominatimApi {
  @factoryMethod
  factory NominatimService(Dio dio) = _NominatimService;

  @GET('/search')
  @override
  Future<List<PlaceDto>> searchPlaces({
    @Query('q') String? query,
    @Query('city') String? city,
    @Query('format') String? format,
    @Query('accept-language') String? language,
    @Query('limit') int? limit,
  });
}

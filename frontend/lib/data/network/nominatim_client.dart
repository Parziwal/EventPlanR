import 'package:dio/dio.dart';
import 'package:event_planr_app/data/network/models/nominatim/map_location_dto.dart';
import 'package:event_planr_app/data/network/nominatim_api.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'nominatim_client.g.dart';

@RestApi()
abstract class NominatimClient implements NominatimApi {
  @factoryMethod
  factory NominatimClient(Dio dio, {String baseUrl}) = _NominatimClient;

  @GET('/search')
  @override
  Future<List<MapLocationDto>> locationSearch({
    @Query('q') String? query,
    @Query('limit') int? limit,
    @Query('addressdetails') int? addressDetails = 1,
    @Query('format') String? format = 'jsonv2',
  });

  @GET('/reverse')
  @override
  Future<MapLocationDto> reverseLocationSearch({
    @Query('lat') required double latitude,
    @Query('lon') required double longitude,
    @Query('addressdetails') int? addressDetails = 1,
    @Query('format') String? format = 'jsonv2',
  });
}

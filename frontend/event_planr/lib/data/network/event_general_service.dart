import 'package:dio/dio.dart';
import 'package:event_planr/data/network/event_general_api.dart';
import 'package:event_planr/data/network/models/event_details_dto.dart';
import 'package:event_planr/data/network/models/event_dto.dart';
import 'package:event_planr/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'event_general_service.g.dart';

@Singleton(as: EventGeneralApi)
@RestApi()
abstract class EventGeneralService implements EventGeneralApi {
  @factoryMethod
  factory EventGeneralService(Dio dio) = _EventGeneralService;

  @GET('/event')
  @override
  Future<List<EventDto>> getEventList({
    @Query('SearchTerm') String? searchTerm,
    @Query('Category') int? category,
    @Query('FromDate') DateTime? fromDate,
    @Query('ToDate') DateTime? toDate,
    @Query('Location.longitude') double? longitude,
    @Query('Location.latitude') double? latitude,
    @Query('Location.radius') double? radius,
  });

  @GET('/event/{id}')
  @override
  Future<EventDetailsDto> getEventDetails(@Path('id') String id);
}

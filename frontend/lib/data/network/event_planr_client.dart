import 'package:dio/dio.dart';
import 'package:event_planr_app/data/network/event_planr_api.dart';
import 'package:event_planr_app/data/network/models/event_planr/event/event_details_dto.dart';
import 'package:event_planr_app/data/network/models/event_planr/event/event_dto.dart';
import 'package:event_planr_app/env/env.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'event_planr_client.g.dart';

@RestApi(baseUrl: '${Env.eventPlanrApiUrl}/')
abstract class EventPlanrClient implements EventPlanrApi {
  @factoryMethod
  factory EventPlanrClient(Dio dio, {String baseUrl}) = _EventPlanrClient;

  @GET('/eventgeneral')
  @override
  Future<List<EventDto>> getFilteredEvents({
    @Query('SearchTerm') String? searchTerm,
    @Query('Category') int? category,
    @Query('Language') int? language,
    @Query('Currency') int? currency,
    @Query('FromDate') DateTime? fromDate,
    @Query('ToDate') DateTime? toDate,
    @Query('Location.longitude') double? longitude,
    @Query('Location.latitude') double? latitude,
    @Query('Location.radius') double? radius,
    @Query('PageNumber') int pageNumber,
    @Query('PageSize') int pageSize,
    @Query('OrderBy') String? orderBy,
    @Query('OrderDirection') int? orderDirection,
  });

  @GET('/eventgeneral/{eventId}')
  @override
  Future<EventDetailsDto> getEventDetails(@Path('eventId') String eventId);
}

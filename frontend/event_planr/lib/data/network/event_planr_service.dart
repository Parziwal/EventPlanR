import 'package:dio/dio.dart';
import 'package:event_planr/data/network/event_planr_api.dart';
import 'package:event_planr/data/network/models/buy_ticket_dto.dart';
import 'package:event_planr/data/network/models/event_details_dto.dart';
import 'package:event_planr/data/network/models/event_dto.dart';
import 'package:event_planr/data/network/models/event_ticket_dto.dart';
import 'package:event_planr/data/network/models/user_dto.dart';
import 'package:event_planr/data/network/models/user_ticket_dto.dart';
import 'package:event_planr/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'event_planr_service.g.dart';

@RestApi()
abstract class EventPlanrService implements EventPlanrApi {
  @factoryMethod
  factory EventPlanrService(Dio dio, {String baseUrl}) = _EventPlanrService;

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

  @GET('/event/user/{userId}')
  @override
  Future<List<EventDto>> getUserEvents(
    @Path('userId') String userId,
  );

  @GET('/message/users')
  @override
  Future<List<UserDto>> getUsers();

  @GET('/ticket/event/{eventId}')
  @override
  Future<List<EventTicketDto>> getEventTickets(@Path('eventId') String eventId);

  @GET('/ticket/event/{eventId}/user/{userId}')
  @override
  Future<List<UserTicketDto>> getUserTickets(
    @Path('eventId') String eventId,
    @Path('userId') String userId,
  );

  @POST('/ticket/event/{eventId}/user/{userId}')
  @override
  Future<void> buyTickets(
    @Path('eventId') String eventId,
    @Path('userId') String userId,
    @Body() List<BuyTicketDto> ticket,
  );
}

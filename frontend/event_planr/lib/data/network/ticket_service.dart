import 'package:dio/dio.dart';
import 'package:event_planr/data/network/models/buy_ticket_dto.dart';
import 'package:event_planr/data/network/models/event_ticket_dto.dart';
import 'package:event_planr/data/network/models/user_ticket_dto.dart';
import 'package:event_planr/data/network/ticket_api.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'ticket_service.g.dart';

@RestApi()
abstract class TicketService implements TicketApi {
  @factoryMethod
  factory TicketService(Dio dio, {String baseUrl}) = _TicketService;

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

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/order_dto.dart';
import '../models/order_reserved_tickets_command.dart';
import '../models/reserve_user_tickets_command.dart';

part 'ticket_order_client.g.dart';

@RestApi()
abstract class TicketOrderClient {
  factory TicketOrderClient(Dio dio, {String? baseUrl}) = _TicketOrderClient;

  @GET('/ticketorder/{eventId}')
  Future<List<OrderDto>> getTicketorderEventId({
    @Path('eventId') required String eventId,
  });

  @POST('/ticketorder/reserve')
  Future<void> postTicketorderReserve({
    @Body() required ReserveUserTicketsCommand body,
  });

  @POST('/ticketorder')
  Future<String> postTicketorder({
    @Body() required OrderReservedTicketsCommand body,
  });
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/event_order_dto_paginated_list_dto.dart';
import '../models/order_details_dto.dart';
import '../models/order_reserved_tickets_command.dart';
import '../models/reserve_user_tickets_command.dart';

part 'ticket_order_client.g.dart';

@RestApi()
abstract class TicketOrderClient {
  factory TicketOrderClient(Dio dio, {String? baseUrl}) = _TicketOrderClient;

  @GET('/ticketorder/{eventId}')
  Future<List<OrderDetailsDto>> getTicketorderEventId({
    @Path('eventId') required String eventId,
  });

  @POST('/ticketorder/reserve')
  Future<String> postTicketorderReserve({
    @Body() required ReserveUserTicketsCommand body,
  });

  @POST('/ticketorder')
  Future<String> postTicketorder({
    @Body() required OrderReservedTicketsCommand body,
  });

  @GET('/ticketorder/organization/{eventId}')
  Future<EventOrderDtoPaginatedListDto> getTicketorderOrganizationEventId({
    @Path('eventId') required String eventId,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });

  @GET('/ticketorder/organization/order/{orderId}')
  Future<OrderDetailsDto> getTicketorderOrganizationOrderOrderId({
    @Path('orderId') required String orderId,
  });

  @POST('/ticketorder/organization/order/refund/{orderId}')
  Future<void> postTicketorderOrganizationOrderRefundOrderId({
    @Path('orderId') required String orderId,
  });
}

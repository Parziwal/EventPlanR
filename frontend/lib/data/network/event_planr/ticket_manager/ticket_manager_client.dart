// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/add_ticket_to_event_command.dart';
import '../models/update_ticket_command.dart';

part 'ticket_manager_client.g.dart';

@RestApi()
abstract class TicketManagerClient {
  factory TicketManagerClient(Dio dio, {String? baseUrl}) = _TicketManagerClient;

  @POST('/ticketmanager/event/{eventId}')
  Future<String> postTicketmanagerEventEventId({
    @Path('eventId') required String eventId,
    @Body() required AddTicketToEventCommand body,
  });

  @PUT('/ticketmanager/{ticketId}')
  Future<void> putTicketmanagerTicketId({
    @Path('ticketId') required String ticketId,
    @Body() required UpdateTicketCommand body,
  });

  @DELETE('/ticketmanager/{ticketId}')
  Future<void> deleteTicketmanagerTicketId({
    @Path('ticketId') required String ticketId,
  });
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/create_event_command.dart';
import '../models/edit_event_command.dart';

part 'event_manager_client.g.dart';

@RestApi()
abstract class EventManagerClient {
  factory EventManagerClient(Dio dio, {String? baseUrl}) = _EventManagerClient;

  @GET('/eventmanager/draft')
  Future<void> getEventmanagerDraft({
    @Query('SearchTerm') String? searchTerm,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });

  @GET('/eventmanager/past')
  Future<void> getEventmanagerPast({
    @Query('SearchTerm') String? searchTerm,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });

  @GET('/eventmanager/upcoming')
  Future<void> getEventmanagerUpcoming({
    @Query('SearchTerm') String? searchTerm,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });

  @GET('/eventmanager/{eventId}')
  Future<void> getEventmanagerEventId({
    @Path('eventId') required String eventId,
  });

  @PUT('/eventmanager/{eventId}')
  Future<void> putEventmanagerEventId({
    @Path('eventId') required String eventId,
    @Body() required EditEventCommand body,
  });

  @DELETE('/eventmanager/{eventId}')
  Future<void> deleteEventmanagerEventId({
    @Path('eventId') required String eventId,
  });

  @POST('/eventmanager')
  Future<String> postEventmanager({
    @Body() required CreateEventCommand body,
  });
}

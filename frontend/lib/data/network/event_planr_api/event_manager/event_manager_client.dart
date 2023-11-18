// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/create_event_command.dart';
import '../models/edit_event_command.dart';
import '../models/event_statistics_dto.dart';
import '../models/organization_event_details_dto.dart';
import '../models/organization_event_dto_paginated_list_dto.dart';

part 'event_manager_client.g.dart';

@RestApi()
abstract class EventManagerClient {
  factory EventManagerClient(Dio dio, {String? baseUrl}) = _EventManagerClient;

  @GET('/eventmanager/draft')
  Future<OrganizationEventDtoPaginatedListDto> getEventmanagerDraft({
    @Query('SearchTerm') String? searchTerm,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });

  @GET('/eventmanager/past')
  Future<OrganizationEventDtoPaginatedListDto> getEventmanagerPast({
    @Query('SearchTerm') String? searchTerm,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });

  @GET('/eventmanager/upcoming')
  Future<OrganizationEventDtoPaginatedListDto> getEventmanagerUpcoming({
    @Query('SearchTerm') String? searchTerm,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });

  @GET('/eventmanager/{eventId}')
  Future<OrganizationEventDetailsDto> getEventmanagerEventId({
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

  @POST('/eventmanager/publish/{eventId}')
  Future<void> postEventmanagerPublishEventId({
    @Path('eventId') required String eventId,
  });

  @PUT('/eventmanager/unpublish/{eventId}')
  Future<void> putEventmanagerUnpublishEventId({
    @Path('eventId') required String eventId,
  });

  @MultiPart()
  @POST('/eventmanager/coverimage/{eventId}')
  Future<String> postEventmanagerCoverimageEventId({
    @Path('eventId') required String eventId,
    @Part(name: 'ImageFile') File? imageFile,
  });

  @GET('/eventmanager/statistics/{eventId}')
  Future<EventStatisticsDto> getEventmanagerStatisticsEventId({
    @Path('eventId') required String eventId,
  });
}

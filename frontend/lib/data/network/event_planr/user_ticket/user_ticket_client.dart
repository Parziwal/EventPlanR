// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/event_dto_paginated_list_dto.dart';
import '../models/sold_ticket_dto.dart';

part 'user_ticket_client.g.dart';

@RestApi()
abstract class UserTicketClient {
  factory UserTicketClient(Dio dio, {String? baseUrl}) = _UserTicketClient;

  @GET('/userticket/upcoming')
  Future<EventDtoPaginatedListDto> getUserticketUpcoming({
    @Query('SearchTerm') String? searchTerm,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });

  @GET('/userticket/invitation')
  Future<EventDtoPaginatedListDto> getUserticketInvitation({
    @Query('SearchTerm') String? searchTerm,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });

  @GET('/userticket/past')
  Future<EventDtoPaginatedListDto> getUserticketPast({
    @Query('SearchTerm') String? searchTerm,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });

  @GET('/userticket/{eventId}')
  Future<List<SoldTicketDto>> getUserticketEventId({
    @Path('eventId') required String eventId,
  });
}

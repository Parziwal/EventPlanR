// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/currency.dart';
import '../models/event_category.dart';
import '../models/event_details_dto.dart';
import '../models/event_dto_paginated_list_dto.dart';
import '../models/news_post_dto_paginated_list_dto.dart';
import '../models/order_direction.dart';
import '../models/organization_details_dto.dart';
import '../models/organization_dto_paginated_list_dto.dart';
import '../models/ticket_dto.dart';

part 'event_general_client.g.dart';

@RestApi()
abstract class EventGeneralClient {
  factory EventGeneralClient(Dio dio, {String? baseUrl}) = _EventGeneralClient;

  @GET('/eventgeneral')
  Future<EventDtoPaginatedListDto> getEventgeneral({
    @Query('SearchTerm') String? searchTerm,
    @Query('Category') EventCategory? category,
    @Query('Currency') Currency? currency,
    @Query('FromDate') DateTime? fromDate,
    @Query('ToDate') DateTime? toDate,
    @Query('Location.Latitude') double? object0,
    @Query('Location.Longitude') double? object1,
    @Query('Location.Radius') double? object2,
    @Query('OrderBy') String? orderBy,
    @Query('OrderDirection') OrderDirection? orderDirection,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });

  @GET('/eventgeneral/{eventId}')
  Future<EventDetailsDto> getEventgeneralEventId({
    @Path('eventId') required String eventId,
  });

  @GET('/eventgeneral/ticket/{eventId}')
  Future<List<TicketDto>> getEventgeneralTicketEventId({
    @Path('eventId') required String eventId,
  });

  @GET('/eventgeneral/newspost/{eventId}')
  Future<NewsPostDtoPaginatedListDto> getEventgeneralNewspostEventId({
    @Path('eventId') required String eventId,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });

  @GET('/eventgeneral/organization')
  Future<OrganizationDtoPaginatedListDto> getEventgeneralOrganization({
    @Query('SearchTerm') String? searchTerm,
    @Query('OrderBy') String? orderBy,
    @Query('OrderDirection') OrderDirection? orderDirection,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });

  @GET('/eventgeneral/organization/{organizationId}')
  Future<OrganizationDetailsDto> getEventgeneralOrganizationOrganizationId({
    @Path('organizationId') required String organizationId,
  });

  @GET('/eventgeneral/organization/events')
  Future<EventDtoPaginatedListDto> getEventgeneralOrganizationEvents({
    @Query('OrganizationId') String? organizationId,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });
}

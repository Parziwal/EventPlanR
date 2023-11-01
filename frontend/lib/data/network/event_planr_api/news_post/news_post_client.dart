// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/create_news_post_command.dart';
import '../models/organization_news_post_dto_paginated_list_dto.dart';

part 'news_post_client.g.dart';

@RestApi()
abstract class NewsPostClient {
  factory NewsPostClient(Dio dio, {String? baseUrl}) = _NewsPostClient;

  @GET('/newspost/{eventId}')
  Future<OrganizationNewsPostDtoPaginatedListDto> getNewspostEventId({
    @Path('eventId') required String eventId,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });

  @POST('/newspost/{eventId}')
  Future<String> postNewspostEventId({
    @Path('eventId') required String eventId,
    @Body() required CreateNewsPostCommand body,
  });

  @DELETE('/newspost/{newsPostId}')
  Future<void> deleteNewspostNewsPostId({
    @Path('newsPostId') required String newsPostId,
  });
}

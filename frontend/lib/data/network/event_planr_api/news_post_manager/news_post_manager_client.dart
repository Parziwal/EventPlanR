// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/create_news_post_command.dart';
import '../models/organization_news_post_dto_paginated_list_dto.dart';

part 'news_post_manager_client.g.dart';

@RestApi()
abstract class NewsPostManagerClient {
  factory NewsPostManagerClient(Dio dio, {String? baseUrl}) = _NewsPostManagerClient;

  @GET('/newspostmanager/{eventId}')
  Future<OrganizationNewsPostDtoPaginatedListDto> getNewspostmanagerEventId({
    @Path('eventId') required String eventId,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });

  @POST('/newspostmanager/{eventId}')
  Future<String> postNewspostmanagerEventId({
    @Path('eventId') required String eventId,
    @Body() required CreateNewsPostCommand body,
  });

  @DELETE('/newspostmanager/{newsPostId}')
  Future<void> deleteNewspostmanagerNewsPostId({
    @Path('newsPostId') required String newsPostId,
  });
}

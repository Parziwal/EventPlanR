// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/create_direct_chat_command.dart';
import '../models/direct_chat_dto_paginated_list_dto.dart';

part 'chat_manager_client.g.dart';

@RestApi()
abstract class ChatManagerClient {
  factory ChatManagerClient(Dio dio, {String? baseUrl}) = _ChatManagerClient;

  @GET('/chatmanager/direct')
  Future<DirectChatDtoPaginatedListDto> getChatmanagerDirect({
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });

  @POST('/chatmanager/direct')
  Future<String> postChatmanagerDirect({
    @Body() required CreateDirectChatCommand body,
  });

  @POST('/chatmanager/setread/{chatId}')
  Future<void> postChatmanagerSetreadChatId({
    @Path('chatId') required String chatId,
  });
}

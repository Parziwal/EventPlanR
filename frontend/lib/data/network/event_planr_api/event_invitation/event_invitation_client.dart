// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/accept_or_deny_invitation_command.dart';
import '../models/delete_invitation_command.dart';
import '../models/event_invitation_dto_paginated_list_dto.dart';
import '../models/invite_user_to_event_command.dart';
import '../models/user_invitation_dto.dart';

part 'event_invitation_client.g.dart';

@RestApi()
abstract class EventInvitationClient {
  factory EventInvitationClient(Dio dio, {String? baseUrl}) = _EventInvitationClient;

  @GET('/eventinvitation/organizationevent')
  Future<EventInvitationDtoPaginatedListDto> getEventinvitationOrganizationevent({
    @Query('EventId') String? eventId,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  });

  @POST('/eventinvitation/organizationevent')
  Future<void> postEventinvitationOrganizationevent({
    @Body() required InviteUserToEventCommand body,
  });

  @DELETE('/eventinvitation/organizationevent')
  Future<void> deleteEventinvitationOrganizationevent({
    @Body() required DeleteInvitationCommand body,
  });

  @GET('/eventinvitation/userevent/{eventId}')
  Future<UserInvitationDto> getEventinvitationUsereventEventId({
    @Path('eventId') required String eventId,
  });

  @POST('/eventinvitation/userevent/status')
  Future<void> postEventinvitationUsereventStatus({
    @Body() required AcceptOrDenyInvitationCommand body,
  });
}

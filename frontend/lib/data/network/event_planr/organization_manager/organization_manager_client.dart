// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/add_member_to_user_organization_command.dart';
import '../models/create_organization_command.dart';
import '../models/edit_organization_member_command.dart';
import '../models/edit_user_organization_command.dart';
import '../models/organization_dto.dart';
import '../models/remove_member_from_user_organization_command.dart';
import '../models/user_organization_details_dto.dart';

part 'organization_manager_client.g.dart';

@RestApi()
abstract class OrganizationManagerClient {
  factory OrganizationManagerClient(Dio dio, {String? baseUrl}) = _OrganizationManagerClient;

  @GET('/organizationmanager')
  Future<OrganizationDto> getOrganizationmanager();

  @POST('/organizationmanager')
  Future<String> postOrganizationmanager({
    @Body() required CreateOrganizationCommand body,
  });

  @PUT('/organizationmanager')
  Future<void> putOrganizationmanager({
    @Body() required EditUserOrganizationCommand body,
  });

  @DELETE('/organizationmanager')
  Future<void> deleteOrganizationmanager();

  @GET('/organizationmanager/organizations')
  Future<List<OrganizationDto>> getOrganizationmanagerOrganizations();

  @GET('/organizationmanager/details')
  Future<UserOrganizationDetailsDto> getOrganizationmanagerDetails();

  @POST('/organizationmanager/set/{organizationId}')
  Future<void> postOrganizationmanagerSetOrganizationId({
    @Path('organizationId') required String organizationId,
  });

  @POST('/organizationmanager/member')
  Future<void> postOrganizationmanagerMember({
    @Body() required AddMemberToUserOrganizationCommand body,
  });

  @PUT('/organizationmanager/member')
  Future<void> putOrganizationmanagerMember({
    @Body() required EditOrganizationMemberCommand body,
  });

  @DELETE('/organizationmanager/member')
  Future<void> deleteOrganizationmanagerMember({
    @Body() required RemoveMemberFromUserOrganizationCommand body,
  });
}

import 'package:dio/dio.dart';
import 'package:event_planr_app/data/network/event_planr_api.dart';
import 'package:event_planr_app/data/network/models/event_planr/common/paginated_list_dto.dart';
import 'package:event_planr_app/data/network/models/event_planr/event/event_details_dto.dart';
import 'package:event_planr_app/data/network/models/event_planr/organization/add_member_to_organization_dto.dart';
import 'package:event_planr_app/data/network/models/event_planr/organization/create_organization_dto.dart';
import 'package:event_planr_app/data/network/models/event_planr/organization/edit_organization_dto.dart';
import 'package:event_planr_app/data/network/models/event_planr/organization/edit_organization_member_dto.dart';
import 'package:event_planr_app/data/network/models/event_planr/organization/organization_details_dto.dart';
import 'package:event_planr_app/data/network/models/event_planr/organization/organization_dto.dart';
import 'package:event_planr_app/data/network/models/event_planr/organization/remove_member_from_organization_dto.dart';
import 'package:event_planr_app/data/network/models/event_planr/organization/user_organization_details_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'event_planr_client.g.dart';

@RestApi()
abstract class EventPlanrClient implements EventPlanrApi {
  @factoryMethod
  factory EventPlanrClient(Dio dio, {String baseUrl}) = _EventPlanrClient;

  // General Event

  @GET('/eventgeneral')
  @override
  Future<PaginatedListDto> getFilteredEvents({
    @Query('SearchTerm') String? searchTerm,
    @Query('Category') int? category,
    @Query('Language') int? language,
    @Query('Currency') int? currency,
    @Query('FromDate') DateTime? fromDate,
    @Query('ToDate') DateTime? toDate,
    @Query('Location.longitude') double? longitude,
    @Query('Location.latitude') double? latitude,
    @Query('Location.radius') double? radius,
    @Query('PageNumber') int pageNumber = 1,
    @Query('PageSize') int pageSize = 10,
    @Query('OrderBy') String? orderBy,
    @Query('OrderDirection') int? orderDirection,
  });

  @GET('/eventgeneral/{eventId}')
  @override
  Future<EventDetailsDto> getEventDetails(@Path('eventId') String eventId);

  @GET('/eventgeneral/organization')
  @override
  Future<PaginatedListDto> getOrganizations({
    @Query('SearchTerm') String? searchTerm,
  });

  @GET('/eventgeneral/organization/{organizationId}')
  @override
  Future<OrganizationDetailsDto> getOrganizationDetails(
    @Path('organizationId') String organizationId,
  );

  // Organization Manager

  @GET('/organizationmanager')
  @override
  Future<OrganizationDto> getUserCurrentOrganization();

  @GET('/organizationmanager/organizations')
  @override
  Future<List<OrganizationDto>> getUserOrganizations();

  @GET('/organizationmanager/details')
  @override
  Future<UserOrganizationDetailsDto> getUserCurrentOrganizationDetails();

  @POST('/organizationmanager/set/{organizationId}')
  @override
  Future<void> setUserOrganization(
    @Path('organizationId') String organizationId,
  );

  @POST('/organizationmanager')
  @override
  Future<String> createOrganization(@Body() CreateOrganizationDto organization);

  @PUT('/organizationmanager')
  @override
  Future<void> editCurrentOrganization(
    @Body() EditOrganizationDto organization,
  );

  @DELETE('/organizationmanager')
  @override
  Future<void> deleteCurrentOrganization();

  @POST('/organizationmanager/member')
  @override
  Future<void> addMemberToCurrentOrganization(
    @Body() AddMemberToOrganizationDto member,
  );

  @PUT('/organizationmanager/member')
  @override
  Future<void> editCurrentOrganizationMember(
    @Body() EditOrganizationMemberDto member,
  );

  @DELETE('/organizationmanager/member/{organizationId}')
  @override
  Future<void> removeMemberFromCurrentOrganization(
    @Body() RemoveMemberFromOrganizationDto member,
  );
}

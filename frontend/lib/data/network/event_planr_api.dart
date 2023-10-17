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

abstract class EventPlanrApi {
  // General Event

  Future<PaginatedListDto> getFilteredEvents({
    String? searchTerm,
    int? category,
    int? currency,
    DateTime? fromDate,
    DateTime? toDate,
    double? longitude,
    double? latitude,
    double? radius,
    int pageNumber,
    int pageSize,
    String? orderBy,
    int? orderDirection,
  });

  Future<EventDetailsDto> getEventDetails(String eventId);

  Future<PaginatedListDto> getOrganizations({String? searchTerm});

  Future<OrganizationDetailsDto> getOrganizationDetails(String organizationId);

  // Organization Manager

  Future<List<OrganizationDto>> getUserOrganizations();

  Future<OrganizationDto> getUserCurrentOrganization();

  Future<UserOrganizationDetailsDto> getUserCurrentOrganizationDetails();

  Future<void> setUserOrganization(String organizationId);

  Future<String> createOrganization(CreateOrganizationDto organization);

  Future<void> editCurrentOrganization(
    EditOrganizationDto organization,
  );

  Future<void> deleteCurrentOrganization();

  Future<void> addMemberToCurrentOrganization(
    AddMemberToOrganizationDto member,
  );

  Future<void> editCurrentOrganizationMember(
    EditOrganizationMemberDto member,
  );

  Future<void> removeMemberFromCurrentOrganization(
    RemoveMemberFromOrganizationDto member,
  );
}

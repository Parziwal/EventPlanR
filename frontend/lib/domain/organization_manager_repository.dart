import 'package:event_planr_app/data/network/event_planr_api.dart';
import 'package:event_planr_app/data/network/models/event_planr/organization/add_member_to_organization_dto.dart';
import 'package:event_planr_app/data/network/models/event_planr/organization/create_organization_dto.dart';
import 'package:event_planr_app/data/network/models/event_planr/organization/edit_organization_dto.dart';
import 'package:event_planr_app/data/network/models/event_planr/organization/edit_organization_member_dto.dart';
import 'package:event_planr_app/data/network/models/event_planr/organization/remove_member_from_organization_dto.dart';
import 'package:event_planr_app/domain/models/organization/add_or_edit_organization_member.dart';
import 'package:event_planr_app/domain/models/organization/create_organization.dart';
import 'package:event_planr_app/domain/models/organization/edit_organization.dart';
import 'package:event_planr_app/domain/models/organization/organization.dart';
import 'package:event_planr_app/domain/models/organization/user_organization_details.dart';
import 'package:event_planr_app/domain/models/user/organization_member.dart';
import 'package:injectable/injectable.dart';

@singleton
class OrganizationManagerRepository {
  const OrganizationManagerRepository({required EventPlanrApi eventPlanrApi})
      : _eventPlanrApi = eventPlanrApi;

  final EventPlanrApi _eventPlanrApi;

  Future<List<Organization>> getUserOrganizations() async {
    final organizations = await _eventPlanrApi.getUserOrganizations();

    return organizations
        .map(
          (dto) => Organization(
            id: dto.id,
            name: dto.name,
            profileImageUrl: dto.profileImageUrl,
          ),
        )
        .toList();
  }

  Future<Organization> getUserCurrentOrganization() async {
    final currentOrganization =
        await _eventPlanrApi.getUserCurrentOrganization();
    return Organization(
      id: currentOrganization.id,
      name: currentOrganization.name,
      profileImageUrl: currentOrganization.profileImageUrl,
    );
  }

  Future<UserOrganizationDetails> getUserCurrentOrganizationDetails() async {
    final currentOrganizationDetails =
        await _eventPlanrApi.getUserCurrentOrganizationDetails();

    return UserOrganizationDetails(
      id: currentOrganizationDetails.id,
      name: currentOrganizationDetails.name,
      description: currentOrganizationDetails.description ?? '-',
      profileImageUrl: currentOrganizationDetails.profileImageUrl,
      members: currentOrganizationDetails.members
          .map(
            (m) => OrganizationMember(
              id: m.id,
              firstName: m.firstName,
              lastName: m.lastName,
              email: m.email,
              organizationPolicies: m.organizationPolicies,
            ),
          )
          .toList(),
      created: currentOrganizationDetails.created,
      createdBy: currentOrganizationDetails.createdBy,
      lastModified: currentOrganizationDetails.lastModified,
      lastModifiedBy: currentOrganizationDetails.lastModifiedBy,
    );
  }

  Future<void> setUserOrganization(String organizationId) async {
    await _eventPlanrApi.setUserOrganization(organizationId);
  }

  Future<String> createOrganization(CreateOrganization organization) async {
    return _eventPlanrApi.createOrganization(
      CreateOrganizationDto(
        name: organization.name,
        description: organization.description,
      ),
    );
  }

  Future<void> editCurrentOrganization(EditOrganization organization) async {
    await _eventPlanrApi.editCurrentOrganization(
      EditOrganizationDto(
        description: organization.description,
      ),
    );
  }

  Future<void> deleteCurrentOrganization() async {
    await _eventPlanrApi.deleteCurrentOrganization();
  }

  Future<void> addOrEditMemberToOrganization(
    AddOrEditOrganizationMember member,
  ) async {
    if (member.memberUserEmail != null) {
      await _eventPlanrApi.addMemberToCurrentOrganization(
        AddMemberToOrganizationDto(
          memberUserEmail: member.memberUserEmail!,
          policies: member.policies,
        ),
      );
    } else if (member.memberUserId != null) {
      await _eventPlanrApi.editCurrentOrganizationMember(
        EditOrganizationMemberDto(
          memberUserId: member.memberUserId!,
          policies: member.policies,
        ),
      );
    }
  }

  Future<void> removeMemberFromCurrentOrganization(
    String memberUserId,
  ) async {
    await _eventPlanrApi.removeMemberFromCurrentOrganization(
      RemoveMemberFromOrganizationDto(
        memberUserId: memberUserId,
      ),
    );
  }
}

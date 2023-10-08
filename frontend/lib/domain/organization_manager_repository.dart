import 'package:event_planr_app/data/network/event_planr_api.dart';
import 'package:event_planr_app/data/network/models/event_planr/organization/add_member_to_organization_dto.dart';
import 'package:event_planr_app/data/network/models/event_planr/organization/create_organization_dto.dart';
import 'package:event_planr_app/data/network/models/event_planr/organization/edit_organization_dto.dart';
import 'package:event_planr_app/data/network/models/event_planr/organization/remove_member_from_organization_dto.dart';
import 'package:event_planr_app/domain/models/organization/add_member_to_organization.dart';
import 'package:event_planr_app/domain/models/organization/create_organization.dart';
import 'package:event_planr_app/domain/models/organization/edit_organization.dart';
import 'package:event_planr_app/domain/models/organization/organization.dart';
import 'package:event_planr_app/domain/models/organization/remove_member_from_organization.dart';
import 'package:event_planr_app/domain/models/organization/user_organization_details.dart';
import 'package:event_planr_app/domain/models/user/user_data.dart';
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
      profileImageUrl: currentOrganizationDetails.profileImageUrl,
      members: currentOrganizationDetails.members
          .map(
            (m) => UserData(
              id: m.id,
              firstName: m.firstName,
              lastName: m.lastName,
              email: m.email,
            ),
          )
          .toList(),
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

  Future<void> editOrganization(EditOrganization organization) async {
    await _eventPlanrApi.editOrganization(
      organization.id,
      EditOrganizationDto(
        description: organization.description,
      ),
    );
  }

  Future<void> deleteOrganization(String organizationId) async {
    await _eventPlanrApi.deleteOrganization(organizationId);
  }

  Future<void> addMemberToOrganization(
    AddMemberToOrganization organization,
  ) async {
    await _eventPlanrApi.addMemberToOrganization(
      organization.organizationId,
      AddMemberToOrganizationDto(
        memberUserEmail: organization.memberUserEmail,
        policies: organization.policies,
      ),
    );
  }

  Future<void> removeMemberToOrganization(
    RemoveMemberFromOrganization organization,
  ) async {
    await _eventPlanrApi.removeMemberToOrganization(
      organization.organizationId,
      RemoveMemberFromOrganizationDto(
        memberUserId: organization.memberUserId,
      ),
    );
  }
}

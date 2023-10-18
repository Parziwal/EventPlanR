import 'package:event_planr_app/data/network/event_planr/models/add_member_to_user_organization_command.dart';
import 'package:event_planr_app/data/network/event_planr/models/create_organization_command.dart';
import 'package:event_planr_app/data/network/event_planr/models/edit_organization_member_command.dart';
import 'package:event_planr_app/data/network/event_planr/models/edit_user_organization_command.dart';
import 'package:event_planr_app/data/network/event_planr/models/remove_member_from_user_organization_command.dart';
import 'package:event_planr_app/data/network/event_planr/organization_manager/organization_manager_client.dart';
import 'package:event_planr_app/domain/models/organization/add_or_edit_organization_member.dart';
import 'package:event_planr_app/domain/models/organization/create_organization.dart';
import 'package:event_planr_app/domain/models/organization/edit_organization.dart';
import 'package:event_planr_app/domain/models/organization/organization.dart';
import 'package:event_planr_app/domain/models/organization/user_organization_details.dart';
import 'package:event_planr_app/domain/models/user/organization_member.dart';
import 'package:injectable/injectable.dart';

@singleton
class OrganizationManagerRepository {
  const OrganizationManagerRepository({
    required OrganizationManagerClient organizationManagerClient,
  }) : _organizationManagerClient = organizationManagerClient;

  final OrganizationManagerClient _organizationManagerClient;

  Future<List<Organization>> getUserOrganizations() async {
    final organizations =
        await _organizationManagerClient.getOrganizationmanagerOrganizations();

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
        await _organizationManagerClient.getOrganizationmanager();
    return Organization(
      id: currentOrganization.id,
      name: currentOrganization.name,
      profileImageUrl: currentOrganization.profileImageUrl,
    );
  }

  Future<UserOrganizationDetails> getUserCurrentOrganizationDetails() async {
    final currentOrganizationDetails =
        await _organizationManagerClient.getOrganizationmanagerDetails();

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
    await _organizationManagerClient.postOrganizationmanagerSetOrganizationId(
      organizationId: organizationId,
    );
  }

  Future<String> createOrganization(CreateOrganization organization) async {
    return _organizationManagerClient.postOrganizationmanager(
      body: CreateOrganizationCommand(
        name: organization.name,
        description: organization.description,
      ),
    );
  }

  Future<void> editCurrentOrganization(EditOrganization organization) async {
    await _organizationManagerClient.putOrganizationmanager(
      body: EditUserOrganizationCommand(
        description: organization.description,
      ),
    );
  }

  Future<void> deleteCurrentOrganization() async {
    await _organizationManagerClient.deleteOrganizationmanager();
  }

  Future<void> addOrEditMemberToOrganization(
    AddOrEditOrganizationMember member,
  ) async {
    if (member.memberUserEmail != null) {
      await _organizationManagerClient.postOrganizationmanagerMember(
        body: AddMemberToUserOrganizationCommand(
          memberUserEmail: member.memberUserEmail!,
          policies: member.policies,
        ),
      );
    } else if (member.memberUserId != null) {
      await _organizationManagerClient.putOrganizationmanagerMember(
        body: EditOrganizationMemberCommand(
          memberUserId: member.memberUserId!,
          policies: member.policies,
        ),
      );
    }
  }

  Future<void> removeMemberFromCurrentOrganization(
    String memberUserId,
  ) async {
    await _organizationManagerClient.deleteOrganizationmanagerMember(
      body: RemoveMemberFromUserOrganizationCommand(
        memberUserId: memberUserId,
      ),
    );
  }
}

import 'package:event_planr_app/data/disk/persistent_store.dart';
import 'package:event_planr_app/data/network/event_planr_api/models/add_member_to_user_organization_command.dart';
import 'package:event_planr_app/data/network/event_planr_api/models/create_organization_command.dart';
import 'package:event_planr_app/data/network/event_planr_api/models/edit_organization_member_command.dart';
import 'package:event_planr_app/data/network/event_planr_api/models/edit_user_organization_command.dart';
import 'package:event_planr_app/data/network/event_planr_api/models/remove_member_from_user_organization_command.dart';
import 'package:event_planr_app/data/network/event_planr_api/organization_manager/organization_manager_client.dart';
import 'package:event_planr_app/data/network/image_upload/image_upload_client.dart';
import 'package:event_planr_app/domain/models/organization/add_or_edit_organization_member.dart';
import 'package:event_planr_app/domain/models/organization/create_or_edit_organization.dart';
import 'package:event_planr_app/domain/models/organization/organization.dart';
import 'package:event_planr_app/domain/models/organization/user_organization_details.dart';
import 'package:event_planr_app/domain/models/user/organization_member.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@singleton
class OrganizationManagerRepository {
  const OrganizationManagerRepository({
    required OrganizationManagerClient organizationManagerClient,
    required ImageUploadClient imageUploadClient,
    required PersistentStore persistentStore,
  })  : _organizationManagerClient = organizationManagerClient,
        _imageUploadClient = imageUploadClient,
        _persistentStore = persistentStore;

  final OrganizationManagerClient _organizationManagerClient;
  final ImageUploadClient _imageUploadClient;
  final PersistentStore _persistentStore;

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
      created: currentOrganizationDetails.created.toLocal(),
      createdBy: currentOrganizationDetails.createdBy,
      lastModified: currentOrganizationDetails.lastModified.toLocal(),
      lastModifiedBy: currentOrganizationDetails.lastModifiedBy,
    );
  }

  Future<void> setUserOrganization(String organizationId) async {
    await _organizationManagerClient.postOrganizationmanagerSetOrganizationId(
      organizationId: organizationId,
    );
    await _persistentStore.remove('selectedEvent');
  }

  Future<void> createOrEditOrganization(
    CreateOrEditOrganization organization,
  ) async {
    if (organization.name != null) {
      await _organizationManagerClient.postOrganizationmanager(
        body: CreateOrganizationCommand(
          name: organization.name!,
          description: organization.description,
        ),
      );
    } else {
      await _organizationManagerClient.putOrganizationmanager(
        body: EditUserOrganizationCommand(
          description: organization.description,
        ),
      );
    }
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

  Future<String> uploadOrganizationProfileImage(XFile image) async {
    return _imageUploadClient.uploadOrganizationProfileImage(image);
  }
}

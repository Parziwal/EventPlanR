import 'package:event_planr_app/domain/models/user/organization_member.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_organization_details.freezed.dart';
part 'user_organization_details.g.dart';

@freezed
class UserOrganizationDetails with _$UserOrganizationDetails {
  const factory UserOrganizationDetails({
    required String id,
    required String name,
    required String description,
    required List<OrganizationMember> members,
    String? profileImageUrl,
    DateTime? created,
    String? createdBy,
    DateTime? lastModified,
    String? lastModifiedBy,
  }) = _UserOrganizationDetails;

  factory UserOrganizationDetails.fromJson(Map<String, Object?> json) =>
      _$UserOrganizationDetailsFromJson(json);
}

import 'package:event_planr_app/data/network/models/event_planr/user/organization_member_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_organization_details_dto.freezed.dart';

part 'user_organization_details_dto.g.dart';

@freezed
class UserOrganizationDetailsDto with _$UserOrganizationDetailsDto {
  const factory UserOrganizationDetailsDto({
    required String id,
    required String name,
    required List<OrganizationMemberDto> members,
    String? description,
    String? profileImageUrl,
    DateTime? created,
    String? createdBy,
    DateTime? lastModified,
    String? lastModifiedBy,
  }) = _UserOrganizationDetailsDto;

  factory UserOrganizationDetailsDto.fromJson(Map<String, Object?> json) =>
      _$UserOrganizationDetailsDtoFromJson(json);
}

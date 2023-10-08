import 'package:freezed_annotation/freezed_annotation.dart';

part 'remove_member_from_organization.freezed.dart';
part 'remove_member_from_organization.g.dart';

@freezed
class RemoveMemberFromOrganization with _$RemoveMemberFromOrganization {
  const factory RemoveMemberFromOrganization({
    required String organizationId,
    required String memberUserId,
  }) = _RemoveMemberFromOrganization;

  factory RemoveMemberFromOrganization.fromJson(Map<String, Object?> json) =>
      _$RemoveMemberFromOrganizationFromJson(json);
}

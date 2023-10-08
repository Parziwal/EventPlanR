import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_member_to_organization.freezed.dart';
part 'add_member_to_organization.g.dart';

@freezed
class AddMemberToOrganization with _$AddMemberToOrganization {
  const factory AddMemberToOrganization({
    required String organizationId,
    required String memberUserEmail,
    required List<String> policies,
  }) = _AddMemberToOrganization;

  factory AddMemberToOrganization.fromJson(Map<String, Object?> json) =>
      _$AddMemberToOrganizationFromJson(json);
}

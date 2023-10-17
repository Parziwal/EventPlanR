import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_or_edit_organization_member.freezed.dart';
part 'add_or_edit_organization_member.g.dart';

@freezed
class AddOrEditOrganizationMember with _$AddOrEditOrganizationMember {
  const factory AddOrEditOrganizationMember({
    required List<String> policies,
    String? memberUserId,
    String? memberUserEmail,
  }) = _AddOrEditOrganizationMember;

  factory AddOrEditOrganizationMember.fromJson(Map<String, Object?> json) =>
      _$AddOrEditOrganizationMemberFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_member_dto.freezed.dart';
part 'organization_member_dto.g.dart';

@freezed
class OrganizationMemberDto with _$OrganizationMemberDto {
  const factory OrganizationMemberDto({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required List<String> organizationPolicies,
  }) = _OrganizationMemberDto;

  factory OrganizationMemberDto.fromJson(Map<String, Object?> json) =>
      _$OrganizationMemberDtoFromJson(json);
}

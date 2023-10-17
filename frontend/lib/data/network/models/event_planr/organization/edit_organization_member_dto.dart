import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_organization_member_dto.freezed.dart';
part 'edit_organization_member_dto.g.dart';

@freezed
class EditOrganizationMemberDto with _$EditOrganizationMemberDto {
  const factory EditOrganizationMemberDto({
    required String memberUserId,
    required List<String> policies,
  }) = _EditOrganizationMemberDto;

  factory EditOrganizationMemberDto.fromJson(Map<String, Object?> json) =>
      _$EditOrganizationMemberDtoFromJson(json);
}

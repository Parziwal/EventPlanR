import 'package:freezed_annotation/freezed_annotation.dart';

part 'remove_member_from_organization_dto.freezed.dart';
part 'remove_member_from_organization_dto.g.dart';

@freezed
class RemoveMemberFromOrganizationDto with _$RemoveMemberFromOrganizationDto {
  const factory RemoveMemberFromOrganizationDto({
    required String memberUserId,
  }) = _RemoveMemberFromOrganizationDto;

  factory RemoveMemberFromOrganizationDto.fromJson(Map<String, Object?> json) =>
      _$RemoveMemberFromOrganizationDtoFromJson(json);
}

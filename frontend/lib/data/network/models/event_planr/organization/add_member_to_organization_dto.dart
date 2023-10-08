import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_member_to_organization_dto.freezed.dart';
part 'add_member_to_organization_dto.g.dart';

@freezed
class AddMemberToOrganizationDto with _$AddMemberToOrganizationDto {
  const factory AddMemberToOrganizationDto({
    required String memberUserEmail,
    required List<String> policies,
  }) = _AddMemberToOrganizationDto;

  factory AddMemberToOrganizationDto.fromJson(Map<String, Object?> json) =>
      _$AddMemberToOrganizationDtoFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_organization_dto.freezed.dart';
part 'edit_organization_dto.g.dart';

@freezed
class EditOrganizationDto with _$EditOrganizationDto {
  const factory EditOrganizationDto({
    String? description,
  }) = _EditOrganizationDto;

  factory EditOrganizationDto.fromJson(Map<String, Object?> json) =>
      _$EditOrganizationDtoFromJson(json);
}

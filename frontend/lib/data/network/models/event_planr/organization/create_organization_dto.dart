import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_organization_dto.freezed.dart';
part 'create_organization_dto.g.dart';

@freezed
class CreateOrganizationDto with _$CreateOrganizationDto {
  const factory CreateOrganizationDto({
    required String name,
    String? description,
  }) = _CreateOrganizationDto;

  factory CreateOrganizationDto.fromJson(Map<String, Object?> json) =>
      _$CreateOrganizationDtoFromJson(json);
}

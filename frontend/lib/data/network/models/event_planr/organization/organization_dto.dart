import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_dto.freezed.dart';
part 'organization_dto.g.dart';

@freezed
class OrganizationDto with _$OrganizationDto {
  const factory OrganizationDto({
    required String id,
    required String name,
    required String? profileImageUrl,
  }) = _OrganizationDto;

  factory OrganizationDto.fromJson(Map<String, Object?> json) =>
      _$OrganizationDtoFromJson(json);
}

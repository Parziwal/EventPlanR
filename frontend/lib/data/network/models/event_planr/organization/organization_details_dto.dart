import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_details_dto.freezed.dart';

part 'organization_details_dto.g.dart';

@freezed
class OrganizationDetailsDto with _$OrganizationDetailsDto {
  const factory OrganizationDetailsDto({
    required String id,
    required String name,
    String? profileImageUrl,
    String? description,
  }) = _OrganizationDetailsDto;

  factory OrganizationDetailsDto.fromJson(Map<String, Object?> json) =>
      _$OrganizationDetailsDtoFromJson(json);
}

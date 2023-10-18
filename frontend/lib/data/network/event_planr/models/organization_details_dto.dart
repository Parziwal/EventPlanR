// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'organization_details_dto.g.dart';

@JsonSerializable()
class OrganizationDetailsDto {
  const OrganizationDetailsDto({
    required this.id,
    required this.name,
    this.description,
    this.profileImageUrl,
  });
  
  factory OrganizationDetailsDto.fromJson(Map<String, Object?> json) => _$OrganizationDetailsDtoFromJson(json);
  
  final String id;
  final String name;
  final String? description;
  final String? profileImageUrl;

  Map<String, Object?> toJson() => _$OrganizationDetailsDtoToJson(this);
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'organization_dto.g.dart';

@JsonSerializable()
class OrganizationDto {
  const OrganizationDto({
    required this.id,
    required this.name,
    this.profileImageUrl,
  });
  
  factory OrganizationDto.fromJson(Map<String, Object?> json) => _$OrganizationDtoFromJson(json);
  
  final String id;
  final String name;
  final String? profileImageUrl;

  Map<String, Object?> toJson() => _$OrganizationDtoToJson(this);
}

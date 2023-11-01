// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'organization_member_dto.g.dart';

@JsonSerializable()
class OrganizationMemberDto {
  const OrganizationMemberDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.organizationPolicies,
  });
  
  factory OrganizationMemberDto.fromJson(Map<String, Object?> json) => _$OrganizationMemberDtoFromJson(json);
  
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final List<String> organizationPolicies;

  Map<String, Object?> toJson() => _$OrganizationMemberDtoToJson(this);
}

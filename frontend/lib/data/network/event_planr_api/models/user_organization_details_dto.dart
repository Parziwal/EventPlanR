// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'organization_member_dto.dart';

part 'user_organization_details_dto.g.dart';

@JsonSerializable()
class UserOrganizationDetailsDto {
  const UserOrganizationDetailsDto({
    required this.created,
    required this.lastModified,
    required this.id,
    required this.name,
    required this.members,
    this.createdBy,
    this.lastModifiedBy,
    this.description,
    this.profileImageUrl,
  });
  
  factory UserOrganizationDetailsDto.fromJson(Map<String, Object?> json) => _$UserOrganizationDetailsDtoFromJson(json);
  
  final DateTime created;
  final String? createdBy;
  final DateTime lastModified;
  final String? lastModifiedBy;
  final String id;
  final String name;
  final String? description;
  final String? profileImageUrl;
  final List<OrganizationMemberDto> members;

  Map<String, Object?> toJson() => _$UserOrganizationDetailsDtoToJson(this);
}

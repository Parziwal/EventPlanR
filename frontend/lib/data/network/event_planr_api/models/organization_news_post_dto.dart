// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'organization_news_post_dto.g.dart';

@JsonSerializable()
class OrganizationNewsPostDto {
  const OrganizationNewsPostDto({
    required this.created,
    required this.lastModified,
    required this.id,
    required this.title,
    required this.text,
    this.createdBy,
    this.lastModifiedBy,
  });
  
  factory OrganizationNewsPostDto.fromJson(Map<String, Object?> json) => _$OrganizationNewsPostDtoFromJson(json);
  
  final DateTime created;
  final String? createdBy;
  final DateTime lastModified;
  final String? lastModifiedBy;
  final String id;
  final String title;
  final String text;

  Map<String, Object?> toJson() => _$OrganizationNewsPostDtoToJson(this);
}

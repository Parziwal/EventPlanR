// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'organization_event_dto.g.dart';

@JsonSerializable()
class OrganizationEventDto {
  const OrganizationEventDto({
    required this.id,
    required this.name,
    required this.fromDate,
    required this.chatId,
    this.coverImageUrl,
  });
  
  factory OrganizationEventDto.fromJson(Map<String, Object?> json) => _$OrganizationEventDtoFromJson(json);
  
  final String id;
  final String name;
  final String? coverImageUrl;
  final DateTime fromDate;
  final String chatId;

  Map<String, Object?> toJson() => _$OrganizationEventDtoToJson(this);
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'event_dto.g.dart';

@JsonSerializable()
class EventDto {
  const EventDto({
    required this.id,
    required this.name,
    required this.fromDate,
    required this.toDate,
    required this.venue,
    required this.organizationName,
    this.coverImageUrl,
  });
  
  factory EventDto.fromJson(Map<String, Object?> json) => _$EventDtoFromJson(json);
  
  final String id;
  final String name;
  final DateTime fromDate;
  final DateTime toDate;
  final String venue;
  final String? coverImageUrl;
  final String organizationName;

  Map<String, Object?> toJson() => _$EventDtoToJson(this);
}

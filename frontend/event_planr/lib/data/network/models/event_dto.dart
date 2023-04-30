import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_dto.g.dart';

@JsonSerializable()
@DateTimeConverter()
@immutable
class EventDto {
  const EventDto({
    required this.id,
    required this.name,
    required this.category,
    required this.fromDate,
    required this.venue,
    required this.coverImageUrl,
  });

  factory EventDto.fromJson(Map<String, dynamic> json) =>
    _$EventDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EventDtoToJson(this);

  final String id;
  final String name;
  final int category;
  final DateTime fromDate;
  final String venue;
  final String? coverImageUrl;
}

import 'package:event_planr/data/network/models/event_address_dto.dart';
import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_details_dto.g.dart';

@JsonSerializable()
@DateTimeConverter()
@immutable
class EventDetailsDto {
  const EventDetailsDto({
    required this.id,
    required this.name,
    required this.category,
    required this.fromDate,
    required this.toDate,
    required this.address,
    required this.description,
    required this.coverImageUrl,
    required this.isPrivate,
  });

  factory EventDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$EventDetailsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EventDetailsDtoToJson(this);

  final String id;
  final String name;
  final int category;
  final DateTime fromDate;
  final DateTime toDate;
  final EventAddressDto address;
  final String? description;
  final String? coverImageUrl;
  final bool isPrivate;
}

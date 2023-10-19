// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'address_dto.dart';
import 'coordinates_dto.dart';
import 'currency.dart';
import 'event_category.dart';

part 'organization_event_details_dto.g.dart';

@JsonSerializable()
class OrganizationEventDetailsDto {
  const OrganizationEventDetailsDto({
    required this.created,
    required this.lastModified,
    required this.id,
    required this.name,
    required this.category,
    required this.fromDate,
    required this.toDate,
    required this.venue,
    required this.address,
    required this.coordinates,
    required this.currency,
    required this.isPrivate,
    required this.isPublished,
    this.createdBy,
    this.lastModifiedBy,
    this.description,
    this.coverImageUrl,
  });
  
  factory OrganizationEventDetailsDto.fromJson(Map<String, Object?> json) => _$OrganizationEventDetailsDtoFromJson(json);
  
  final DateTime created;
  final String? createdBy;
  final DateTime lastModified;
  final String? lastModifiedBy;
  final String id;
  final String name;
  final String? description;
  final String? coverImageUrl;
  final EventCategory category;
  final DateTime fromDate;
  final DateTime toDate;
  final String venue;
  final AddressDto address;
  final CoordinatesDto coordinates;
  final Currency currency;
  final bool isPrivate;
  final bool isPublished;

  Map<String, Object?> toJson() => _$OrganizationEventDetailsDtoToJson(this);
}

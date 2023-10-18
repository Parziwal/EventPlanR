// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'address_dto.dart';
import 'coordinates_dto.dart';
import 'event_category.dart';
import 'news_post_dto.dart';
import 'organization_dto.dart';

part 'event_details_dto.g.dart';

@JsonSerializable()
class EventDetailsDto {
  const EventDetailsDto({
    required this.id,
    required this.name,
    required this.category,
    required this.fromDate,
    required this.toDate,
    required this.venue,
    required this.address,
    required this.coordinates,
    required this.organization,
    this.description,
    this.coverImageUrl,
    this.latestNews,
  });
  
  factory EventDetailsDto.fromJson(Map<String, Object?> json) => _$EventDetailsDtoFromJson(json);
  
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
  final OrganizationDto organization;
  final NewsPostDto? latestNews;

  Map<String, Object?> toJson() => _$EventDetailsDtoToJson(this);
}

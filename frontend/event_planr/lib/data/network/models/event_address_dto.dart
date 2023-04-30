import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_address_dto.g.dart';

@JsonSerializable()
@immutable
class EventAddressDto {
  const EventAddressDto({
    required this.venue,
    required this.country,
    required this.zipCode,
    required this.city,
    required this.addressLine,
    required this.longitude,
    required this.latitude,
  });

  factory EventAddressDto.fromJson(Map<String, dynamic> json) =>
      _$EventAddressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EventAddressDtoToJson(this);

  final String venue;
  final String country;
  final String zipCode;
  final String city;
  final String addressLine;
  final double longitude;
  final double latitude;
}

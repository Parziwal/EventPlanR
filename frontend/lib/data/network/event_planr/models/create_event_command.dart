// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'address_dto.dart';
import 'coordinates_dto.dart';
import 'currency.dart';
import 'event_category.dart';

part 'create_event_command.g.dart';

@JsonSerializable()
class CreateEventCommand {
  const CreateEventCommand({
    required this.name,
    required this.category,
    required this.fromDate,
    required this.toDate,
    required this.venue,
    required this.address,
    required this.coordinates,
    required this.currency,
    required this.isPrivate,
    this.description,
  });
  
  factory CreateEventCommand.fromJson(Map<String, Object?> json) => _$CreateEventCommandFromJson(json);
  
  final String name;
  final String? description;
  final EventCategory category;
  final DateTime fromDate;
  final DateTime toDate;
  final String venue;
  final AddressDto address;
  final CoordinatesDto coordinates;
  final Currency currency;
  final bool isPrivate;

  Map<String, Object?> toJson() => _$CreateEventCommandToJson(this);
}

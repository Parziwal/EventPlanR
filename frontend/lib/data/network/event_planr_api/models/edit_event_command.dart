// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'address_dto.dart';
import 'coordinate_dto.dart';
import 'event_category.dart';

part 'edit_event_command.g.dart';

@JsonSerializable()
class EditEventCommand {
  const EditEventCommand({
    required this.category,
    required this.fromDate,
    required this.toDate,
    required this.venue,
    required this.address,
    required this.coordinate,
    this.description,
  });
  
  factory EditEventCommand.fromJson(Map<String, Object?> json) => _$EditEventCommandFromJson(json);
  
  final String? description;
  final EventCategory category;
  final DateTime fromDate;
  final DateTime toDate;
  final String venue;
  final AddressDto address;
  final CoordinateDto coordinate;

  Map<String, Object?> toJson() => _$EditEventCommandToJson(this);
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'add_ticket_to_event_command.g.dart';

@JsonSerializable()
class AddTicketToEventCommand {
  const AddTicketToEventCommand({
    required this.name,
    required this.price,
    required this.count,
    required this.saleStarts,
    required this.saleEnds,
    this.description,
  });
  
  factory AddTicketToEventCommand.fromJson(Map<String, Object?> json) => _$AddTicketToEventCommandFromJson(json);
  
  final String name;
  final double price;
  final int count;
  final String? description;
  final DateTime saleStarts;
  final DateTime saleEnds;

  Map<String, Object?> toJson() => _$AddTicketToEventCommandToJson(this);
}

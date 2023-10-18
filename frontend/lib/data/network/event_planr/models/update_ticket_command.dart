// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'update_ticket_command.g.dart';

@JsonSerializable()
class UpdateTicketCommand {
  const UpdateTicketCommand({
    required this.price,
    required this.count,
    required this.saleStarts,
    required this.saleEnds,
    this.description,
  });
  
  factory UpdateTicketCommand.fromJson(Map<String, Object?> json) => _$UpdateTicketCommandFromJson(json);
  
  final double price;
  final int count;
  final String? description;
  final DateTime saleStarts;
  final DateTime saleEnds;

  Map<String, Object?> toJson() => _$UpdateTicketCommandToJson(this);
}

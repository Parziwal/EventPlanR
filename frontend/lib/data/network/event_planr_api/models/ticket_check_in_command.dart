// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'ticket_check_in_command.g.dart';

@JsonSerializable()
class TicketCheckInCommand {
  const TicketCheckInCommand({
    required this.checkIn,
  });
  
  factory TicketCheckInCommand.fromJson(Map<String, Object?> json) => _$TicketCheckInCommandFromJson(json);
  
  final bool checkIn;

  Map<String, Object?> toJson() => _$TicketCheckInCommandToJson(this);
}

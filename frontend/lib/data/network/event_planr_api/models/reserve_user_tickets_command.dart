// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'add_reserve_ticket_dto.dart';

part 'reserve_user_tickets_command.g.dart';

@JsonSerializable()
class ReserveUserTicketsCommand {
  const ReserveUserTicketsCommand({
    required this.reserveTickets,
  });
  
  factory ReserveUserTicketsCommand.fromJson(Map<String, Object?> json) => _$ReserveUserTicketsCommandFromJson(json);
  
  final List<AddReserveTicketDto> reserveTickets;

  Map<String, Object?> toJson() => _$ReserveUserTicketsCommandToJson(this);
}

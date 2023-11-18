// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'ticket_statistics_dto.g.dart';

@JsonSerializable()
class TicketStatisticsDto {
  const TicketStatisticsDto({
    required this.id,
    required this.ticketName,
    required this.totalTicketCount,
    required this.soldTicketCount,
    required this.checkedInTicketCount,
  });
  
  factory TicketStatisticsDto.fromJson(Map<String, Object?> json) => _$TicketStatisticsDtoFromJson(json);
  
  final String id;
  final String ticketName;
  final int totalTicketCount;
  final int soldTicketCount;
  final int checkedInTicketCount;

  Map<String, Object?> toJson() => _$TicketStatisticsDtoToJson(this);
}

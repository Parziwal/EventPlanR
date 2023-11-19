// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'chart_spot_dto.dart';
import 'currency.dart';
import 'ticket_statistics_dto.dart';

part 'event_statistics_dto.g.dart';

@JsonSerializable()
class EventStatisticsDto {
  const EventStatisticsDto({
    required this.totalIncome,
    required this.currency,
    required this.totalTicketCount,
    required this.soldTicketCount,
    required this.soldTicketsPerDay,
    required this.soldTicketsPerMonth,
    required this.ticketStatistics,
    required this.totalCheckInCount,
    required this.checkInsPerHour,
    required this.checkInsPerDay,
    required this.totalInvitationCount,
    required this.acceptedInvitationCount,
    required this.deniedInvitationCount,
    required this.pendingInvitationCount,
  });
  
  factory EventStatisticsDto.fromJson(Map<String, Object?> json) => _$EventStatisticsDtoFromJson(json);
  
  final double totalIncome;
  final Currency currency;
  final int totalTicketCount;
  final int soldTicketCount;
  final List<ChartSpotDto> soldTicketsPerDay;
  final List<ChartSpotDto> soldTicketsPerMonth;
  final List<TicketStatisticsDto> ticketStatistics;
  final int totalCheckInCount;
  final List<ChartSpotDto> checkInsPerHour;
  final List<ChartSpotDto> checkInsPerDay;
  final int totalInvitationCount;
  final int acceptedInvitationCount;
  final int deniedInvitationCount;
  final int pendingInvitationCount;

  Map<String, Object?> toJson() => _$EventStatisticsDtoToJson(this);
}

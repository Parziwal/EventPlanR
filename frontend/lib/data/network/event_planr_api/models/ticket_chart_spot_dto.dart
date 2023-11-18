// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'ticket_chart_spot_dto.g.dart';

@JsonSerializable()
class TicketChartSpotDto {
  const TicketChartSpotDto({
    required this.dateTime,
    required this.count,
  });
  
  factory TicketChartSpotDto.fromJson(Map<String, Object?> json) => _$TicketChartSpotDtoFromJson(json);
  
  final DateTime dateTime;
  final int count;

  Map<String, Object?> toJson() => _$TicketChartSpotDtoToJson(this);
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'chart_spot_dto.g.dart';

@JsonSerializable()
class ChartSpotDto {
  const ChartSpotDto({
    required this.dateTime,
    required this.count,
  });
  
  factory ChartSpotDto.fromJson(Map<String, Object?> json) => _$ChartSpotDtoFromJson(json);
  
  final DateTime dateTime;
  final int count;

  Map<String, Object?> toJson() => _$ChartSpotDtoToJson(this);
}

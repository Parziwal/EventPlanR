// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'coordinates_dto.g.dart';

@JsonSerializable()
class CoordinatesDto {
  const CoordinatesDto({
    required this.latitude,
    required this.longitude,
  });
  
  factory CoordinatesDto.fromJson(Map<String, Object?> json) => _$CoordinatesDtoFromJson(json);
  
  final double latitude;
  final double longitude;

  Map<String, Object?> toJson() => _$CoordinatesDtoToJson(this);
}

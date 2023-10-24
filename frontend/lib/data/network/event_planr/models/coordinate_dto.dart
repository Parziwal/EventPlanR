// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'coordinate_dto.g.dart';

@JsonSerializable()
class CoordinateDto {
  const CoordinateDto({
    required this.latitude,
    required this.longitude,
  });
  
  factory CoordinateDto.fromJson(Map<String, Object?> json) => _$CoordinateDtoFromJson(json);
  
  final double latitude;
  final double longitude;

  Map<String, Object?> toJson() => _$CoordinateDtoToJson(this);
}

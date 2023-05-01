import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place_dto.g.dart';

@JsonSerializable()
@immutable
class PlaceDto {
  const PlaceDto({
    required this.placeId,
    required this.lat,
    required this.lon,
    required this.displayName,
  });

  factory PlaceDto.fromJson(Map<String, dynamic> json) =>
    _$PlaceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceDtoToJson(this);

  @JsonKey(name: 'place_id')
  final int placeId;
  final String lat;
  final String lon;
  @JsonKey(name: 'display_name')
  final String displayName;
}

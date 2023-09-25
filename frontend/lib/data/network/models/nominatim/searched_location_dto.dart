import 'package:freezed_annotation/freezed_annotation.dart';

part 'searched_location_dto.freezed.dart';
part 'searched_location_dto.g.dart';

@freezed
class SearchedLocationDto with _$SearchedLocationDto {
  const factory SearchedLocationDto({
    @JsonKey(name: 'place_id') required int placeId,
    required String lat,
    required String lon,
    @JsonKey(name: 'display_name') required String displayName,
  }) = _SearchedLocationDto;

  factory SearchedLocationDto.fromJson(Map<String, dynamic> json) =>
      _$SearchedLocationDtoFromJson(json);
}

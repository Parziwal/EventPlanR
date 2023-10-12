import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_address_dto.freezed.dart';
part 'map_address_dto.g.dart';

@freezed
class MapAddressDto with _$MapAddressDto {
  const factory MapAddressDto({
    String? country,
    String? postcode,
    String? city,
    String? town,
    String? village,
    String? road,
    @JsonKey(name: 'house_number')
    String? houseNumber,
  }) = _MapAddressDto;

  factory MapAddressDto.fromJson(Map<String, dynamic> json) =>
      _$MapAddressDtoFromJson(json);
}

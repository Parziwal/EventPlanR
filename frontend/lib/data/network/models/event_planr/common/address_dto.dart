import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_dto.freezed.dart';
part 'address_dto.g.dart';

@freezed
class AddressDto with _$AddressDto {
  const factory AddressDto({
    required String country,
    required String zipCode,
    required String city,
    required String addressLine,
  }) = _AddressDto;

  factory AddressDto.fromJson(Map<String, Object?> json) =>
      _$AddressDtoFromJson(json);
}

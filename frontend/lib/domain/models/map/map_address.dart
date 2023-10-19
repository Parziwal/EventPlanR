import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_address.freezed.dart';

@freezed
class MapAddress with _$MapAddress {
  const factory MapAddress({
    required String country,
    required String zipCode,
    required String city,
    required String road,
    required String houseNumber,
  }) = _MapAddress;
}

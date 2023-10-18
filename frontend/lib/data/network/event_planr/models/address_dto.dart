// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'address_dto.g.dart';

@JsonSerializable()
class AddressDto {
  const AddressDto({
    required this.country,
    required this.zipCode,
    required this.city,
    required this.addressLine,
  });
  
  factory AddressDto.fromJson(Map<String, Object?> json) => _$AddressDtoFromJson(json);
  
  final String country;
  final String zipCode;
  final String city;
  final String addressLine;

  Map<String, Object?> toJson() => _$AddressDtoToJson(this);
}

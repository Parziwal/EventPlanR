import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
@immutable
class UserDto {
  const UserDto({
    required this.email,
    required this.name,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
    _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  @JsonKey(name: 'Email')
  final String email;
  @JsonKey(name: 'Name')
  final String name;
}

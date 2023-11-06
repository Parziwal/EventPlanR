// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'object4.g.dart';

@JsonSerializable()
class Object4 {
  const Object4({
    this.additionalProperties,
  });
  
  factory Object4.fromJson(Map<String, Object?> json) => _$Object4FromJson(json);
  
  final List<String>? additionalProperties;

  Map<String, Object?> toJson() => _$Object4ToJson(this);
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'object5.g.dart';

@JsonSerializable()
class Object5 {
  const Object5({
    this.additionalProperties,
  });
  
  factory Object5.fromJson(Map<String, Object?> json) => _$Object5FromJson(json);
  
  final List<String>? additionalProperties;

  Map<String, Object?> toJson() => _$Object5ToJson(this);
}

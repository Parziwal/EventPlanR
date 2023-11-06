// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'object3.g.dart';

@JsonSerializable()
class Object3 {
  const Object3({
    this.additionalProperties,
  });
  
  factory Object3.fromJson(Map<String, Object?> json) => _$Object3FromJson(json);
  
  final List<String>? additionalProperties;

  Map<String, Object?> toJson() => _$Object3ToJson(this);
}

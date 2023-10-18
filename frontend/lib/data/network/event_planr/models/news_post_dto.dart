// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'news_post_dto.g.dart';

@JsonSerializable()
class NewsPostDto {
  const NewsPostDto({
    required this.text,
    required this.lastModified,
  });
  
  factory NewsPostDto.fromJson(Map<String, Object?> json) => _$NewsPostDtoFromJson(json);
  
  final String text;
  final DateTime lastModified;

  Map<String, Object?> toJson() => _$NewsPostDtoToJson(this);
}

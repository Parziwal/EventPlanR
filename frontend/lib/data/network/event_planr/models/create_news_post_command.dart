// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'create_news_post_command.g.dart';

@JsonSerializable()
class CreateNewsPostCommand {
  const CreateNewsPostCommand({
    required this.title,
    required this.text,
  });
  
  factory CreateNewsPostCommand.fromJson(Map<String, Object?> json) => _$CreateNewsPostCommandFromJson(json);
  
  final String title;
  final String text;

  Map<String, Object?> toJson() => _$CreateNewsPostCommandToJson(this);
}

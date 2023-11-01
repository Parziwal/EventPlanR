// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'create_direct_chat_command.g.dart';

@JsonSerializable()
class CreateDirectChatCommand {
  const CreateDirectChatCommand({
    required this.userEmail,
  });
  
  factory CreateDirectChatCommand.fromJson(Map<String, Object?> json) => _$CreateDirectChatCommandFromJson(json);
  
  final String userEmail;

  Map<String, Object?> toJson() => _$CreateDirectChatCommandToJson(this);
}

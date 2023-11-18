// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'invite_user_to_event_command.g.dart';

@JsonSerializable()
class InviteUserToEventCommand {
  const InviteUserToEventCommand({
    required this.eventId,
    required this.userEmail,
  });
  
  factory InviteUserToEventCommand.fromJson(Map<String, Object?> json) => _$InviteUserToEventCommandFromJson(json);
  
  final String eventId;
  final String userEmail;

  Map<String, Object?> toJson() => _$InviteUserToEventCommandToJson(this);
}

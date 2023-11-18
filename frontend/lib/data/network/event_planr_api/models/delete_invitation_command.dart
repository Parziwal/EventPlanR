// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'delete_invitation_command.g.dart';

@JsonSerializable()
class DeleteInvitationCommand {
  const DeleteInvitationCommand({
    required this.invitationId,
  });
  
  factory DeleteInvitationCommand.fromJson(Map<String, Object?> json) => _$DeleteInvitationCommandFromJson(json);
  
  final String invitationId;

  Map<String, Object?> toJson() => _$DeleteInvitationCommandToJson(this);
}

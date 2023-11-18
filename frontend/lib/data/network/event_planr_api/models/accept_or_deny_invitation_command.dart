// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'accept_or_deny_invitation_command.g.dart';

@JsonSerializable()
class AcceptOrDenyInvitationCommand {
  const AcceptOrDenyInvitationCommand({
    required this.invitationId,
    required this.accept,
  });
  
  factory AcceptOrDenyInvitationCommand.fromJson(Map<String, Object?> json) => _$AcceptOrDenyInvitationCommandFromJson(json);
  
  final String invitationId;
  final bool accept;

  Map<String, Object?> toJson() => _$AcceptOrDenyInvitationCommandToJson(this);
}

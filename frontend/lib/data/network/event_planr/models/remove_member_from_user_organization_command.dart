// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'remove_member_from_user_organization_command.g.dart';

@JsonSerializable()
class RemoveMemberFromUserOrganizationCommand {
  const RemoveMemberFromUserOrganizationCommand({
    required this.memberUserId,
  });
  
  factory RemoveMemberFromUserOrganizationCommand.fromJson(Map<String, Object?> json) => _$RemoveMemberFromUserOrganizationCommandFromJson(json);
  
  final String memberUserId;

  Map<String, Object?> toJson() => _$RemoveMemberFromUserOrganizationCommandToJson(this);
}

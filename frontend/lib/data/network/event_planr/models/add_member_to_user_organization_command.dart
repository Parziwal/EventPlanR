// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'add_member_to_user_organization_command.g.dart';

@JsonSerializable()
class AddMemberToUserOrganizationCommand {
  const AddMemberToUserOrganizationCommand({
    required this.memberUserEmail,
    required this.policies,
  });
  
  factory AddMemberToUserOrganizationCommand.fromJson(Map<String, Object?> json) => _$AddMemberToUserOrganizationCommandFromJson(json);
  
  final String memberUserEmail;
  final List<String> policies;

  Map<String, Object?> toJson() => _$AddMemberToUserOrganizationCommandToJson(this);
}

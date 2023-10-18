// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'edit_organization_member_command.g.dart';

@JsonSerializable()
class EditOrganizationMemberCommand {
  const EditOrganizationMemberCommand({
    required this.memberUserId,
    required this.policies,
  });
  
  factory EditOrganizationMemberCommand.fromJson(Map<String, Object?> json) => _$EditOrganizationMemberCommandFromJson(json);
  
  final String memberUserId;
  final List<String> policies;

  Map<String, Object?> toJson() => _$EditOrganizationMemberCommandToJson(this);
}

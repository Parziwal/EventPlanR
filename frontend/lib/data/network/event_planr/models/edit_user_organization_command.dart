// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'edit_user_organization_command.g.dart';

@JsonSerializable()
class EditUserOrganizationCommand {
  const EditUserOrganizationCommand({
    this.description,
  });
  
  factory EditUserOrganizationCommand.fromJson(Map<String, Object?> json) => _$EditUserOrganizationCommandFromJson(json);
  
  final String? description;

  Map<String, Object?> toJson() => _$EditUserOrganizationCommandToJson(this);
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'create_organization_command.g.dart';

@JsonSerializable()
class CreateOrganizationCommand {
  const CreateOrganizationCommand({
    required this.name,
    this.description,
  });
  
  factory CreateOrganizationCommand.fromJson(Map<String, Object?> json) => _$CreateOrganizationCommandFromJson(json);
  
  final String name;
  final String? description;

  Map<String, Object?> toJson() => _$CreateOrganizationCommandToJson(this);
}

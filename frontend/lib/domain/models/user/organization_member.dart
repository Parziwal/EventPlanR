import 'package:event_planr_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_member.freezed.dart';
part 'organization_member.g.dart';

@freezed
class OrganizationMember with _$OrganizationMember {
  const factory OrganizationMember({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required List<String> organizationPolicies,
  }) = _OrganizationMember;

  const OrganizationMember._();

  factory OrganizationMember.fromJson(Map<String, Object?> json) =>
      _$OrganizationMemberFromJson(json);

  String getUserFullName(BuildContext context) {
    return context.l10n.localeName == 'hu'
        ? '$lastName $firstName'
        : '$firstName $lastName';
  }

  String getUserMonogram(BuildContext context) {
    return context.l10n.localeName == 'hu'
        ? '${lastName[0]} ${firstName[0]}'
        : '${firstName[0]} ${lastName[0]}';
  }
}

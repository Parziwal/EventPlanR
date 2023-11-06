import 'package:event_planr_app/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: 'cognito:username')
    required String id,
    required String email,
    @JsonKey(name: 'given_name')
    required String firstName,
    @JsonKey(name: 'family_name')
    required String lastName,
    @JsonKey(name: 'organization_id')
    String? organizationId,
    @JsonKey(name: 'organization_policies')
    List<String>? organizationPolicies,
    String? picture,
  }) = _User;

  const User._();

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);

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

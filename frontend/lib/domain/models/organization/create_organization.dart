import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_organization.freezed.dart';
part 'create_organization.g.dart';

@freezed
class CreateOrganization with _$CreateOrganization {
  const factory CreateOrganization({
    required String name,
    String? description,
  }) = _CreateOrganization;

  factory CreateOrganization.fromJson(Map<String, Object?> json) =>
      _$CreateOrganizationFromJson(json);
}

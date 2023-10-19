import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_or_edit_organization.freezed.dart';
part 'create_or_edit_organization.g.dart';

@freezed
class CreateOrEditOrganization with _$CreateOrEditOrganization {
  const factory CreateOrEditOrganization({
    String? name,
    String? description,
  }) = _CreateOrganization;

  factory CreateOrEditOrganization.fromJson(Map<String, Object?> json) =>
      _$CreateOrEditOrganizationFromJson(json);
}

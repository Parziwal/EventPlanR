import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_organization.freezed.dart';
part 'edit_organization.g.dart';

@freezed
class EditOrganization with _$EditOrganization {
  const factory EditOrganization({
    String? description,
  }) = _EditOrganization;

  factory EditOrganization.fromJson(Map<String, Object?> json) =>
      _$EditOrganizationFromJson(json);
}

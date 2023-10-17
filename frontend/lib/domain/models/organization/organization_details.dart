import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_details.freezed.dart';
part 'organization_details.g.dart';

@freezed
class OrganizationDetails with _$OrganizationDetails {
  const factory OrganizationDetails({
    required String id,
    required String name,
    String? profileImageUrl,
    String? description,
  }) = _OrganizationDetails;

  factory OrganizationDetails.fromJson(Map<String, Object?> json) =>
      _$OrganizationDetailsFromJson(json);
}

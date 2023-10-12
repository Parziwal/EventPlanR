import 'package:event_planr_app/domain/models/user/user_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_organization_details.freezed.dart';
part 'user_organization_details.g.dart';

@freezed
class UserOrganizationDetails with _$UserOrganizationDetails {
  const factory UserOrganizationDetails({
    required String id,
    required String name,
    required List<UserData> members,
    String? profileImageUrl,
  }) = _UserOrganizationDetails;

  factory UserOrganizationDetails.fromJson(Map<String, Object?> json) =>
      _$UserOrganizationDetailsFromJson(json);
}
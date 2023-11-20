part of 'user_organization_details_cubit.dart';

enum UserOrganizationDetailsStatus {
  idle,
  loading,
  error,
  organizationDeleted,
}

@freezed
class UserOrganizationDetailsState with _$UserOrganizationDetailsState {
  const factory UserOrganizationDetailsState({
    required UserOrganizationDetailsStatus status,
    UserOrganizationDetails? organizationDetails,
    Exception? exception,
  }) = _UserOrganizationDetailsState;
}

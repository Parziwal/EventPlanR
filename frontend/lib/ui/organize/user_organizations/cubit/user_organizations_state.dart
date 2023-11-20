part of 'user_organizations_cubit.dart';

enum UserOrganizationsStatus { idle, loading, error, organizationChanged }

@freezed
class UserOrganizationsState with _$UserOrganizationsState {
  const factory UserOrganizationsState({
    required UserOrganizationsStatus status,
    List<Organization>? organizations,
    Exception? exception,
  }) = _UserOrganizationsState;
}

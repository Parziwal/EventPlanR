part of 'user_organizations_cubit.dart';

@freezed
sealed class UserOrganizationsState with _$UserOrganizationsState {
  const factory UserOrganizationsState.idle() = Idle;
  const factory UserOrganizationsState.loading() = Loading;
}

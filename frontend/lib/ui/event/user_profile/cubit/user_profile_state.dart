part of 'user_profile_cubit.dart';

@freezed
class UserProfileState with _$UserProfileState {
  const factory UserProfileState.idle() = _Idle;
  const factory UserProfileState.logout() = _Logout;
  const factory UserProfileState.loading() = _Loading;
}

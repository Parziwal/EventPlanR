part of 'user_profile_cubit.dart';

@freezed
sealed class UserProfileState with _$UserProfileState {
  const factory UserProfileState.idle() = Idle;
  const factory UserProfileState.loggedOut() = LoggedOut;
  const factory UserProfileState.loading() = Loading;
}

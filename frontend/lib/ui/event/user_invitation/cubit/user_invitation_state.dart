part of 'user_invitation_cubit.dart';

enum UserInvitationStatus {
  idle,
  loading,
  error,
  invitationAccepted,
  invitationDenied,
}

@freezed
class UserInvitationState with _$UserInvitationState {
  const factory UserInvitationState({
    required UserInvitationStatus status,
    UserInvitation? invitation,
    String? errorCode,
  }) = _UserInvitationState;
}

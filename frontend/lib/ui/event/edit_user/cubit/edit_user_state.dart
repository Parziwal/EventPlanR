part of '../../edit_user/cubit/edit_user_cubit.dart';

enum EditUserStatus {
  idle,
  loading,
  error,
  userEdited,
  emailConfirmed,
  codeResended,
}

@freezed
class EditUserState with _$EditUserState {
  const factory EditUserState({
    required EditUserStatus status,
    @Default(false)
    bool emailConfirmationNeeded,
    User? user,
    String? errorCode,
  }) = _EditUserState;
}

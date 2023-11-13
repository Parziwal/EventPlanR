part of 'auth_cubit.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.idle() = Idle;

  const factory AuthState.loading() = Loading;

  const factory AuthState.success() = Success;

  const factory AuthState.confirmSignUp() = ConfirmSignUp;

  const factory AuthState.confirmSignInWithNewPassword() =
      ConfirmSignInWithNewPassword;

  const factory AuthState.confirmForgotPassword() = ConfirmForgotPassword;

  const factory AuthState.codeResended() = CodeResended;

  const factory AuthState.signInNext() = SignInNext;

  const factory AuthState.error(String errorCode) = Error;
}

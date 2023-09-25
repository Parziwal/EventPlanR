part of 'auth_cubit.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.idle() = _Idle;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.success() = _Success;
  const factory AuthState.confirmSignUp() = _ConfirmSignUp;
  const factory AuthState.confirmForgotPassword() = _ConfirmForgotPassword;
  const factory AuthState.codeResended() = _CodeResended;
  const factory AuthState.signInNext() = _SignInNext;
  const factory AuthState.error(String errorCode) = _Error;
}

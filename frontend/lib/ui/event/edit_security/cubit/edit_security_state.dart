part of 'edit_security_cubit.dart';

enum EditSecurityStatus {
  idle,
  loading,
  error,
  passwordChanged,
}

@freezed
class EditSecurityState with _$EditSecurityState {
  const factory EditSecurityState({
    required EditSecurityStatus status,
    Exception? exception,
  }) = _EditSecurityState;
}

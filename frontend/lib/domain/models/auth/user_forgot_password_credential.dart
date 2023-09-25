import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_forgot_password_credential.freezed.dart';
part 'user_forgot_password_credential.g.dart';

@freezed
class UserForgotPasswordCredential with _$UserForgotPasswordCredential {
  const factory UserForgotPasswordCredential({
    required String confirmCode,
    required String newPassword,
  }) = _UserForgotPasswordCredential;

  factory UserForgotPasswordCredential.fromJson(Map<String, Object?> json) =>
      _$UserForgotPasswordCredentialFromJson(json);
}

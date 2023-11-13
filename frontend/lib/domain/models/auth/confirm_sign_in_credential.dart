import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_sign_in_credential.freezed.dart';
part 'confirm_sign_in_credential.g.dart';

@freezed
class ConfirmSignInCredential with _$ConfirmSignInCredential{
  const factory ConfirmSignInCredential({
    required String firstName,
    required String lastName,
    required String password,
  }) = _ConfirmSignInCredential;

  factory ConfirmSignInCredential.fromJson(Map<String, Object?> json) =>
      _$ConfirmSignInCredentialFromJson(json);
}

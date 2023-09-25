import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_sign_in_credential.freezed.dart';
part 'user_sign_in_credential.g.dart';

@freezed
class UserSignInCredential with _$UserSignInCredential {
  const factory UserSignInCredential({
    required String email,
    required String password,
  }) = _UserSignInCredential;

  factory UserSignInCredential.fromJson(Map<String, Object?> json) =>
      _$UserSignInCredentialFromJson(json);
}

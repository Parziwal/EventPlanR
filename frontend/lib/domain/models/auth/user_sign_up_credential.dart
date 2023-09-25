import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_sign_up_credential.freezed.dart';
part 'user_sign_up_credential.g.dart';

@freezed
class UserSignUpCredential with _$UserSignUpCredential {
  const factory UserSignUpCredential({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
  }) = _UserSignUpCredential;

  factory UserSignUpCredential.fromJson(Map<String, Object?> json) =>
      _$UserSignUpCredentialFromJson(json);
}

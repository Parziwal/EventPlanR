import 'package:json_annotation/json_annotation.dart';

part 'user_signup_credentials.g.dart';

@JsonSerializable()
class UserSignUpCredentials {
  UserSignUpCredentials({
    required this.email,
    required this.fullName,
    required this.password,
  });

  factory UserSignUpCredentials.fromJson(Map<String, dynamic> json) =>
      _$UserSignUpCredentialsFromJson(json);

  final String email;
  final String fullName;
  final String password;
}

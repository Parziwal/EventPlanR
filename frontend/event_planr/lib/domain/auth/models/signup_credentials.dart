import 'package:json_annotation/json_annotation.dart';

part 'signup_credentials.g.dart';

@JsonSerializable()
class SignUpCredentials {
  SignUpCredentials({
    required this.email,
    required this.fullName,
    required this.password,
  });

  factory SignUpCredentials.fromJson(Map<String, dynamic> json) =>
      _$SignUpCredentialsFromJson(json);

  final String email;
  final String fullName;
  final String password;
}

import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_credentials.g.dart';

@JsonSerializable()
class ForgotPasswordCredentials {
  ForgotPasswordCredentials({
    required this.confirmCode,
    required this.newPassword,
  });

  factory ForgotPasswordCredentials.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordCredentialsFromJson(json);

  final String confirmCode;
  final String newPassword;
}

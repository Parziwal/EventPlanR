import 'package:json_annotation/json_annotation.dart';

part 'login_credentials.g.dart';

@JsonSerializable()
class LoginCredentials {
      
  LoginCredentials({required this.email, required this.password});

  factory LoginCredentials.fromJson(Map<String, dynamic> json) =>
      _$LoginCredentialsFromJson(json);

  final String email;
  final String password;
}

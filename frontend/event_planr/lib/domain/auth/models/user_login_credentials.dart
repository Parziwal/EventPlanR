import 'package:json_annotation/json_annotation.dart';

part 'user_login_credentials.g.dart';

@JsonSerializable()
class UserLoginCredentials {
      
  UserLoginCredentials({required this.email, required this.password});

  factory UserLoginCredentials.fromJson(Map<String, dynamic> json) =>
      _$UserLoginCredentialsFromJson(json);

  final String email;
  final String password;
}

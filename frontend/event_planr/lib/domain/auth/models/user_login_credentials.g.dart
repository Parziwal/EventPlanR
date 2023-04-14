// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginCredentials _$UserLoginCredentialsFromJson(
        Map<String, dynamic> json) =>
    UserLoginCredentials(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserLoginCredentialsToJson(
        UserLoginCredentials instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

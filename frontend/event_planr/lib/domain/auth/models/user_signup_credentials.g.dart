// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_signup_credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSignUpCredentials _$UserSignUpCredentialsFromJson(
        Map<String, dynamic> json) =>
    UserSignUpCredentials(
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserSignUpCredentialsToJson(
        UserSignUpCredentials instance) =>
    <String, dynamic>{
      'email': instance.email,
      'fullName': instance.fullName,
      'password': instance.password,
    };

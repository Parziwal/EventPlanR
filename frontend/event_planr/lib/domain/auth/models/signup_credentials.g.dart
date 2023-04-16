// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpCredentials _$SignUpCredentialsFromJson(Map<String, dynamic> json) =>
    SignUpCredentials(
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignUpCredentialsToJson(SignUpCredentials instance) =>
    <String, dynamic>{
      'email': instance.email,
      'fullName': instance.fullName,
      'password': instance.password,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordCredentials _$ForgotPasswordCredentialsFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordCredentials(
      confirmCode: json['confirmCode'] as String,
      newPassword: json['newPassword'] as String,
    );

Map<String, dynamic> _$ForgotPasswordCredentialsToJson(
        ForgotPasswordCredentials instance) =>
    <String, dynamic>{
      'confirmCode': instance.confirmCode,
      'newPassword': instance.newPassword,
    };

import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password.freezed.dart';
part 'change_password.g.dart';

@freezed
class ChangePassword with _$ChangePassword {
  const factory ChangePassword({
    required String oldPassword,
    required String newPassword,
  }) = _ChangePassword;

  factory ChangePassword.fromJson(Map<String, Object?> json) =>
      _$ChangePasswordFromJson(json);
}

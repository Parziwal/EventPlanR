import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_user.freezed.dart';
part 'edit_user.g.dart';

@freezed
class EditUser with _$EditUser {
  const factory EditUser({
    required String firstName,
    required String lastName,
    required String email,
  }) = _EditUser;

  factory EditUser.fromJson(Map<String, Object?> json) =>
      _$EditUserFromJson(json);
}

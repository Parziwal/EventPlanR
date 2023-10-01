import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: 'sub')
    required String id,
    required String email,
    @JsonKey(name: 'given_name')
    required String firstName,
    @JsonKey(name: 'family_name')
    required String lastName,
    @Default([])
    List<String> organizationIds,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User({required this.sub, required this.email, required this.name});

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  final String sub;
  final String email;
  final String name;
}

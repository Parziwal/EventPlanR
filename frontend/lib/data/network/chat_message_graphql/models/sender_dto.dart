import 'package:freezed_annotation/freezed_annotation.dart';

part 'sender_dto.g.dart';

@JsonSerializable()
class SenderDto {
  const SenderDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.profileImageUrl,
  });

  factory SenderDto.fromJson(Map<String, Object?> json) =>
      _$SenderDtoFromJson(json);

  @JsonKey(name: 'Id')
  final String id;
  @JsonKey(name: 'FirstName')
  final String firstName;
  @JsonKey(name: 'LastName')
  final String lastName;
  @JsonKey(name: 'ProfileImageUrl')
  final String? profileImageUrl;

  Map<String, Object?> toJson() => _$SenderDtoToJson(this);
}

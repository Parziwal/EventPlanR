// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'direct_chat_dto.g.dart';

@JsonSerializable()
class DirectChatDto {
  const DirectChatDto({
    required this.id,
    required this.lastMessageDate,
    required this.haveUnreadMessages,
    required this.contactFirstName,
    required this.contactLastName,
    this.profileImageUrl,
  });
  
  factory DirectChatDto.fromJson(Map<String, Object?> json) => _$DirectChatDtoFromJson(json);
  
  final String id;
  final DateTime lastMessageDate;
  final bool haveUnreadMessages;
  final String contactFirstName;
  final String contactLastName;
  final String? profileImageUrl;

  Map<String, Object?> toJson() => _$DirectChatDtoToJson(this);
}

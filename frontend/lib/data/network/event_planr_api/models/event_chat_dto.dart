// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'event_chat_dto.g.dart';

@JsonSerializable()
class EventChatDto {
  const EventChatDto({
    required this.id,
    required this.lastMessageDate,
    required this.haveUnreadMessages,
    required this.eventName,
    this.profileImageUrl,
  });
  
  factory EventChatDto.fromJson(Map<String, Object?> json) => _$EventChatDtoFromJson(json);
  
  final String id;
  final DateTime lastMessageDate;
  final bool haveUnreadMessages;
  final String eventName;
  final String? profileImageUrl;

  Map<String, Object?> toJson() => _$EventChatDtoToJson(this);
}

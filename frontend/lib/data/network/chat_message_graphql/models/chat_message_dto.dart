import 'package:event_planr_app/data/network/chat_message_graphql/models/sender_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_dto.g.dart';

@JsonSerializable()
class ChatMessageDto {
  const ChatMessageDto({
    required this.chatId,
    required this.content,
    required this.createdAt,
    required this.sender,
  });

  factory ChatMessageDto.fromJson(Map<String, Object?> json) =>
      _$ChatMessageDtoFromJson(json);

  @JsonKey(name: 'ChatId')
  final String chatId;
  @JsonKey(name: 'Content')
  final String content;
  @JsonKey(name: 'CreatedAt')
  final DateTime createdAt;
  @JsonKey(name: 'Sender')
  final SenderDto sender;

  Map<String, Object?> toJson() => _$ChatMessageDtoToJson(this);
}

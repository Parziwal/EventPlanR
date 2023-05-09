import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_ticket_dto.g.dart';

@JsonSerializable()
@immutable
class UserTicketDto {
  const UserTicketDto({
    required this.id,
    required this.ticketName,
    required this.quantity,
  });

  factory UserTicketDto.fromJson(Map<String, dynamic> json) =>
    _$UserTicketDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserTicketDtoToJson(this);

  final String id;
  final String ticketName;
  final int quantity;
}

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'buy_ticket_dto.g.dart';

@JsonSerializable()
@immutable
class BuyTicketDto {
  const BuyTicketDto({
    required this.ticketName,
    required this.quantity,
  });

  factory BuyTicketDto.fromJson(Map<String, dynamic> json) =>
    _$BuyTicketDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BuyTicketDtoToJson(this);

  final String ticketName;
  final int quantity;
}

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_ticket_dto.g.dart';

@JsonSerializable()
@immutable
class EventTicketDto {
  const EventTicketDto({
    required this.name,
    required this.price,
    required this.description,
  });

  factory EventTicketDto.fromJson(Map<String, dynamic> json) =>
    _$EventTicketDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EventTicketDtoToJson(this);

  final String name;
  final double price;
  final String description;
}

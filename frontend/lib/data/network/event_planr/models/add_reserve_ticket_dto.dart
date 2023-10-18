// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'add_reserve_ticket_dto.g.dart';

@JsonSerializable()
class AddReserveTicketDto {
  const AddReserveTicketDto({
    required this.ticketId,
    required this.count,
  });
  
  factory AddReserveTicketDto.fromJson(Map<String, Object?> json) => _$AddReserveTicketDtoFromJson(json);
  
  final String ticketId;
  final int count;

  Map<String, Object?> toJson() => _$AddReserveTicketDtoToJson(this);
}

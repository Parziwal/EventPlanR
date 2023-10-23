// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'ticket_dto.g.dart';

@JsonSerializable()
class TicketDto {
  const TicketDto({
    required this.id,
    required this.name,
    required this.price,
    required this.count,
    required this.saleStarts,
    required this.salesEnds,
    this.description,
  });
  
  factory TicketDto.fromJson(Map<String, Object?> json) => _$TicketDtoFromJson(json);
  
  final String id;
  final String name;
  final double price;
  final int count;
  final String? description;
  final DateTime saleStarts;
  final DateTime salesEnds;

  Map<String, Object?> toJson() => _$TicketDtoToJson(this);
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'currency.dart';

part 'ticket_dto.g.dart';

@JsonSerializable()
class TicketDto {
  const TicketDto({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.count,
    required this.saleStarts,
    required this.saleEnds,
    this.description,
  });
  
  factory TicketDto.fromJson(Map<String, Object?> json) => _$TicketDtoFromJson(json);
  
  final String id;
  final String name;
  final double price;
  final Currency currency;
  final int count;
  final String? description;
  final DateTime saleStarts;
  final DateTime saleEnds;

  Map<String, Object?> toJson() => _$TicketDtoToJson(this);
}

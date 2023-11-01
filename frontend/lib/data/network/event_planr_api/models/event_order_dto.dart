// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'currency.dart';

part 'event_order_dto.g.dart';

@JsonSerializable()
class EventOrderDto {
  const EventOrderDto({
    required this.id,
    required this.customerFirstName,
    required this.customerLastName,
    required this.total,
    required this.currency,
    required this.ticketCount,
  });
  
  factory EventOrderDto.fromJson(Map<String, Object?> json) => _$EventOrderDtoFromJson(json);
  
  final String id;
  final String customerFirstName;
  final String customerLastName;
  final double total;
  final Currency currency;
  final int ticketCount;

  Map<String, Object?> toJson() => _$EventOrderDtoToJson(this);
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'currency.dart';

part 'sold_ticket_dto.g.dart';

@JsonSerializable()
class SoldTicketDto {
  const SoldTicketDto({
    required this.id,
    required this.userFirstName,
    required this.userLastName,
    required this.price,
    required this.currency,
    required this.ticketName,
  });
  
  factory SoldTicketDto.fromJson(Map<String, Object?> json) => _$SoldTicketDtoFromJson(json);
  
  final String id;
  final String userFirstName;
  final String userLastName;
  final double price;
  final Currency currency;
  final String ticketName;

  Map<String, Object?> toJson() => _$SoldTicketDtoToJson(this);
}

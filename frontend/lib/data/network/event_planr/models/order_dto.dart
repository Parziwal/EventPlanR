// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'address_dto.dart';
import 'currency.dart';
import 'sold_ticket_dto.dart';

part 'order_dto.g.dart';

@JsonSerializable()
class OrderDto {
  const OrderDto({
    required this.customerFirstName,
    required this.customerLastName,
    required this.billingAddress,
    required this.total,
    required this.currency,
    required this.soldTickets,
  });
  
  factory OrderDto.fromJson(Map<String, Object?> json) => _$OrderDtoFromJson(json);
  
  final String customerFirstName;
  final String customerLastName;
  final AddressDto billingAddress;
  final double total;
  final Currency currency;
  final List<SoldTicketDto> soldTickets;

  Map<String, Object?> toJson() => _$OrderDtoToJson(this);
}

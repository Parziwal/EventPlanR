// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'address_dto.dart';
import 'currency.dart';
import 'sold_ticket_dto.dart';

part 'order_details_dto.g.dart';

@JsonSerializable()
class OrderDetailsDto {
  const OrderDetailsDto({
    required this.id,
    required this.customerFirstName,
    required this.customerLastName,
    required this.billingAddress,
    required this.total,
    required this.currency,
    required this.soldTickets,
    required this.created,
  });
  
  factory OrderDetailsDto.fromJson(Map<String, Object?> json) => _$OrderDetailsDtoFromJson(json);
  
  final String id;
  final String customerFirstName;
  final String customerLastName;
  final AddressDto billingAddress;
  final double total;
  final Currency currency;
  final List<SoldTicketDto> soldTickets;
  final DateTime created;

  Map<String, Object?> toJson() => _$OrderDetailsDtoToJson(this);
}

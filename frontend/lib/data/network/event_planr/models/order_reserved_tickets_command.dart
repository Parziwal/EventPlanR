// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'add_ticket_user_info_dto.dart';
import 'address_dto.dart';

part 'order_reserved_tickets_command.g.dart';

@JsonSerializable()
class OrderReservedTicketsCommand {
  const OrderReservedTicketsCommand({
    required this.customerFirstName,
    required this.customerLastName,
    required this.billingAddress,
    required this.ticketUserInfos,
  });
  
  factory OrderReservedTicketsCommand.fromJson(Map<String, Object?> json) => _$OrderReservedTicketsCommandFromJson(json);
  
  final String customerFirstName;
  final String customerLastName;
  final AddressDto billingAddress;
  final List<AddTicketUserInfoDto> ticketUserInfos;

  Map<String, Object?> toJson() => _$OrderReservedTicketsCommandToJson(this);
}

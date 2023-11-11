// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'currency.dart';

part 'check_in_ticket_details_dto.g.dart';

@JsonSerializable()
class CheckInTicketDetailsDto {
  const CheckInTicketDetailsDto({
    required this.id,
    required this.userFirstName,
    required this.userLastName,
    required this.ticketName,
    required this.isCheckedIn,
    required this.price,
    required this.currency,
    required this.orderId,
    required this.created,
  });
  
  factory CheckInTicketDetailsDto.fromJson(Map<String, Object?> json) => _$CheckInTicketDetailsDtoFromJson(json);
  
  final String id;
  final String userFirstName;
  final String userLastName;
  final String ticketName;
  final bool isCheckedIn;
  final double price;
  final Currency currency;
  final String orderId;
  final DateTime created;

  Map<String, Object?> toJson() => _$CheckInTicketDetailsDtoToJson(this);
}

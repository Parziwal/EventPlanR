// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'check_in_ticket_dto.g.dart';

@JsonSerializable()
class CheckInTicketDto {
  const CheckInTicketDto({
    required this.id,
    required this.userFirstName,
    required this.userLastName,
    required this.ticketName,
    required this.isCheckedIn,
  });
  
  factory CheckInTicketDto.fromJson(Map<String, Object?> json) => _$CheckInTicketDtoFromJson(json);
  
  final String id;
  final String userFirstName;
  final String userLastName;
  final String ticketName;
  final bool isCheckedIn;

  Map<String, Object?> toJson() => _$CheckInTicketDtoToJson(this);
}

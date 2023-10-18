// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'add_ticket_user_info_dto.g.dart';

@JsonSerializable()
class AddTicketUserInfoDto {
  const AddTicketUserInfoDto({
    required this.ticketId,
    required this.userFirstName,
    required this.userLastName,
  });
  
  factory AddTicketUserInfoDto.fromJson(Map<String, Object?> json) => _$AddTicketUserInfoDtoFromJson(json);
  
  final String ticketId;
  final String userFirstName;
  final String userLastName;

  Map<String, Object?> toJson() => _$AddTicketUserInfoDtoToJson(this);
}

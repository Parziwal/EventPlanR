// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'invitation_status.dart';

part 'event_invitation_dto.g.dart';

@JsonSerializable()
class EventInvitationDto {
  const EventInvitationDto({
    required this.id,
    required this.userFirstName,
    required this.userLastName,
    required this.status,
    required this.isCheckedIn,
    required this.created,
    required this.createdBy,
  });
  
  factory EventInvitationDto.fromJson(Map<String, Object?> json) => _$EventInvitationDtoFromJson(json);
  
  final String id;
  final String userFirstName;
  final String userLastName;
  final InvitationStatus status;
  final bool isCheckedIn;
  final DateTime created;
  final String createdBy;

  Map<String, Object?> toJson() => _$EventInvitationDtoToJson(this);
}

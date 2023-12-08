// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'invitation_status.dart';

part 'user_invitation_dto.g.dart';

@JsonSerializable()
class UserInvitationDto {
  const UserInvitationDto({
    required this.id,
    required this.eventName,
    required this.organizationName,
    required this.status,
    required this.isCheckedIn,
    required this.created,
    this.ticketId,
  });
  
  factory UserInvitationDto.fromJson(Map<String, Object?> json) => _$UserInvitationDtoFromJson(json);
  
  final String id;
  final String? ticketId;
  final String eventName;
  final String organizationName;
  final InvitationStatus status;
  final bool isCheckedIn;
  final DateTime created;

  Map<String, Object?> toJson() => _$UserInvitationDtoToJson(this);
}

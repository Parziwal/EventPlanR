// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'event_invitation_dto.dart';

part 'event_invitation_dto_paginated_list_dto.g.dart';

@JsonSerializable()
class EventInvitationDtoPaginatedListDto {
  const EventInvitationDtoPaginatedListDto({
    required this.items,
    required this.pageNumber,
    required this.totalPages,
    required this.totalCount,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });
  
  factory EventInvitationDtoPaginatedListDto.fromJson(Map<String, Object?> json) => _$EventInvitationDtoPaginatedListDtoFromJson(json);
  
  final List<EventInvitationDto> items;
  final int pageNumber;
  final int totalPages;
  final int totalCount;
  final bool hasPreviousPage;
  final bool hasNextPage;

  Map<String, Object?> toJson() => _$EventInvitationDtoPaginatedListDtoToJson(this);
}

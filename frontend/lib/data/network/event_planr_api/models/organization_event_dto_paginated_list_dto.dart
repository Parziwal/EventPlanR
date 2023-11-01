// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'organization_event_dto.dart';

part 'organization_event_dto_paginated_list_dto.g.dart';

@JsonSerializable()
class OrganizationEventDtoPaginatedListDto {
  const OrganizationEventDtoPaginatedListDto({
    required this.items,
    required this.pageNumber,
    required this.totalPages,
    required this.totalCount,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });
  
  factory OrganizationEventDtoPaginatedListDto.fromJson(Map<String, Object?> json) => _$OrganizationEventDtoPaginatedListDtoFromJson(json);
  
  final List<OrganizationEventDto> items;
  final int pageNumber;
  final int totalPages;
  final int totalCount;
  final bool hasPreviousPage;
  final bool hasNextPage;

  Map<String, Object?> toJson() => _$OrganizationEventDtoPaginatedListDtoToJson(this);
}

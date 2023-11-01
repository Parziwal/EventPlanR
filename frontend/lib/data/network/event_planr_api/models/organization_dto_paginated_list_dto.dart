// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'organization_dto.dart';

part 'organization_dto_paginated_list_dto.g.dart';

@JsonSerializable()
class OrganizationDtoPaginatedListDto {
  const OrganizationDtoPaginatedListDto({
    required this.items,
    required this.pageNumber,
    required this.totalPages,
    required this.totalCount,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });
  
  factory OrganizationDtoPaginatedListDto.fromJson(Map<String, Object?> json) => _$OrganizationDtoPaginatedListDtoFromJson(json);
  
  final List<OrganizationDto> items;
  final int pageNumber;
  final int totalPages;
  final int totalCount;
  final bool hasPreviousPage;
  final bool hasNextPage;

  Map<String, Object?> toJson() => _$OrganizationDtoPaginatedListDtoToJson(this);
}

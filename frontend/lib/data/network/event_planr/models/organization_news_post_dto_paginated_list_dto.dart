// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'organization_news_post_dto.dart';

part 'organization_news_post_dto_paginated_list_dto.g.dart';

@JsonSerializable()
class OrganizationNewsPostDtoPaginatedListDto {
  const OrganizationNewsPostDtoPaginatedListDto({
    required this.items,
    required this.pageNumber,
    required this.totalPages,
    required this.totalCount,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });
  
  factory OrganizationNewsPostDtoPaginatedListDto.fromJson(Map<String, Object?> json) => _$OrganizationNewsPostDtoPaginatedListDtoFromJson(json);
  
  final List<OrganizationNewsPostDto> items;
  final int pageNumber;
  final int totalPages;
  final int totalCount;
  final bool hasPreviousPage;
  final bool hasNextPage;

  Map<String, Object?> toJson() => _$OrganizationNewsPostDtoPaginatedListDtoToJson(this);
}

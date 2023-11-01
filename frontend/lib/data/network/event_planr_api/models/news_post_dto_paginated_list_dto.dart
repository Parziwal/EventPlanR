// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'news_post_dto.dart';

part 'news_post_dto_paginated_list_dto.g.dart';

@JsonSerializable()
class NewsPostDtoPaginatedListDto {
  const NewsPostDtoPaginatedListDto({
    required this.items,
    required this.pageNumber,
    required this.totalPages,
    required this.totalCount,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });
  
  factory NewsPostDtoPaginatedListDto.fromJson(Map<String, Object?> json) => _$NewsPostDtoPaginatedListDtoFromJson(json);
  
  final List<NewsPostDto> items;
  final int pageNumber;
  final int totalPages;
  final int totalCount;
  final bool hasPreviousPage;
  final bool hasNextPage;

  Map<String, Object?> toJson() => _$NewsPostDtoPaginatedListDtoToJson(this);
}

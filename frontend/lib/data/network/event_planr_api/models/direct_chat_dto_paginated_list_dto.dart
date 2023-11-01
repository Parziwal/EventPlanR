// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'direct_chat_dto.dart';

part 'direct_chat_dto_paginated_list_dto.g.dart';

@JsonSerializable()
class DirectChatDtoPaginatedListDto {
  const DirectChatDtoPaginatedListDto({
    required this.items,
    required this.pageNumber,
    required this.totalPages,
    required this.totalCount,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });
  
  factory DirectChatDtoPaginatedListDto.fromJson(Map<String, Object?> json) => _$DirectChatDtoPaginatedListDtoFromJson(json);
  
  final List<DirectChatDto> items;
  final int pageNumber;
  final int totalPages;
  final int totalCount;
  final bool hasPreviousPage;
  final bool hasNextPage;

  Map<String, Object?> toJson() => _$DirectChatDtoPaginatedListDtoToJson(this);
}

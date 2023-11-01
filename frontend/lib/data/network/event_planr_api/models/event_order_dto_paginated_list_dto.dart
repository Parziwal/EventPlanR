// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'event_order_dto.dart';

part 'event_order_dto_paginated_list_dto.g.dart';

@JsonSerializable()
class EventOrderDtoPaginatedListDto {
  const EventOrderDtoPaginatedListDto({
    required this.items,
    required this.pageNumber,
    required this.totalPages,
    required this.totalCount,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });
  
  factory EventOrderDtoPaginatedListDto.fromJson(Map<String, Object?> json) => _$EventOrderDtoPaginatedListDtoFromJson(json);
  
  final List<EventOrderDto> items;
  final int pageNumber;
  final int totalPages;
  final int totalCount;
  final bool hasPreviousPage;
  final bool hasNextPage;

  Map<String, Object?> toJson() => _$EventOrderDtoPaginatedListDtoToJson(this);
}

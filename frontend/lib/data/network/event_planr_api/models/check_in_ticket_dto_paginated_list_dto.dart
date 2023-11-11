// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

import 'check_in_ticket_dto.dart';

part 'check_in_ticket_dto_paginated_list_dto.g.dart';

@JsonSerializable()
class CheckInTicketDtoPaginatedListDto {
  const CheckInTicketDtoPaginatedListDto({
    required this.items,
    required this.pageNumber,
    required this.totalPages,
    required this.totalCount,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });
  
  factory CheckInTicketDtoPaginatedListDto.fromJson(Map<String, Object?> json) => _$CheckInTicketDtoPaginatedListDtoFromJson(json);
  
  final List<CheckInTicketDto> items;
  final int pageNumber;
  final int totalPages;
  final int totalCount;
  final bool hasPreviousPage;
  final bool hasNextPage;

  Map<String, Object?> toJson() => _$CheckInTicketDtoPaginatedListDtoToJson(this);
}

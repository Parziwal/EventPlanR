// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'organization_ticket_dto.g.dart';

@JsonSerializable()
class OrganizationTicketDto {
  const OrganizationTicketDto({
    required this.created,
    required this.lastModified,
    required this.id,
    required this.name,
    required this.count,
    required this.remainingCount,
    required this.price,
    required this.saleStarts,
    required this.saleEnds,
    this.createdBy,
    this.lastModifiedBy,
    this.description,
  });
  
  factory OrganizationTicketDto.fromJson(Map<String, Object?> json) => _$OrganizationTicketDtoFromJson(json);
  
  final DateTime created;
  final String? createdBy;
  final DateTime lastModified;
  final String? lastModifiedBy;
  final String id;
  final String name;
  final int count;
  final int remainingCount;
  final double price;
  final String? description;
  final DateTime saleStarts;
  final DateTime saleEnds;

  Map<String, Object?> toJson() => _$OrganizationTicketDtoToJson(this);
}

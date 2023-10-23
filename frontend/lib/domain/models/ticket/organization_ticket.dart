import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_ticket.freezed.dart';
part 'organization_ticket.g.dart';

@freezed
class OrganizationTicket with _$OrganizationTicket {
  const factory OrganizationTicket({
    required DateTime created,
    required DateTime lastModified,
    required String id,
    required String name,
    required int count,
    required int remainingCount,
    required double price,
    required DateTime saleStarts,
    required DateTime saleEnds,
    String? createdBy,
    String? lastModifiedBy,
    String? description,
  }) = _OrganizationTicket;

  factory OrganizationTicket.fromJson(Map<String, Object?> json) =>
      _$OrganizationTicketFromJson(json);
}

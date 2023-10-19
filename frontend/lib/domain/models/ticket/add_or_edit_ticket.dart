import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_or_edit_ticket.freezed.dart';
part 'add_or_edit_ticket.g.dart';

@freezed
class AddOrEditTicket with _$AddOrEditTicket {
  const factory AddOrEditTicket({
    required double price,
    required int count,
    required DateTime saleStarts,
    required DateTime saleEnds,
    String? id,
    String? eventId,
    String? name,
    String? description,
  }) = _AddOrEditTicket;

  factory AddOrEditTicket.fromJson(Map<String, Object?> json) =>
      _$AddOrEditTicketFromJson(json);
}

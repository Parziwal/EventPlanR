import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_reserve_ticket.freezed.dart';
part 'add_reserve_ticket.g.dart';

@freezed
class AddReserveTicket with _$AddReserveTicket {
  const factory AddReserveTicket({
    required String ticketId,
    required int count,
  }) = _AddReserveTicket;

  factory AddReserveTicket.fromJson(Map<String, Object?> json) =>
      _$AddReserveTicketFromJson(json);
}

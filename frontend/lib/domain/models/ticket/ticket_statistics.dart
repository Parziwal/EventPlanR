import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_statistics.freezed.dart';

@freezed
class TicketStatistics with _$TicketStatistics {
  const factory TicketStatistics({
    required String id,
    required String ticketName,
    required int totalTicketCount,
    required int soldTicketCount,
    required int checkedInTicketCount,
  }) = _TicketStatistics;
}

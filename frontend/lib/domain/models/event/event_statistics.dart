import 'package:event_planr_app/domain/models/common/chart_spot.dart';
import 'package:event_planr_app/domain/models/event/currency_enum.dart';
import 'package:event_planr_app/domain/models/ticket/ticket_statistics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_statistics.freezed.dart';

@freezed
class EventStatistics with _$EventStatistics {
  const factory EventStatistics({
    required double totalIncome,
    required CurrencyEnum currency,
    required int totalTicketCount,
    required int soldTicketCount,
    required List<ChartSpot> soldTicketsPerDay,
    required List<ChartSpot> soldTicketsPerMonth,
    required List<TicketStatistics> ticketStatistics,
    required int totalCheckInCount,
    required List<ChartSpot> checkInsPerHour,
    required List<ChartSpot> checkInsPerDay,
    required int totalInvitationCount,
    required int acceptedInvitationCount,
    required int deniedInvitationCount,
    required int pendingInvitationCount,
  }) = _EventStatistics;
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_in_ticket_filter.freezed.dart';

@freezed
class CheckInTicketFilter with _$CheckInTicketFilter {
  const factory CheckInTicketFilter({
    required String eventId,
    int? pageNumber,
    int? pageSize,
  }) = _CheckInTicketFilter;
}

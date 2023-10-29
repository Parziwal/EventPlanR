import 'package:event_planr_app/domain/models/event/currency_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket.freezed.dart';

@freezed
class Ticket with _$Ticket {
  const factory Ticket({
    required String id,
    required String name,
    required double price,
    required CurrencyEnum currency,
    required int remainingCount,
    required DateTime saleEnds,
    String? description,
  }) = _Ticket;
}

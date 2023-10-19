import 'package:event_planr_app/domain/models/event/currency_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sold_ticket.freezed.dart';

@freezed
class SoldTicket with _$SoldTicket {
  const factory SoldTicket({
    required String id,
    required String userFirstName,
    required String userLastName,
    required double price,
    required CurrencyEnum currency,
    required String ticketName,
  }) = _SoldTicket;
}

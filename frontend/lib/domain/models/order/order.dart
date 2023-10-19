import 'package:event_planr_app/domain/models/common/address.dart';
import 'package:event_planr_app/domain/models/event/currency_enum.dart';
import 'package:event_planr_app/domain/models/ticket/sold_ticket.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';

@freezed
class Order with _$Order {
  const factory Order({
    required String customerFirstName,
    required String customerLastName,
    required Address billingAddress,
    required double total,
    required CurrencyEnum currency,
    required List<SoldTicket> soldTickets,
  }) = _Order;
}

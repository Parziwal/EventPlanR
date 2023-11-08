import 'package:event_planr_app/domain/models/event/currency_enum.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_order.freezed.dart';

@freezed
class EventOrder with _$EventOrder {
  const factory EventOrder({
    required String id,
    required String customerFirstName,
    required String customerLastName,
    required double total,
    required CurrencyEnum currency,
    required int ticketCount,
  }) = _EventOrder;

  const EventOrder._();

  String getUserFullName(BuildContext context) {
    return context.l10n.localeName == 'hu'
        ? '$customerLastName $customerFirstName'
        : '$customerFirstName $customerLastName';
  }
}
